//
//  NSDate+Timescales.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation

extension NSDate {
    var hour: Int { return NSCalendar.currentCalendar().components([.Hour], fromDate: self).hour }
    var day: Int { return NSCalendar.currentCalendar().components([.Day], fromDate: self).day }
}
