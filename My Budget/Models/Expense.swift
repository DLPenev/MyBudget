//
//  Expense.swift
//  My Budget

//- used to take all records for expense in db


import UIKit

struct Expense {
    var expenseId:       Int
    var date:            CLongLong
    var value:           Double
    var categoryId :     Int
    var subCategoryId:   Int
    var weekOfYear:      Int
    var subcategoryName: String
    
    
    init(fmresultSet: FMResultSet) {
        self.expenseId       = Int(fmresultSet.int(forColumn: globalTableConsts.fieldId))
        self.date            = CLongLong(fmresultSet.long(forColumn: globalTableConsts.fieldDate))
        self.value           = Double(fmresultSet.double(forColumn: globalTableConsts.fieldValue))
        self.categoryId      = Int(fmresultSet.int(forColumn: globalTableConsts.fieldCategoryId))
        self.subCategoryId   = Int(fmresultSet.int(forColumn: globalTableConsts.fieldSubcategoryId))
        self.weekOfYear      = Int(fmresultSet.int(forColumn: globalTableConsts.fieldWeekOfYear))
        self.subcategoryName =  fmresultSet.string(forColumn: globalTableConsts.fieldSubcategory) ?? ""

    }

    init(expenseId: Int, date: CLongLong, value:Double, categoryId :Int, subCategoryId:Int, weekOfYear:Int, subcategoryName: String) {
        self.expenseId       = expenseId
        self.date            = date
        self.value           = value
        self.categoryId      = categoryId
        self.subCategoryId   = subCategoryId
        self.weekOfYear      = weekOfYear
        self.subcategoryName = subcategoryName
    }
    
    init() {
        self.expenseId       = 0
        self.date            = 0
        self.value           = 0
        self.categoryId      = 0
        self.subCategoryId   = 0
        self.weekOfYear      = 0
        self.subcategoryName = String()
    }
}
