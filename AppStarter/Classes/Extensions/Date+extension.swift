//
//  Date+extension.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 22/03/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

extension Date {
    static func dateFrom(string: String, withFormat format: String? = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: string)
        
        return date
    }
    
    func getDayValue() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonthValue() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func getYearValue() -> Int {
        return Calendar.current.component(.year, from: self)
    }
}
