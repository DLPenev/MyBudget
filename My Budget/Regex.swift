//
//  Regexr.swift
//  My Budget
//
//  Created by MacUSER on 30.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import UIKit

class Regex: NSObject {
    
}

extension String {

    var isValidExpense: Bool {
        
        let expenseFormat = "[0-9,.]{1,5}"
        let expenseTest = NSPredicate(format: "SELF MATCHES %@", expenseFormat)
        let result =  expenseTest.evaluate(with: self)
        return result
    }
    
}
