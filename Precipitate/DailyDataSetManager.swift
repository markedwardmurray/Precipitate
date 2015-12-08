//
//  DailyDataSetManager.swift
//  Precipitate
//
//  Created by Mark Murray on 12/7/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON
import Charts

class DailyDataSetManager {
    static let sharedInstance = DailyDataSetManager()
        
    var time: [Int]?
    
    var temperature: [LineChartDataSet]?
    var temperatureMin: [LineChartDataSet]?
    var temperatureMax: [LineChartDataSet]?
    var apparentTemperature: [LineChartDataSet]?
    var apparentTemperatureMin: [LineChartDataSet]?
    var apparentTemperatureMax: [LineChartDataSet]?
    
    var precipProbability: [LineChartDataSet]?
    var precipIntensity: [LineChartDataSet]?
    var precipIntensityMax: [LineChartDataSet]?
    
    var windSpeed: [LineChartDataSet]?
    var cloudCover: [LineChartDataSet]?
    var visibility: [LineChartDataSet]?
    
    var ozone: [LineChartDataSet]?
    var humidity: [LineChartDataSet]?
    var dewPoint: [LineChartDataSet]?
    var pressure: [LineChartDataSet]?
    
}

