//
//  NSDateFormatter+Formatters.swift
//  Precipitate
//
//  Created by Mark Murray on 2/28/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension NSDateFormatter {
    
    class func selectedHoursFormatter() -> NSDateFormatter {
        if let hoursSetting = Defaults["hours"].int {
            switch hoursSetting {
            case 0: // 24-hour
                return self.twentyFourHourFormatter()
            case 1: // 12-hour
                return self.twelveHourFormatter()
            default:
                return self.twentyFourHourFormatter()
            }
        } else {
            return self.twentyFourHourFormatter()
        }
    }
    
    class func twentyFourHourFormatter() -> NSDateFormatter {
        let twentyFourHourFormatter = NSDateFormatter()
        twentyFourHourFormatter.dateFormat = "HH"
        
        return twentyFourHourFormatter
    }

    class func twelveHourFormatter() -> NSDateFormatter {
        let twelveHourFormatter = NSDateFormatter()
        twelveHourFormatter.dateFormat = "ha"
        twelveHourFormatter.AMSymbol = "a"
        twelveHourFormatter.PMSymbol = "p"
        
        return twelveHourFormatter
    }
    
    class func selectedDaysFormatter() -> NSDateFormatter {
        if let daysSetting = Defaults["days"].int {
            switch daysSetting {
            case 0: // Day of Month
                return self.dayOfMonthFormatter()
            case 1: // Weekday Letter
                return self.weekdayLetterFormatter()
            default:
                return self.dayOfMonthFormatter()
            }
        } else {
            return self.dayOfMonthFormatter()
        }
    }
    
    class func dayOfMonthFormatter() -> NSDateFormatter {
        let dayOfMonthFormatter = NSDateFormatter()
        dayOfMonthFormatter.dateFormat = "d"
        
        return dayOfMonthFormatter
    }
    
    class func weekdayLetterFormatter() -> NSDateFormatter {
        let weekdayLetterFormatter = NSDateFormatter()
        weekdayLetterFormatter.dateFormat = "EEEEEE"
        
        return weekdayLetterFormatter
    }
}
