//
//  LineChartDataManager.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON
import Charts

class LineChartDataManager {
    static let sharedInstance = LineChartDataManager()
    
    let chartDataSetManager = ChartDataSetManager.sharedInstance
    
    var json: JSON? {
        didSet {
            if let json = json {
                chartDataSetManager.collateDataEntrysFromJSON(json)
                self.setHourlyDatas()
                self.setDailyDatas()
            }
        }
    }
    
    private(set) var hourlyDatas: [String : LineChartData]?
    private(set) var dailyDatas: [String : LineChartData]?
    
    private func setHourlyDatas() {
        if let hourlyDataSets = chartDataSetManager.hourlyDataSets {
            let hours = chartDataSetManager.dataEntryCollator!.hours
            var hourStrings = [String]()
            for hour in hours {
                hourStrings.append("\(NSDate(timeIntervalSince1970: hour).hour)")
            }
            
            var hourlyDatasTemp = [String : LineChartData]()
            for (hourlyKey, hourlyDataSet) in hourlyDataSets {
                let lineChartData = LineChartData(xVals: hourStrings, dataSet: hourlyDataSet)
                
                // hourly chart data settings
                
                /////////////////////////////
                
                hourlyDatasTemp[hourlyKey] = lineChartData
            }
            hourlyDatas = hourlyDatasTemp
        }
    }
    
    private func setDailyDatas() {
        if let dailyDataSets = chartDataSetManager.dailyDataSets {
            let days = chartDataSetManager.dataEntryCollator!.days
            var dayStrings = [String]()
            for day in days {
                dayStrings.append("\(NSDate(timeIntervalSince1970: day).day)")
            }
            
            var dailyDatasTemp = [String : LineChartData]()
            for (dailyKey, dailyDataSet) in dailyDataSets {
                let lineChartData = LineChartData(xVals: dayStrings, dataSet: dailyDataSet)
                
                // daily chart data settings
                
                /////////////////////////////
                
                dailyDatasTemp[dailyKey] = lineChartData
            }
            dailyDatas = dailyDatasTemp
        }
    }
}
