//
//  HourlyDataEntryCollator.swift
//  Precipitate
//
//  Created by Mark Murray on 12/7/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON
import Charts

class DataEntryCollator {
    let hours: [NSTimeInterval]
    let sunriseTime: NSTimeInterval  // from daily data
    let sunsetTime: NSTimeInterval   // from daily data
    let hourlyDataEntrys: [String: [ChartDataEntry] ]
    
    let days: [NSTimeInterval]
    let dailyDataEntrys: [String: [ChartDataEntry] ]
    
    init(json: JSON) {
        
        let hourlyData = json["hourly"]["data"]
        let dailyData = json["daily"]["data"]
        
        sunriseTime = NSTimeInterval(dailyData[0]["sunriseTime"].double!)
        sunsetTime = NSTimeInterval(dailyData[0]["sunsetTime"].double!)
        
        hours = DataEntryCollator.allHoursFromHourlyData(hourlyData)
        hourlyDataEntrys = DataEntryCollator.dataEntrysFromHourlyData(hourlyData)
        
        days = DataEntryCollator.allDaysFromDailyData(dailyData)
        dailyDataEntrys = DataEntryCollator.dataEntrysFromDailyData(dailyData)
    }
    
    class private func allHoursFromHourlyData(hourlyData: JSON) -> [NSTimeInterval] {
        var allHours = [NSTimeInterval]()
        
        for var i = 0; i < hourlyData.count; i++ {
            if let time = hourlyData[i]["time"].double {
                let hour = NSTimeInterval(time)
                allHours.append(hour)
            } else {
                print("error: no time at index in hourly data")
            }
        }
        
        return allHours
    }
    
    class private func allDaysFromDailyData(dailyData: JSON) -> [NSTimeInterval] {
        var allDays = [NSTimeInterval]()
        
        for var i = 0; i < dailyData.count; i++ {
            if let time = dailyData[i]["time"].double {
                let day = NSTimeInterval(time)
                allDays.append(day)
            } else {
                print("error: no time at index in daily data")
            }
        }
        
        return allDays
    }
    
    class private func dataEntrysFromHourlyData(hourlyData: JSON) -> [String:[ChartDataEntry]] {
        var dataDictionary = [ String: [ChartDataEntry] ]()
        
        for hourlyKey in DataEntryCollator.hourlyKeys {
            var dataEntrys = [ChartDataEntry]()
            
            for var i = 0; i < hourlyData.count; i++ {
                if let yVal = hourlyData[i][hourlyKey].double {
                    let dataEntry = ChartDataEntry(value: yVal, xIndex: i)
                    dataEntrys.append(dataEntry)
                } else {
                    let nilEntry = ChartDataEntry(value: 0.0, xIndex: i)
                    dataEntrys.append(nilEntry)
                }
            }
            dataDictionary[hourlyKey] = dataEntrys
        }
        return dataDictionary
    }
    
    class private func dataEntrysFromDailyData(dailyData: JSON) -> [String:[ChartDataEntry]] {
        var dataDictionary = [ String: [ChartDataEntry] ]()
        
        for dailyKey in DataEntryCollator.dailyKeys {
            var dataEntrys = [ChartDataEntry]()
            
            for var i = 0; i < dailyData.count; i++ {
                if let yVal = dailyData[i][dailyKey].double {
                    let dataEntry = ChartDataEntry(value: yVal, xIndex: i)
                    dataEntrys.append(dataEntry)
                } else {
                    let nilEntry = ChartDataEntry(value: 0.0, xIndex: i)
                    dataEntrys.append(nilEntry)
                }
            }
            dataDictionary[dailyKey] = dataEntrys
        }
        return dataDictionary
    }
    
    static let hourlyKeys: [String] =
    [
        "temperature",
        "apparentTemperature",
        
        "precipProbability",
        "precipIntensity",
        "precipAccumulation",
        
        "windSpeed",
        "cloudCover",
        "visibility",
        
        "ozone",
        "humidity",
        "dewpoint",
        "pressure"
    ]
    
    static let dailyKeys: [String] =
    [
        "temperature",
        "temperatureMin",
        "temperatureMax",
        "apparentTemperature",
        "apparentTemperatureMin",
        "apparentTemperatureMax",
        
        "precipProbability",
        "precipIntensity",
        "precipIntensityMax",
        
        "windSpeed",
        "cloudCover",
        "visibility",
        
        "ozone",
        "humidity",
        "dewpoint",
        "pressure"
    ]

}

