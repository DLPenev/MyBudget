//
//  Expence.swift
//  My Budget
//
//  Created by MacUSER on 18.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class Expence: NSObject {
    var expenceId:     Int
    var date:          CLong
    var value:         Double
    var categoryId :   Int
    var subCategoryId: Int
    
    init(date: CLong, value: Double, categoryId: Int, subCategoryId: Int, expenceId: Int) {
        self.expenceId      = expenceId
        self.date           = date
        self.value          = value
        self.categoryId     = categoryId
        self.subCategoryId  = subCategoryId
    }
    
    init(fmresultSet: FMResultSet) {
        self.expenceId      = Int(fmresultSet.int(forColumn: fieldId))
        self.date           = CLong(fmresultSet.long(forColumn: fieldDate))
        self.value          = Double(fmresultSet.double(forColumn: fieldValue))
        self.categoryId     = Int(fmresultSet.int(forColumn: fieldCategoryId))
        self.subCategoryId  = Int(fmresultSet.int(forColumn: fieldSubcategoryId))
    }
    
}
