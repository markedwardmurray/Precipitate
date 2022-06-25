//
//  NSNumberFormatter+Formatters.swift
//  Precipitate
//
//  Created by Mark Murray on 2/28/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation

extension NSNumberFormatter {
    class func percentageFormatter() -> NSNumberFormatter {
        let percentageFormatter = NSNumberFormatter()
        percentageFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        percentageFormatter.generatesDecimalNumbers = false
        
        return percentageFormatter
    }
    
    class func integerFormatter() -> NSNumberFormatter {
        let integerFormatter = NSNumberFormatter()
        integerFormatter.generatesDecimalNumbers = false
        
        return integerFormatter
    }
    
    class func precipitationFormatter() -> NSNumberFormatter {
        let precipitationFormatter = NSNumberFormatter()
        precipitationFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        precipitationFormatter.generatesDecimalNumbers = true
        precipitationFormatter.maximumFractionDigits = 2
        
        return precipitationFormatter
    }
}
