//
//  GlobalVariables.swift
//  My Budget
//
//  Created by MacUSER on 2.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

var globalUserDefaults   = UserDefaultsVars()
let globalTableConsts    = TableConsts()
let globalIdentificators = Identificators()
let globalCashStatus     = CashStatus()
let globalDateFormats    = DateFormats()
let globalIndexes        = Indexes()
let globalDateStruct     = DateStruct()
let globalStringsKeys    = LocalazableStringsKeys()
let globalMyColors       = MyColors()

var allCategoryesArray = [Category]()
let categoriesDefaultValues = ["Food & Drinks", "Shopping", "Housing", "Transportation", "Vehicle", "Life & Entertainment", "Communication, PC", "Financial expenses", "Investments", "Others"]

struct UserDefaultsVars {
    let userCurrecyKey    = "currency"
    let cashFlowIsSetKey  = "cashFlowIsSet"
    var userCurrecy       = (UserDefaults.standard.string(forKey: "currency")) ?? ""
    var cashFlowIsSet     = UserDefaults.standard.bool(forKey: "cashFlowIsSet")
}

struct TableConsts {
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
}

struct Identificators {
    let categoryCellId          = "categoryCellId"
    let tabBarControllerId      = "tabBarViewControllerId"
    let firstViewControllerId   = "FirstViewControllerId"
    let popupControllerId       = "popupViewControllerId"
    let segueToSubCategory      = "segueToSubCategoryViewController"
    let segueToPopup            = "showPopupSegueId"
    let unwindToPopUpViewId     = "unwindToPopUpViewControllerId"
    let segueToExpenseDetails   = "goToExpenseDetailViewControllerId"
    let segueToChooseCategoryId = "segueToChooseCategoryId"
    let segueToARId             = "goToARSegueId"
}

struct CashStatus {
    let statusRich    = (NSLocalizedString(globalStringsKeys.status1, comment: "") , #imageLiteral(resourceName: "richEmoji"))
    let statusGotSome = (NSLocalizedString(globalStringsKeys.status2, comment: "") , #imageLiteral(resourceName: "gotSomeEmoji"))
    let statusPoor    = (NSLocalizedString(globalStringsKeys.status3, comment: "") , #imageLiteral(resourceName: "poorEmoji"))
    let statusBroke   = (NSLocalizedString(globalStringsKeys.status4, comment: ""), #imageLiteral(resourceName: "brokeEmoji"))
}

struct DateFormats {
    let dateFormatTime     = "hh:mm a"
    let dateFormatWeekDay  = "EEEE"
    let dateFormatFullDate = "EEEE dd MMM"
}

struct Indexes {
    let popupIndexExpense = 0
    let popupIndexIncome  = 1
    let popupIndexEdit    = 2
    
    let overviewViewController      = 0
    let setUpCashFlowViewController = 1
    
    let tabBarOverviewIndex = 0
}

struct DateStruct {
    let dateInMilliseconds = Int(Date().timeIntervalSince1970 * 1000)
    let calendar           = Calendar.current
    let today              = Calendar.current.component(.day , from: Date())
    let thisWeek           = Calendar.current.component(.weekOfYear, from: Date())
    let thisMonth          = Calendar.current.component(.month, from: Date())
    let dateFormatter      = DateFormatter()
}

struct LocalazableStringsKeys {
    // overview view controller
    let balance                = "balance"
    let status1                = "status1"
    let status2                = "status2"
    let status3                = "status3"
    let status4                = "status4"

    //categoryes
    let categoryFood           = "categoryFood"
    let categoryShopping       = "categoryShopping"
    let categoryHousing        = "categoryHousing"
    let categoryTransportation = "categoryTransportation"
    let categoryVehicle        = "categoryVehicle"
    let categoryLife           = "categoryLife"
    let categoryComunication   = "categoryComunication"
    let categoryFinancial      = "categoryFinancial"
    let categoryInvestments    = "categoryInvestments"
    let categoryOthers         = "categoryOthers"
    //popup
    let buttonEdit             = "buttonEdit"
    let buttonDelete           = "buttonDelete"
    
    let today                  = "today"
    let thisWeek               = "thisWeek"
    let thisMonth              = "thisMonth"

}

struct MyColors {
    let colorRed      = UIColor(red:1.00, green:0.07, blue:0.07, alpha:1.0)
    let colorBlue     = UIColor(red:0.16, green:0.79, blue:0.97, alpha:1.0)
    let colorOrange   = UIColor(red:1.00, green:0.72, blue:0.27, alpha:1.0)
    let colorDarkGray = UIColor(red:0.36, green:0.43, blue:0.49, alpha:1.0)
    let colorPurple   = UIColor(red:0.74, green:0.11, blue:0.98, alpha:1.0)
    let colorGreen    = UIColor(red:0.05, green:0.90, blue:0.02, alpha:1.0)
    let colorDarkBlue = UIColor(red:0.16, green:0.45, blue:0.65, alpha:1.0)
    let colorSeaGreen = UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.0)
    let colotPink     = UIColor(red:0.98, green:0.19, blue:0.62, alpha:1.0)
    let colorGray     = UIColor(red:0.67, green:0.70, blue:0.73, alpha:1.0)
}


