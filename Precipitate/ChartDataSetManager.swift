//
//  ChartDataSetManager.swift
//  Precipitate
//
//  Created by Mark Murray on 12/7/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON
import Charts

class ChartDataSetManager {
    static let sharedInstance = ChartDataSetManager()
    
    var dataEntryCollator: DataEntryCollator? {
        didSet {
            self.setHourlyDataSets()
            self.setDailyDataSets()
        }
    }
    func collateDataEntrysFromJSON(json: JSON) {
        dataEntryCollator = DataEntryCollator(json: json)
    }
    
    private(set) var hourlyDataSets: [String: LineChartDataSet]?
    private(set) var dailyDataSets: [String: LineChartDataSet]?
    
    private func setHourlyDataSets() {
        if let dataEntryCollator = dataEntryCollator {
             var hourlyDataSetsTemp = [String: LineChartDataSet]()
            
            for (hourlyKey, dataEntrysArray) in dataEntryCollator.hourlyDataEntrys {
                let label = ChartDataSetManager.hourlyLabelsForHourlyKeys[hourlyKey]
                let hourlyDataSet = LineChartDataSet(yVals: dataEntrysArray, label: label)
                
                // settings for individual lines
                hourlyDataSet.drawCirclesEnabled = false
                hourlyDataSet.drawValuesEnabled = false
                hourlyDataSet.setColor(UIColor.redColor())
                hourlyDataSet.lineWidth = 2.0
                ///////////////////////////////
                
                hourlyDataSetsTemp[hourlyKey] = hourlyDataSet
            }
            hourlyDataSets = hourlyDataSetsTemp
        } else {
            print("ChartDataSetManager - DataEntryCollator is nil")
        }
    }
    
    private func setDailyDataSets() {
        if let dataEntryCollator = dataEntryCollator {
            var dailyDataSetsTemp = [String: LineChartDataSet]()
            
            for (dailyKey, dataEntrysArray) in dataEntryCollator.dailyDataEntrys {
                let label = ChartDataSetManager.dailyLabelsForDailyKeys[dailyKey]
                let dailyDataSet = LineChartDataSet(yVals: dataEntrysArray, label: label)
                
                // settings for individual lines
                dailyDataSet.drawCirclesEnabled = false
                dailyDataSet.drawValuesEnabled = false
                dailyDataSet.setColor(UIColor.greenColor())
                dailyDataSet.lineWidth = 2.0
                ///////////////////////////////
                
                dailyDataSetsTemp[dailyKey] = dailyDataSet
            }
            dailyDataSets = dailyDataSetsTemp
        } else {
            print("ChartDataSetManager - DataEntryCollator is nil")
        }
    }

    static let hourlyLabelsForHourlyKeys: [String : String] =
    [
        "temperature" : "Temp",
        "apparentTemperature" : "Apparent Temp",
        
        "precipProbability" : "Precipitation Probability",
        "precipIntensity" : "Precipitation Intensity",
        "precipAccumulation" : "Precipitation Accumulation",
        
        "windSpeed" : "Wind Speed",
        "cloudCover" : "Cloud Cover",
        "visibility" : "Visibility",
        
        "ozone" : "Ozone",
        "humidity" : "Humidity",
        "dewpoint" : "Dew Point",
        "pressure" : "Pressure"
    ]
    
    static let dailyLabelsForDailyKeys: [String : String] =
    [
        "temperatureMin" : "Min Temp",
        "temperatureMax" : "Max Temp",
        "apparentTemperatureMin" : "App Min Temp",
        "apparentTemperatureMax" : "App Max Temp",
        
        "precipProbability" : "Precipitation Probability",
        "precipIntensity" : "Precipitation Intensity",
        "precipIntensityMax" : "Max Precip Intensity",
        
        "windSpeed" : "Wind Speed",
        "cloudCover" : "Cloud Cover",
        "visibility" : "Visibility",
        
        "ozone" : "Ozone",
        "humidity" : "Humidity",
        "dewpoint" : "Dew Point",
        "pressure" : "Pressure"
    ]
}

