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
    
    var pathToDatabase = String()
    var budgetDB: FMDatabase!
    
    override init() {
        super.init()
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        self.pathToDatabase = documentsDirectory.appending("/\(self.databaseFileName)")
    }
    
    func createDatabaseIfNotExists(){
        
        if !FileManager.default.fileExists(atPath: self.pathToDatabase) {
            self.budgetDB = FMDatabase(path: self.pathToDatabase)
            if self.budgetDB != nil {
                initDB()
            }
        }
        print(self.pathToDatabase)
    }
    
    func initDB(){
    
        let foodAndDrinksDefaultValues     = ["Groceries","Fast-food","Restaurant","Bar, cafe"]
        let shoppingDefaultValues          = ["Clothes & Shoes","Jewels, Accessories","Health and Beauty","Kids","Home, Garden","Pets, Animals","Accessories","Gifts, Joy","Stationery, Tools","Free time","Drug-store, Chemist"]
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
            
            if (self.budgetDB.open()) {
                if !(self.budgetDB.executeStatements(sqlStatement)) {
                    print("Error: \(self.budgetDB.lastErrorMessage())")
                }
                self.budgetDB.close()
            } else {
                print("Error: \(self.budgetDB.lastErrorMessage())")
            }
        }

        func insertCategoriesDefaultValues(table: String, categoriesArray: Array<String>){
            if openDatabase() {
                DBManager.singleton.budgetDB.beginTransaction()
                
                for category in categoriesArray{
                    let insertSQL = "INSERT INTO \(table) (\(globalTableConsts.fieldCategory)) VALUES (?)"
                    
                    let result = self.budgetDB.executeUpdate(insertSQL, withArgumentsIn: [category])
                    
                    if !result {
                        print("Error: \(self.budgetDB.lastErrorMessage())")
                    } else {
                        print ("Category Added")
                    }
                }
                DBManager.singleton.budgetDB.commit()
                self.budgetDB.close()
            } else {
                DBManager.singleton.budgetDB.rollback()
                print("Error: \(self.budgetDB.lastErrorMessage())")
            }
        }
        
        func insertSubCategoriesDefaultValues(table: String, allSubCategories: Dictionary<String, [String]>){
            if openDatabase() {
                DBManager.singleton.budgetDB.beginTransaction()
                
                for (category,subCategoriesArray) in allSubCategories{

                    let categoryIndex = categoriesDefaultValues.index(of: category)
                    let categoryId = categoryIndex! + 1

                    for category in subCategoriesArray {
                      
                        let insertSQL = "INSERT INTO \(table) (\(globalTableConsts.fieldSubcategory), \(globalTableConsts.fieldCategoryId) ) VALUES (?,?)"
                        let result = self.budgetDB.executeUpdate(insertSQL, withArgumentsIn: [category, categoryId])

                        if !result {
                            print("Error: \(self.budgetDB.lastErrorMessage())")
                        } else {
                            print ("SubCategory Added")
                        }

                    }
                }
                DBManager.singleton.budgetDB.commit()
                self.budgetDB.close()
            } else {
                DBManager.singleton.budgetDB.rollback()
                print("Error: \(self.budgetDB.lastErrorMessage())")
            }
        }
        
        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(globalTableConsts.tableCategories) ( \(globalTableConsts.fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(globalTableConsts.fieldCategory) TEXT)")

        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(globalTableConsts.tableSubCategories) ( \(globalTableConsts.fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(globalTableConsts.fieldSubcategory) TEXT, \(globalTableConsts.fieldCategoryId) INTEGER, foreign key(\(globalTableConsts.fieldCategoryId)) references \(globalTableConsts.tableCategories)(\(globalTableConsts.fieldId)) )")
        
        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(globalTableConsts.tableExpenses) ( \(globalTableConsts.fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(globalTableConsts.fieldDate) INTEGER, \(globalTableConsts.fieldWeekOfYear) INTEGER, \(globalTableConsts.fieldValue) DOUBLE, \(globalTableConsts.fieldSubcategoryId) INTEGER, FOREIGN KEY(\(globalTableConsts.fieldSubcategoryId)) REFERENCES \(globalTableConsts.tableSubCategories)(\(globalTableConsts.fieldId)) )")
        
        createTable(sqlStatement: "CREATE TABLE IF NOT EXISTS \(globalTableConsts.tableCashFlow) ( \(globalTableConsts.fieldId) INTEGER PRIMARY KEY AUTOINCREMENT, \(globalTableConsts.fieldRegularIncome) INTEGER, \(globalTableConsts.fieldRegularExpense) INTEGER, \(globalTableConsts.fieldSavingPercentage) INTEGER, \(globalTableConsts.fieldCurrency) STRING ) ")
        
        insertCategoriesDefaultValues(table: globalTableConsts.tableCategories, categoriesArray: categoriesDefaultValues)
        insertSubCategoriesDefaultValues(table: globalTableConsts.tableSubCategories, allSubCategories: subCategoriesDefaultValues)
        insertCashFlowDefaultValues()
    }
    
    func insertCashFlowDefaultValues(){
        if openDatabase() {
            
            let defaultValue = 0
            
            let insertSQL = "INSERT INTO \(globalTableConsts.tableCashFlow) (\(globalTableConsts.fieldRegularIncome), \(globalTableConsts.fieldRegularExpense), \(globalTableConsts.fieldSavingPercentage) ) VALUES (?,?,?)"
            let result = self.budgetDB.executeUpdate(insertSQL, withArgumentsIn: [defaultValue, defaultValue, defaultValue])
            
            if !result {
                print("Error: \(self.budgetDB.lastErrorMessage())")
            } else {
                print ("Cash Flow Added")
            }
            self.budgetDB.close()
        } else {
            print("Error: \(self.budgetDB.lastErrorMessage())")
        }
    }
    
    func updateCashFlowValues(income: Int, expense: Int, savings: Int, currensy: String){
        if openDatabase() {
            
            let insertSQL = "UPDATE \(globalTableConsts.tableCashFlow) SET \(globalTableConsts.fieldRegularIncome) = ? , \(globalTableConsts.fieldRegularExpense) = ? , \(globalTableConsts.fieldSavingPercentage) = ?, \(globalTableConsts.fieldCurrency) = ?  WHERE ID = 1 "
            let result = self.budgetDB.executeUpdate(insertSQL, withArgumentsIn: [income, expense, savings, currensy])
            
            if !result {
                print("Error: \(self.budgetDB.lastErrorMessage())")
            } else {
                print ("Cash Flow Updated")
            }
            self.budgetDB.close()
        } else {
            print("Error: \(self.budgetDB.lastErrorMessage())")
        }
    }
    
    func updateExpense(value: Double, subcategory: Int, date: CLongLong, expenseId: Int ){
        if openDatabase() {
            
            let weekOfYear = date.getWeekOfYearFromDateInMillisec(dateInMillisec: date)
 
            let insertSQL = "UPDATE \(globalTableConsts.tableExpenses) SET \(globalTableConsts.fieldValue) = ? ,\(globalTableConsts.fieldWeekOfYear) = ? , \(globalTableConsts.fieldSubcategoryId) = ? , \(globalTableConsts.fieldDate) = ?  WHERE ID = \(expenseId) "
            let result = self.budgetDB.executeUpdate(insertSQL, withArgumentsIn: [value, weekOfYear, subcategory, date, expenseId])
            
            if !result {
                print("Error: \(self.budgetDB.lastErrorMessage())")
            } else {
                print ("Expense Updated")
            }
            self.budgetDB.close()
        } else {
            print("Error: \(self.budgetDB.lastErrorMessage())")
        }
    }
    
    func insertInExpenseTable(value: Double, subcategory: Int){
        
        if openDatabase() {
            
            let insertSQL = "INSERT INTO \(globalTableConsts.tableExpenses) (\(globalTableConsts.fieldDate), \(globalTableConsts.fieldValue), \(globalTableConsts.fieldSubcategoryId), \(globalTableConsts.fieldWeekOfYear) ) VALUES (?,?,?,?)"
            let result = self.budgetDB.executeUpdate(insertSQL, withArgumentsIn: [globalDateStruct.dateInMilliseconds, value, subcategory, globalDateStruct.thisWeek])
            
            if !result {
                print("Error: \(self.budgetDB.lastErrorMessage())")
            } else {
                print ("Expense Added")
            }
            self.budgetDB.close()
        } else {
            print("Error: \(self.budgetDB.lastErrorMessage())")
        }
    }
    
    func openDatabase() -> Bool {
        if self.budgetDB == nil {
            if FileManager.default.fileExists(atPath: self.pathToDatabase) {
                self.budgetDB = FMDatabase(path: self.pathToDatabase)
            }
        }
        if self.budgetDB != nil {
            if self.budgetDB.open() {
                return true
            }
        }
        return false
    }
    
    func loadSubCategories(categoryId: Int) -> [(subcategoryId: Int,subcategoryName: String)] {

        var categories:[(Int,  String)] = []
        if openDatabase() {
            let query = "select * from \(globalTableConsts.tableSubCategories) where \(globalTableConsts.fieldCategoryId) = \(categoryId)"
            
            do {
                let results = try self.budgetDB.executeQuery(query, values: nil)
                
                while results.next() {
                    categories.append(( Int(results.int(forColumn: globalTableConsts.fieldId)), results.string(forColumn: globalTableConsts.fieldSubcategory)!))
                }
            }
            catch {
                print(error.localizedDescription)
            }
            self.budgetDB.close()
        }
        return categories
    }
    
    func loadExpenses() -> [Expense] {
        
        var expenses:[Expense] = []
        if openDatabase() {
          
            let  query = "select \(globalTableConsts.tableExpenses).\(globalTableConsts.fieldId) ,\(globalTableConsts.tableExpenses).\(globalTableConsts.fieldDate), \(globalTableConsts.tableExpenses).\(globalTableConsts.fieldValue), \(globalTableConsts.tableExpenses).\(globalTableConsts.fieldSubcategoryId), \(globalTableConsts.tableSubCategories).\(globalTableConsts.fieldCategoryId) , \(globalTableConsts.tableSubCategories).\(globalTableConsts.fieldSubcategory) from \(globalTableConsts.tableExpenses) inner join \(globalTableConsts.tableSubCategories) on \(globalTableConsts.tableSubCategories).\(globalTableConsts.fieldId) = \(globalTableConsts.tableExpenses).\(globalTableConsts.fieldSubcategoryId) "
            
            do {
                let results = try self.budgetDB.executeQuery(query, values: nil)
                
                while results.next() {
                    expenses.append(Expense(fmresultSet: results))
                }
            }
            catch {
                print(error.localizedDescription)
            }
            self.budgetDB.close()
        }
        return expenses
    }
    
    func getCashFlow()->(income:Double,expense:Double,savingsPercentage:Double, currency: String){
        var income            = 0.0
        var expense           = 0.0
        var savingsPercentage = 0.0
        var currency          = ""
        
        let query = "select * from \(globalTableConsts.tableCashFlow)"
        
        if openDatabase() {
            do {
                let result = try self.budgetDB.executeQuery(query, values: nil)
                while result.next() {
                    income            = Double(result.int(forColumn: globalTableConsts.fieldRegularIncome))
                    expense           = Double(result.int(forColumn: globalTableConsts.fieldRegularExpense))
                    savingsPercentage = Double(result.int(forColumn: globalTableConsts.fieldSavingPercentage))
                    currency          = result.string(forColumn: globalTableConsts.fieldCurrency) ?? "cant get currancy?"
                }
            }
            catch {
                print(error.localizedDescription)
            }
            self.budgetDB.close()
        }
        return (income,expense,savingsPercentage, currency)
    }
    
    func deleteAttribute(table:String,attributeID:Int){
        
        if openDatabase() {
            
            let deleteSQL = "delete from \(table) where id = \(attributeID)"
            
            let result = self.budgetDB.executeUpdate(deleteSQL, withArgumentsIn: [])
            
            if !result {
                print("Error: \(self.budgetDB.lastErrorMessage())")
            } else {
                print ("Attribute deleted")
            }
            self.budgetDB.close()
        } else {
            print("Error: \(self.budgetDB.lastErrorMessage())")
        }
    }
    
}
