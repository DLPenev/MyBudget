//
//  Extensions.swift
//  My Budget
//
//  Created by MacUSER on 22.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
