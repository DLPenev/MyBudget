//
//  GlobalVariables.swift
//  My Budget
//
//  Created by MacUSER on 2.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

let tableExpenses      = "expenses"
let tableCategories    = "categories"
let tableSubCategories = "subCategories"
let tableCashFlow      = "cashFlow"

let fieldDate             = "date"
let fieldValue            = "value"
let fieldSubcategory      = "subcategory"
let fieldSubcategoryId    = "subcategory_Id"
let fieldCategory         = "category"
let fieldCategoryId       = "category_Id"
let fieldId               = "id"
let fieldCurrency         = "currency"
let fieldRegularIncome    = "regular_Income"
let fieldRegularExpense   = "regular_Expense"
let fieldSavingPercentage = "savings_Percentage"
let fieldWeekOfYear       = "week_of_year"

let categoryCellId        = "categoryCellId"
let tabBarControllerId    = "tabBarViewControllerId"
let popupControllerId     = "popupViewControllerId"
let segueToSubCategory    = "segueToSubCategoryViewController"
let segueToPopup          = "showPopupSegueId"
let unwindToPopUpViewId   = "unwindToPopUpViewControllerId"
let segueToExpenseDetails = "goToExpenseDetailViewControllerId"

let statusRich    = ("You are in the money" , #imageLiteral(resourceName: "richEmoji"))
let statusGotSome = ("You still got some money" , #imageLiteral(resourceName: "gotSomeEmoji"))
let statusPoor    = ("You are low on money" , #imageLiteral(resourceName: "poorEmoji"))
let statusBroke   = ("You Are Broke" , #imageLiteral(resourceName: "brokeEmoji"))

let dateFormatTime     = "hh:mm a"
let dateFormatWeekDay  = "EEEE"
let dateFormatFullDate = "EEEE dd MMM"

let popupIndexExpense = 0
let popupIndexIncome  = 1
let popupIndexEdit    = 2

var usedCurrensy       = (UserDefaults.standard.string(forKey: "currency")) ?? ""
var allCategoryesArray = [Category]()

let timeInterval       = Date().timeIntervalSince1970
let dateInMilliseconds = Int(timeInterval * 1000)
let calendar           = Calendar.current
let today              = calendar.component(.day , from: Date())
let thisWeek           = calendar.component(.weekOfYear, from: Date())
let thisMonth          = calendar.component(.month, from: Date())
let dateFormatter      = DateFormatter()

let categoriesDefaultValues = ["Food & Drinks", "Shopping", "Housing", "Transportation", "Vehicle", "Life & Entertainment", "Communication, PC", "Financial expenses", "Investments", "Others"]

class Global: NSObject {
    
    static let singleton: Global = Global()
    
    func doubleFormater(value: Double)->String{
       return String(format: "%.02f", value)
    }
    
    func getTimeOrDateToString(dateInMillisec: CLongLong, format: String)->String{
        let date = Date(milliseconds: Int(dateInMillisec))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func getWeekOfYearFromDateInMillisec(dateInMillisec: CLongLong)->Int{
        let date = Date(milliseconds: Int(dateInMillisec))
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        return weekOfYear
    }
}
