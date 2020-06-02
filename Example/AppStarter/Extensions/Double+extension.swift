//
//  Double+extension.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 04/04/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

extension Double {
    func getStringWithDecimal(_ digits:Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        numberFormatter.currencyDecimalSeparator = "."
        numberFormatter.currencyGroupingSeparator = ","
        numberFormatter.maximumFractionDigits = digits
        numberFormatter.minimumFractionDigits = digits
        numberFormatter.alwaysShowsDecimalSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = ","
        numberFormatter.groupingSeparator = "."
        let returnString = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        return returnString
    }
}
