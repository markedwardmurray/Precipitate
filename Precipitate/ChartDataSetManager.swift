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

struct ChartDataSetSettings {
    var label: String
    var lineColor: UIColor
    
    init(label: String, lineColor: UIColor) {
        self.label = label
        self.lineColor = lineColor
    }
    
    init(label: String) {
        self.init(label: label, lineColor: UIColor.blueColor())
    }
}

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
             var hourlyDataSetsTmp = [String: LineChartDataSet]()
            
            for (hourlyKey, dataEntrysArray) in dataEntryCollator.hourlyDataEntrys {
                let settings = ChartDataSetManager.settingsForKeys[hourlyKey]
                let label = settings?.label
                let hourlyDataSet = LineChartDataSet(yVals: dataEntrysArray, label: label)
                hourlyDataSet.setColor((settings?.lineColor)!)
                
                // settings for all lines //////
                hourlyDataSet.drawCirclesEnabled = false
                hourlyDataSet.drawValuesEnabled = false
                hourlyDataSet.lineWidth = 2.0
                ////////////////////////////////
                
                hourlyDataSetsTmp[hourlyKey] = hourlyDataSet
            }
            hourlyDataSets = hourlyDataSetsTmp
        } else {
            print("ChartDataSetManager - DataEntryCollator is nil")
        }
    }
    
    private func setDailyDataSets() {
        if let dataEntryCollator = dataEntryCollator {
            var dailyDataSetsTmp = [String: LineChartDataSet]()
            
            for (dailyKey, dataEntrysArray) in dataEntryCollator.dailyDataEntrys {
                let settings = ChartDataSetManager.settingsForKeys[dailyKey]
                let label = settings?.label
                let dailyDataSet = LineChartDataSet(yVals: dataEntrysArray, label: label)
                dailyDataSet.setColor((settings?.lineColor)!)
                
                // settings for all lines //////
                dailyDataSet.drawCirclesEnabled = false
                dailyDataSet.drawValuesEnabled = false
                dailyDataSet.lineWidth = 2.0
                ////////////////////////////////
                
                dailyDataSetsTmp[dailyKey] = dailyDataSet
            }
            dailyDataSets = dailyDataSetsTmp
        } else {
            print("ChartDataSetManager - DataEntryCollator is nil")
        }
    }
    
    static let settingsForKeys: [String : ChartDataSetSettings] =
    [
        "temperature" : ChartDataSetSettings(
            label: "Temp",
            lineColor: UIColor.temperature()
        ),
        "apparentTemperature" : ChartDataSetSettings(
            label: "Apparent Temp",
            lineColor: UIColor.apparentTemp()
        ),
        
        "temperatureMin" : ChartDataSetSettings(
            label: "Min Temp",
            lineColor: UIColor.temperature()
        ),
        "temperatureMax" : ChartDataSetSettings(
            label: "Max Temp",
            lineColor: UIColor.temperature()
        ),
        "apparentTemperatureMin" : ChartDataSetSettings(
            label: "App Min Temp",
            lineColor: UIColor.apparentTemp()
        ),
        "apparentTemperatureMax" : ChartDataSetSettings(
            label: "App Max Temp",
            lineColor: UIColor.apparentTemp()
        ),
        
        "precipProbability" : ChartDataSetSettings(
            label: "Precipitation Probability"
        ),
        "precipIntensity" : ChartDataSetSettings(
            label: "Expected Intensity"
        ),
        "precipIntensityMax" : ChartDataSetSettings(
            label: "Max Intensity",
            lineColor: UIColor.purpleColor()
        ),
        "precipAccumulation" : ChartDataSetSettings(
            label: "Accumulation"
        ),
        
        "windSpeed" : ChartDataSetSettings(
            label: "Wind Speed"
        ),
        "cloudCover" : ChartDataSetSettings(
            label: "Cloud Cover"
        ),
        "visibility" : ChartDataSetSettings(
            label: "Visibility"
        ),
        
        "ozone" : ChartDataSetSettings(
            label: "Ozone"
        ),
        "humidity" : ChartDataSetSettings(
            label: "Humidity"
        ),
        "dewPoint" : ChartDataSetSettings(
            label: "Dew Point"
        ),
        "pressure" : ChartDataSetSettings(
            label: "Pressure"
        )
    ]
}

