//
//  CategoryConstructor.swift
//  My Budget
//
//  Created by MacUSER on 9.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class Category: NSObject {
    var categoryEnumName: String
    var categoryFullName: String
    var categoryIcon: UIImage
    var categoryColor: UIColor
    
    init(categoryEnumName: String, categoryFullName: String, categoryIcon: UIImage, categoryColor: UIColor) {
        self.categoryEnumName = categoryEnumName
        self.categoryFullName = categoryFullName
        self.categoryIcon     = categoryIcon
        self.categoryColor    = categoryColor
    }
}
