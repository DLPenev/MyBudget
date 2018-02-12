//
//  Extensions.swift
//  My Budget
//
//  Created by MacUSER on 22.01.18.
//  Copyright © 2018 MacUSER. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

extension String {
    func getTimeOrDateToString(dateInMillisec: CLongLong, format: String)->String{
        let date = Date(milliseconds: Int(dateInMillisec))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func doubleFormater(value: Double)->String{
        return String(format: "%.02f", value)
    }
}

extension CLongLong {
    func getWeekOfYearFromDateInMillisec(dateInMillisec: CLongLong)->Int{
        let date = Date(milliseconds: Int(dateInMillisec))
        let weekOfYear = globalDateStruct.calendar.component(.weekOfYear, from: date)
        return weekOfYear
    }
}








