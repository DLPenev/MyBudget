//
//  SumExpense.swift
//  My Budget

//- used to represent all expenses by categoryes in overview view controller


import UIKit

class SumExpense: NSObject {

    var categoryIcon:          UIImage
    var categoryColor:         UIColor
    var categoryFullName:      String
    var value:                 Double
    var procentOfTotalExpense: Double
    var categoryPrimaryKey:    Int
    
    init(categoryIcon: UIImage, categoryColor:UIColor, categoryFullName:String, value:Double, procentOfTotalExpense:Double,categoryPrimaryKey:Int ) {
            self.categoryIcon          = categoryIcon
            self.categoryColor         = categoryColor
            self.categoryFullName      = categoryFullName
            self.value                 = value
            self.procentOfTotalExpense = procentOfTotalExpense
            self.categoryPrimaryKey    = categoryPrimaryKey
        }
    

}
