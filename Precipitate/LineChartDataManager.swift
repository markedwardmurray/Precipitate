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
    
//    private func forecastUnitsOptionFromJSON(json: JSON) -> ForecastUnitsOption {
//        let flag = json["flags"]["units"]
//        switch flag {
//            case "us":
//            return ForecastUnitsOption.US
//            case "si":
//            return ForecastUnitsOption.SI
//            case "uk2":
//            return ForecastUnitsOption.UK2
//            case "ca":
//            return ForecastUnitsOption.CA
//        }
//    }
    
    private func setHourlyDatas() {
        if let hourlyDataSets = chartDataSetManager.hourlyDataSets {
            let hours = chartDataSetManager.dataEntryCollator!.hours
            var hourStrings = [String]()
            for hour in hours {
                hourStrings.append("\(NSDate(timeIntervalSince1970: hour).hour)")
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
        if let dailyDataSets = chartDataSetManager.dailyDataSets {
            let days = chartDataSetManager.dataEntryCollator!.days
            var dayStrings = [String]()
            for day in days {
                dayStrings.append("\(NSDate(timeIntervalSince1970: day).day)")
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
                units: units.forPercentage.short,
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
