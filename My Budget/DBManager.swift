//
//  DBManager.swift
//  My Budget
//
//  Created by MacUSER on 2.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class DBManager: NSObject {
    
    static let shared: DBManager = DBManager()
    
    let databaseFileName = "budgetDB.db"
    
    var pathToDatabase: String!
    var budgetDB: FMDatabase!
    
    override init() {
        super.init()
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
        print(pathToDatabase)
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
                created = true
        }
        return created
    }
    
    func initDB(){
        func createTable(sqlStatement: String){
            if (budgetDB.open()) {
                if !(budgetDB.executeStatements(sqlStatement)) {
                    print("Error: \(budgetDB.lastErrorMessage())")
                }
                budgetDB.close()
            } else {
                print("Error: \(budgetDB.lastErrorMessage())")
            }
        }
        
       
        
    }
    
    
    
    
    

}
