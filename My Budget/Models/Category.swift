//
//  CategoryConstructor.swift

// - used to show list of all categories

import UIKit

struct Category {
    
    var categoryPK:       Int
    var categoryFullName: String
    var categoryIcon:     UIImage
    var categoryColor:    UIColor
    
    init(categoryPK: Int, categoryFullName: String, categoryIcon: UIImage, categoryColor: UIColor) {
        self.categoryPK       = categoryPK
        self.categoryFullName = categoryFullName
        self.categoryIcon     = categoryIcon
        self.categoryColor    = categoryColor
    }
    
    init() {
        self.categoryPK       =  0
        self.categoryFullName =  ""
        self.categoryIcon     =  UIImage()
        self.categoryColor    =  UIColor()
    }
    
}
