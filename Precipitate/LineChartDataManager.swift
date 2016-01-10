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

struct LineChartDataSettings {
    let label: String
    let dataKeys: [String]
    
    init(label: String, dataKeys: [String]) {
        self.label = label
        self.dataKeys = dataKeys
    }
}

class LineChartDataManager {
    static let sharedInstance = LineChartDataManager()
    
    let chartDataSetManager = ChartDataSetManager.sharedInstance
    
    var json: JSON? {
        didSet {
            if let json = json {
                self.chartDataSetManager.collateDataEntrysFromJSON(json)
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
            
            var hourlyDatasTmp = [String : LineChartData]()
            for hourlyChartSetting in LineChartDataManager.hourlyChartSettings {
                var chartDataSets = [LineChartDataSet]()
                for dataKey in hourlyChartSetting.dataKeys {
                    if let chartDataSet = hourlyDataSets[dataKey] {
                        chartDataSets.append(chartDataSet)
                    }
                }
                
                let lineChartData = LineChartData(xVals: hourStrings, dataSets: chartDataSets)
                let chartLabel = hourlyChartSetting.label
                hourlyDatasTmp[chartLabel] = lineChartData
            }
            hourlyDatas = hourlyDatasTmp
        }
    }
    
    private func setDailyDatas() {
        if let dailyDataSets = chartDataSetManager.dailyDataSets {
            let days = chartDataSetManager.dataEntryCollator!.days
            var dayStrings = [String]()
            for day in days {
                dayStrings.append("\(NSDate(timeIntervalSince1970: day).day)")
            }
            
            var dailyDatasTmp = [String : LineChartData]()
            for dailyChartSetting in LineChartDataManager.dailyChartSettings {
                var chartDataSets = [LineChartDataSet]()
                for dataKey in dailyChartSetting.dataKeys {
                    if let chartDataSet = dailyDataSets[dataKey] {
                        chartDataSets.append(chartDataSet)
                    }
                }
                
                let lineChartData = LineChartData(xVals: dayStrings, dataSets: chartDataSets)
                let chartLabel = dailyChartSetting.label
                dailyDatasTmp[chartLabel] = lineChartData
            }
            dailyDatas = dailyDatasTmp
        }
    }
    
    static let hourlyChartSettings: [LineChartDataSettings] =
    [
        LineChartDataSettings(
            label: "Temperature",
            dataKeys: ["temperature", "apparentTemperature"]
        ),
        
        LineChartDataSettings(
            label: "Precipitation Probability",
            dataKeys: ["precipProbability"]
        ),
        LineChartDataSettings(
            label: "Precipitation Intensity",
            dataKeys: ["precipIntensity"]
        ),
        LineChartDataSettings(
            label: "Precipitation Accumulation",
            dataKeys: ["precipAccumulation"]
        ),
        
        LineChartDataSettings(
            label: "Wind Speed",
            dataKeys: ["windSpeed"]
        ),
        LineChartDataSettings(
            label:"Cloud Cover",
            dataKeys: ["cloudCover"]
        ),
        LineChartDataSettings(
            label:"Visibility",
            dataKeys: ["visibility"]
        ),
    
        LineChartDataSettings(
            label: "Ozone",
            dataKeys: ["ozone"]
        ),
        LineChartDataSettings(
            label: "Humidity",
            dataKeys: ["humidity"]
        ),
        LineChartDataSettings(
            label: "Dew Point",
            dataKeys: ["dewPoint"]
        ),
        LineChartDataSettings(
            label: "Pressure",
            dataKeys: ["pressure"]
        )
    ]
    
    static let dailyChartSettings: [LineChartDataSettings] =
    [
        LineChartDataSettings(
            label: "Temperature",
            dataKeys: ["temperatureMin", "temperatureMax", "apparentTemperatureMin", "apparentTemperatureMax"]
        ),
        
        LineChartDataSettings(
            label: "Precipitation Probability",
            dataKeys: ["precipProbability"]
        ),
        LineChartDataSettings(
            label: "Precipitation Intensity",
            dataKeys: ["precipIntensity", "precipIntensityMax"]
        ),
        
        LineChartDataSettings(
            label: "Wind Speed",
            dataKeys: ["windSpeed"]
        ),
        LineChartDataSettings(
            label:"Cloud Cover",
            dataKeys: ["cloudCover"]
        ),
        LineChartDataSettings(
            label:"Visibility",
            dataKeys: ["visibility"]
        ),
        
        LineChartDataSettings(
            label: "Ozone",
            dataKeys: ["ozone"]
        ),
        LineChartDataSettings(
            label: "Humidity",
            dataKeys: ["humidity"]
        ),
        LineChartDataSettings(
            label: "Dew Point",
            dataKeys: ["dewPoint"]
        ),
        LineChartDataSettings(
            label: "Pressure",
            dataKeys: ["pressure"]
        )
    ]

}
