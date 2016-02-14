//
//  LineChartDataManager.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import Charts
import SwiftyJSON
import SwiftyDate
import SwiftyUserDefaults

struct LineChartDataSettings {
    let label: String
    var units: String
    let dataKeys: [String]
    
    init(label: String, units: String, dataKeys: [String]) {
        self.label = label
        self.units = units
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
                self.units = ForecastUnits(option: ForecastUnits.optionFromJSON(json))
            }
        }
    }
    
    private(set) var hourlyDatas: [String : LineChartData]?
    private(set) var dailyDatas: [String : LineChartData]?
    private(set) var units: ForecastUnits = ForecastUnits(option: ForecastUnitsOption.US)
    
    private func setHourlyDatas() {
        let hoursFormatter = NSDateFormatter()
        
        print("hours setting: \(Defaults["hours"].int)")
        if let hoursSetting = Defaults["hours"].int {
            switch hoursSetting {
            case 0: // 24-hour
                hoursFormatter.dateFormat = "HH"
            case 1: // 12-hour
                hoursFormatter.dateFormat = "ha"
                hoursFormatter.AMSymbol = "a"
                hoursFormatter.PMSymbol = "p"
            default:
                hoursFormatter.dateFormat = "HH"
            }
        } else {
            hoursFormatter.dateFormat = "HH"
        }
        
        if let hourlyDataSets = chartDataSetManager.hourlyDataSets {
            let hours = chartDataSetManager.dataEntryCollator!.hours
            var hourStrings = [String]()
            for hour in hours {
                let hourString = hoursFormatter.stringFromDate(NSDate(timeIntervalSince1970:hour))
                
                hourStrings.append(hourString)
            }
            
            var hourlyDatasTmp = [String : LineChartData]()
            
            for hourlyChartSetting in self.hourlyChartSettings() {
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
        let daysFormatter = NSDateFormatter()
        
        print("days setting: \(Defaults["days"].int)")
        if let daysSetting = Defaults["days"].int {
            switch daysSetting {
            case 0: // Day of Month
                daysFormatter.dateFormat = "d"
            case 1: // Weekday Letter
                daysFormatter.dateFormat = "EEEEEE"
            default:
                daysFormatter.dateFormat = "d"
            }
        } else {
            daysFormatter.dateFormat = "d"
        }
        
        if let dailyDataSets = chartDataSetManager.dailyDataSets {
            let days = chartDataSetManager.dataEntryCollator!.days
            var dayStrings = [String]()
            for day in days {
                let dayString = daysFormatter.stringFromDate(NSDate(timeIntervalSince1970:day))
                
                dayStrings.append(dayString)
            }
            
            var dailyDatasTmp = [String : LineChartData]()
            
            for dailyChartSetting in self.dailyChartSettings() {
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
    
    func hourlyChartSettings() -> [LineChartDataSettings] {
        
        let hourlyChartSettings: [LineChartDataSettings] =
        [
            LineChartDataSettings(
                label: "Temperature",
                units: self.units.forTemperature.short,
                dataKeys: ["temperature", "apparentTemperature"]
            ),
            
            LineChartDataSettings(
                label: "Precipitation Probability",
                units: units.forPercentage.short,
                dataKeys: ["precipProbability"]
            ),
            LineChartDataSettings(
                label: "Rainfall (Liquid Precipitation)",
                units: units.forPrecipIntensity.short,
                dataKeys: ["precipIntensity"]
            ),
            LineChartDataSettings(
                label: "Snowfall",
                units: units.forPrecipAccumulation.short,
                dataKeys: ["precipAccumulation"]
            ),
            
            LineChartDataSettings(
                label: "Wind Speed",
                units: units.forSpeed.short,
                dataKeys: ["windSpeed"]
            ),
            LineChartDataSettings(
                label: "Cloud Cover",
                units: units.forPercentage.short,
                dataKeys: ["cloudCover"]
            ),
            LineChartDataSettings(
                label:"Visibility",
                units: units.forDistance.short,
                dataKeys: ["visibility"]
            ),
            
            LineChartDataSettings(
                label: "Ozone",
                units: units.forOzone.short,
                dataKeys: ["ozone"]
            ),
            LineChartDataSettings(
                label: "Humidity",
                units: units.forPercentage.short,
                dataKeys: ["humidity"]
            ),
            LineChartDataSettings(
                label: "Dew Point",
                units: units.forTemperature.short,
                dataKeys: ["dewPoint"]
            ),
            LineChartDataSettings(
                label: "Pressure",
                units: units.forPressure.short,
                dataKeys: ["pressure"]
            )
        ]
        
        return hourlyChartSettings
    }
    
    func dailyChartSettings() -> [LineChartDataSettings] {
        
        let dailyChartSettings: [LineChartDataSettings] =
        [
            LineChartDataSettings(
                label: "Temperature",
                units: units.forTemperature.short,
                dataKeys: ["temperatureMin", "temperatureMax", "apparentTemperatureMin", "apparentTemperatureMax"]
            ),
            
            LineChartDataSettings(
                label: "Precipitation Probability",
                units: units.forPercentage.short,
                dataKeys: ["precipProbability"]
            ),
            LineChartDataSettings(
                label: "Rainfall (Liquid Precipitation)",
                units: units.forPrecipIntensity.short,
                dataKeys: ["precipIntensity", "precipIntensityMax"]
            ),
            
            LineChartDataSettings(
                label: "Wind Speed",
                units: units.forSpeed.short,
                dataKeys: ["windSpeed"]
            ),
            LineChartDataSettings(
                label:"Cloud Cover",
                units: units.forPercentage.short,
                dataKeys: ["cloudCover"]
            ),
            LineChartDataSettings(
                label:"Visibility",
                units: units.forDistance.short,
                dataKeys: ["visibility"]
            ),
            
            LineChartDataSettings(
                label: "Ozone",
                units: units.forOzone.short,
                dataKeys: ["ozone"]
            ),
            LineChartDataSettings(
                label: "Humidity",
                units: units.forPercentage.short,
                dataKeys: ["humidity"]
            ),
            LineChartDataSettings(
                label: "Dew Point",
                units: units.forTemperature.short,
                dataKeys: ["dewPoint"]
            ),
            LineChartDataSettings(
                label: "Pressure",
                units: units.forPressure.short,
                dataKeys: ["pressure"]
            )
        ]
        
        return dailyChartSettings
    }
}
