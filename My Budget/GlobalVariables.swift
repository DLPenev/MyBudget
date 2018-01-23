//
//  GlobalVariables.swift
//  My Budget
//
//  Created by MacUSER on 2.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

enum Categories: Int {
    case foodAndDrinks
    case shopping
    case housing
    case transportation
    case vehicle
    case life
    case communication
    case financialExpenses
    case investments
    case others
    case sectionsCount
}
// conisider remove ^^

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
let fieldRegularIncome    = "regular_Income"
let fieldRegularExpense   = "regular_Expense"
let fieldSavingProcentage = "savings_Procentage"
let fieldWeekOfYear       = "week_of_year"

let tabBarCOntrollerId  = "tabBarViewControllerId"
let segueToSubCategory  = "segueToSubCategoryViewController"
let unwindToPopUpViewId = "unwindToPopUpViewControllerId"

var allCategoryesArray = [Category]()

let timeInterval = Date().timeIntervalSince1970
let dateInMilliseconds = Int(timeInterval * 1000)
let calendar = Calendar.current
let today      = calendar.component(.day , from: Date())
let thisWeek   = calendar.component(.weekOfYear, from: Date())
let thisMonth  = calendar.component(.month, from: Date())
let dateFormatter = DateFormatter()


let categoriesDefaultValues = ["Food & Drinks", "Shopping", "Housing", "Transportation", "Vehicle", "Life & Entertainment", "Communication, PC", "Financial expenses", "Investments", "Others"]

class GlobalVariables: NSObject {

}
