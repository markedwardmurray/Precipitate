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
    let units: String
    let formatter: IValueFormatter
    let dataKeys: [String]
    
    init(label: String, units: String, formatter: IValueFormatter, dataKeys: [String]) {
        self.label = label
        self.units = units
        self.formatter = formatter
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
        let hoursFormatter = NSDateFormatter.selectedHoursFormatter()
        
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
                let lineChartData = LineChartData(dataSets: chartDataSets)

                lineChartData.setValueFormatter(hourlyChartSetting.formatter)
                
                let chartLabel = hourlyChartSetting.label
                hourlyDatasTmp[chartLabel] = lineChartData
            }
            hourlyDatas = hourlyDatasTmp
        }
    }
    
    private func setDailyDatas() {
        let daysFormatter = NSDateFormatter.selectedDaysFormatter()
                
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
                
                let lineChartData = LineChartData(dataSets: chartDataSets)
                lineChartData.setValueFormatter(dailyChartSetting.formatter)
                
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
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["apparentTemperature", "temperature"]
            ),
            
            LineChartDataSettings(
                label: "Precipitation Probability",
                units: units.forPercentage.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.percentageFormatter(),
                dataKeys: ["precipProbability"]
            ),
            LineChartDataSettings(
                label: "Rainfall (Liquid Volume)",
                units: units.forPrecipIntensity.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.precipitationFormatter(),
                dataKeys: ["precipIntensity"]
            ),
            LineChartDataSettings(
                label: "Snowfall",
                units: units.forPrecipAccumulation.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.precipitationFormatter(),
                dataKeys: ["precipAccumulation"]
            ),
            
            LineChartDataSettings(
                label: "Wind Speed",
                units: units.forSpeed.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["windSpeed"]
            ),
            LineChartDataSettings(
                label: "Cloud Cover",
                units: units.forPercentage.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.percentageFormatter(),
                dataKeys: ["cloudCover"]
            ),
            LineChartDataSettings(
                label:"Visibility",
                units: units.forDistance.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["visibility"]
            ),
            
            LineChartDataSettings(
                label: "Ozone",
                units: units.forOzone.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["ozone"]
            ),
            LineChartDataSettings(
                label: "Humidity",
                units: units.forPercentage.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.percentageFormatter(),
                dataKeys: ["humidity"]
            ),
            LineChartDataSettings(
                label: "Dew Point",
                units: units.forTemperature.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["dewPoint"]
            ),
            LineChartDataSettings(
                label: "Pressure",
                units: units.forPressure.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
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
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["apparentTemperatureMin", "apparentTemperatureMax", "temperatureMin", "temperatureMax"]
            ),
            
            LineChartDataSettings(
                label: "Precipitation Probability",
                units: units.forPercentage.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.percentageFormatter(),
                dataKeys: ["precipProbability"]
            ),
            LineChartDataSettings(
                label: "Precipitation (Liquid Volume)",
                units: units.forPrecipIntensity.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.precipitationFormatter(),
                dataKeys: ["precipIntensityMax", "precipIntensity"]
            ),
            
            LineChartDataSettings(
                label: "Wind Speed",
                units: units.forSpeed.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["windSpeed"]
            ),
            LineChartDataSettings(
                label:"Cloud Cover",
                units: units.forPercentage.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.percentageFormatter(),
                dataKeys: ["cloudCover"]
            ),
            LineChartDataSettings(
                label:"Visibility",
                units: units.forDistance.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["visibility"]
            ),
            
            LineChartDataSettings(
                label: "Ozone",
                units: units.forOzone.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["ozone"]
            ),
            LineChartDataSettings(
                label: "Humidity",
                units: units.forPercentage.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.percentageFormatter(),
                dataKeys: ["humidity"]
            ),
            LineChartDataSettings(
                label: "Dew Point",
                units: units.forTemperature.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["dewPoint"]
            ),
            LineChartDataSettings(
                label: "Pressure",
                units: units.forPressure.short,
                formatter: DefaultValueFormatter(), // NSNumberFormatter.integerFormatter(),
                dataKeys: ["pressure"]
            )
        ]
        
        return dailyChartSettings
    }
}
