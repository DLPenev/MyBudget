//
//  DBManager.swift
//  PhoneBook
//
//  Created by MacUSER on 10/20/17.
//  Copyright © 2017 MacUSER. All rights reserved.
//

import UIKit  

class DBManager: NSObject {

    static let singleton: DBManager = DBManager()
    
    let databaseFileName = "budgetDB.db"
    
    var pathToDatabase: String!
    var budgetDB: FMDatabase!
    
    override init() {
        super.init()
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            budgetDB = FMDatabase(path: pathToDatabase!)
            if budgetDB != nil {
                initDB()
               // openDatabase()
                created = true
            }
        }
        print(pathToDatabase)
        return created
    }
    
    func initDB(){
        
//        let categoriesDefaultValues = ["Food & Drinks", "Shopping", "Housing", "Transportation", "Vehicle", "Life & Entertainment", "Communication, PC", "Financial expenses", "Investments", "Others"]
        
        let foodAndDrinksDefaultValues     = ["Groceries","Fast-food","Restaurant","Bar, cafe"]
        let shoppingDefaultValues          = ["Clothes & Shoes","Jewels, Accessories","Health and Beauty","Kids","Home, Garden","Pets, Animals","Electronics, Accessories","Gifts, Joy","Stationery, Tools","Free time","Drug-store, Chemist"]
        let housingDefaultValues           = ["Rent","Mortgage","Energy, Utilities","Services","Maintenance, Repairs"]
        let transportationDefaultValues    = ["Public transport","Taxi","Long distance","Business trips"]
        let vehicleDefaultValues           = ["Fuel","Parking","Vehicle maintenance","Rentals","Vehicle insurance","Leasing"]
        let lifeAndEntertainment           = ["Health care, Doctor","Wellness, Beauty","Active sport, Fitness","Culture, Sport events","Life events","Hobbies","Holiday, Trips","Alcohol","Tabacco"]
        let communicationDefaultValues     = ["Phone, Cell phone","Internet","Software, games","Apps","Postal services"]
        let financialExpensesDefaultValues = ["Taxes","Insurances","Loan, Interests","Fines","Advisory","Charges, Fees"]
        let investmentsDefaultValues         = ["Realty","Vehicles","Finacial investments","Savings","Collections"]
        let others                         = ["Other"]
   
        let subCategoriesDefaultValues = ["Food & Drinks"        : foodAndDrinksDefaultValues,
                                          "Shopping"             : shoppingDefaultValues,
                                          "Housing"              : housingDefaultValues,
                                          "Transportation"       : transportationDefaultValues,
                                          "Vehicle"              : vehicleDefaultValues,
                                          "Life & Entertainment" : lifeAndEntertainment,
                                          "Communication, PC"    : communicationDefaultValues,
                                          "Financial expenses"   : financialExpensesDefaultValues,
                                          "Investments"          : investmentsDefaultValues,
                                          "Others"               : others]
        
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

        func insertCategoriesDefaultValues(table: String, categoriesArray: Array<String>){
            if openDatabase() {
                DBManager.singleton.budgetDB.beginTransaction()
                
                for category in categoriesArray{
                    let insertSQL = "INSERT INTO \(table) (\(fieldCategory)) VALUES (?)"
                    
                    let result = budgetDB.executeUpdate(insertSQL, withArgumentsIn: [category])
                    
                    if !result {
                        print("Error: \(budgetDB.lastErrorMessage())")
                    } else {
                        print ("Category Added")
                    }
                }
                DBManager.singleton.budgetDB.commit()
                budgetDB.close()
            } else {
                DBManager.singleton.budgetDB.rollback()
                print("Error: \(budgetDB.lastErrorMessage())")
            }
        }
        
        func insertSubCategoriesDefaultValues(table: String, allSubCategories: Dictionary<String, [String]>){
            if openDatabase() {
                DBManager.singleton.budgetDB.beginTransaction()
                
                for (category,subCategoriesArray) in allSubCategories{

                    let categoryIndex = categoriesDefaultValues.index(of: category)
                    let categoryId = categoryIndex! + 1

                    for category in subCategoriesArray {
                      
                        let insertSQL = "INSERT INTO \(table) (\(fieldSubcategory), \(fieldCategoryId) ) VALUES (?,?)"
                        let result = budgetDB.executeUpdate(insertSQL, withArgumentsIn: [category, categoryId])

                        if !result {
                            print("Error: \(budgetDB.lastErrorMessage())")
                        } else {
                            print ("SubCategory Added")
                        }

                    }
                }
                DBManager.singleton.budgetDB.commit()
                budgetDB.close()
            } else {
                DBManager.singleton.budgetDB.rollback()
                print("Error: \(budgetDB.lastErrorMessage())")
            }
        }
        
        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(tableCategories) ( \(fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(fieldCategory) TEXT)")

        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(tableSubCategories) ( \(fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(fieldSubcategory) TEXT, \(fieldCategoryId) INTEGER, foreign key(\(fieldCategoryId)) references \(tableCategories)(\(fieldId)) )")
        
        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(tableExpenses) ( \(fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(fieldDate) INTEGER, \(fieldValue) DOUBLE, \(fieldSubcategoryId) INTEGER, FOREIGN KEY(\(fieldSubcategoryId)) REFERENCES \(tableSubCategories)(\(fieldId)) )")
        
        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(tableCashFlow) ( \(fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(fieldRegularIncome) INTEGER, \(fieldRegularExpence) INTEGER, \(fieldSavingProcentage) INTEGER  ) ")
        
        insertCategoriesDefaultValues(table: tableCategories, categoriesArray: categoriesDefaultValues)
        insertSubCategoriesDefaultValues(table: tableSubCategories, allSubCategories: subCategoriesDefaultValues)
        insertCashFlowDefaultValues(income: 0, expense: 0, savings: 0)
    }
    
    func insertCashFlowDefaultValues(income: Int, expense: Int, savings: Int){
        if openDatabase() {
            
            let insertSQL = "INSERT INTO \(tableCashFlow) (\(fieldRegularIncome), \(fieldRegularExpence), \(fieldSavingProcentage) ) VALUES (?,?,?)"
            let result = budgetDB.executeUpdate(insertSQL, withArgumentsIn: [income, expense, savings])
            
            if !result {
                print("Error: \(budgetDB.lastErrorMessage())")
            } else {
                print ("Cash Flow Added")
            }
            budgetDB.close()
        } else {
            print("Error: \(budgetDB.lastErrorMessage())")
        }
    }
    
    func updateCashFlowValues(income: Int, expense: Int, savings: Int){
        if openDatabase() {
            
            let insertSQL = "UPDATE \(tableCashFlow) SET \(fieldRegularIncome) = ? , \(fieldRegularExpence) = ? , \(fieldSavingProcentage) = ?  WHERE ID = 1 "
            let result = budgetDB.executeUpdate(insertSQL, withArgumentsIn: [income, expense, savings])
            
            if !result {
                print("Error: \(budgetDB.lastErrorMessage())")
            } else {
                print ("Cash Flow Updated")
            }
            budgetDB.close()
        } else {
            print("Error: \(budgetDB.lastErrorMessage())")
        }
    }
    
    func openDatabase() -> Bool {
        if budgetDB == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                budgetDB = FMDatabase(path: pathToDatabase)
            }
        }
        if budgetDB != nil {
            if budgetDB.open() {
                return true
            }
        }
        return false
    }
    
    func loadSubCategories(categoryId: Int) -> [String] {
        var categories: [String]!
        if openDatabase() {
            let query = "select * from \(tableSubCategories) where \(fieldCategoryId) = \(categoryId)"
            
            do {
                let results = try budgetDB.executeQuery(query, values: nil)
                
                while results.next() {
                    
                    let subCategoty = results.string(forColumn: fieldSubcategory)
                    
                    if categories == nil {
                        categories = [String]()
                    }
                    categories.append(subCategoty!)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            budgetDB.close()
        }
        return categories
    }
    
}
