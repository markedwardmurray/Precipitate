//
//  DataConverter.swift
//  Precipitate
//
//  Created by Mark Murray on 12/7/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON
import Charts

class DataConverter {
    static let sharedInstance = DataConverter()
    
    func hourlyHumidityDataFromJSON(json: JSON) -> LineChartDataSet {
        let hourlyData = json["hourly"]["data"]
        
        var hourlyHumidity = [ChartDataEntry]()
        
        for var i = 0; i < 25; i++ {
            let dataBlock = hourlyData[i]
            
            if let humidity = dataBlock["humidity"].double {
                
                let dataEntry = ChartDataEntry(value: humidity, xIndex: i)
                
                hourlyHumidity.append(dataEntry)
            }
        }
        
        
        let dataSet = LineChartDataSet(yVals: hourlyHumidity, label: "humidity")
//        dataSet.lineWidth = 2.0
//        dataSet.fillAlpha = 65/255.0
        dataSet.setColor(UIColor.blueColor())
        
        return dataSet
    }
}
