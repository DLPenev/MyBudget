//
//  GlobalVariables.swift
//  My Budget
//
//  Created by MacUSER on 2.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

enum SectionsNewContact: Int {
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
let fieldRegularExpence   = "regular_Expence"
let fieldSavingProcentage = "savings_Procentage"

let tabBarCOntrollerId  = "tabBarViewControllerId"
let segueToSubCategory  = "segueToSubCategoryViewController"
let unwindToPopUpViewId = "unwindToPopUpViewControllerId"

var allCategoryesArray = [Category]()


let categoriesDefaultValues = ["Food & Drinks", "Shopping", "Housing", "Transportation", "Vehicle", "Life & Entertainment", "Communication, PC", "Financial expenses", "Investments", "Others"]

class GlobalVariables: NSObject {

}
