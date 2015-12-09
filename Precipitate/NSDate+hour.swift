//
//  NSDate+hour.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation

extension NSDate {
    static var hour: Int { return self.determineCurrentHour() }
        
    class private func determineCurrentHour() -> Int {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        
        return hour
    }
    
    class func allHoursFromNow() -> [String] {
        var hours = [String]()
        
        let now = NSDate.hour
        for var i = 0; i <= 24; i++ {
            let hour = now + i % 24
            hours.append(String(hour))
        }
        
        return hours
    }
}
