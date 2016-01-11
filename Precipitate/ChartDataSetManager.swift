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
    var unitOfMeasure: String
    var lineColor: UIColor
    
    init(label: String, unitOfMeasure: String, lineColor: UIColor) {
        self.label = label
        self.unitOfMeasure = unitOfMeasure
        self.lineColor = lineColor
    }
    
    init(label: String, unitOfMeasure: String) {
        self.init(label: label, unitOfMeasure: unitOfMeasure, lineColor: UIColor.blueColor())
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
            label: "Temp (°F)",
            unitOfMeasure: "°F",
            lineColor: UIColor.temperature()
        ),
        "apparentTemperature" : ChartDataSetSettings(
            label: "Apparent Temp (°F)",
            unitOfMeasure: "°F",
            lineColor: UIColor.apparentTemp()
        ),
        
        "temperatureMin" : ChartDataSetSettings(
            label: "Min Temp (°F)",
            unitOfMeasure: "°F",
            lineColor: UIColor.temperature()
        ),
        "temperatureMax" : ChartDataSetSettings(
            label: "Max Temp (°F)",
            unitOfMeasure: "°F",
            lineColor: UIColor.temperature()
        ),
        "apparentTemperatureMin" : ChartDataSetSettings(
            label: "App Min Temp (°F)",
            unitOfMeasure: "°F",
            lineColor: UIColor.apparentTemp()
        ),
        "apparentTemperatureMax" : ChartDataSetSettings(
            label: "App Max Temp (°F)",
            unitOfMeasure: "°F",
            lineColor: UIColor.apparentTemp()
        ),
        
        "precipProbability" : ChartDataSetSettings(
            label: "Precipitation Probability (%)",
            unitOfMeasure: "%"
        ),
        "precipIntensity" : ChartDataSetSettings(
            label: "Precipitation Intensity (in/hr)",
            unitOfMeasure: "inches/hour"
        ),
        "precipIntensityMax" : ChartDataSetSettings(
            label: "Max Precip Intensity (in/hr)",
            unitOfMeasure: "inches/hour",
            lineColor: UIColor.purpleColor()
        ),
        "precipAccumulation" : ChartDataSetSettings(
            label: "Precipitation Accumulation (in)",
            unitOfMeasure: "inches"
        ),
        
        "windSpeed" : ChartDataSetSettings(
            label: "Wind Speed (mph)",
            unitOfMeasure: "mph"
        ),
        "cloudCover" : ChartDataSetSettings(
            label: "Cloud Cover (%)",
            unitOfMeasure: "%"
        ),
        "visibility" : ChartDataSetSettings(
            label: "Visibility (miles)",
            unitOfMeasure: "miles"
        ),
        
        "ozone" : ChartDataSetSettings(
            label: "Ozone (DU)",
            unitOfMeasure: "Dobson Units"
        ),
        "humidity" : ChartDataSetSettings(
            label: "Humidity (%)",
            unitOfMeasure: "%"
        ),
        "dewPoint" : ChartDataSetSettings(
            label: "Dew Point (°F)",
            unitOfMeasure: "°F"
        ),
        "pressure" : ChartDataSetSettings(
            label: "Pressure (mbar)",
            unitOfMeasure: "millibars"
        )
    ]
}

