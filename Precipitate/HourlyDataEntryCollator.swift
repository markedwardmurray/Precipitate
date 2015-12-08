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

class HourlyDataEntryCollator: CustomDebugStringConvertible {
    let times: [Int]
    let sunriseTime: Int  // from daily data
    let sunsetTime: Int   // from daily data
    
    let temperatures: [ChartDataEntry]
    let apparentTemperatures: [ChartDataEntry]
    
    let precipProbabilitys: [ChartDataEntry]
    let precipIntensitys: [ChartDataEntry]
    let precipAccumulations: [ChartDataEntry]
    
    let windSpeeds: [ChartDataEntry]
    let cloudCovers: [ChartDataEntry]
    let visibilitys: [ChartDataEntry]
    
    let ozones: [ChartDataEntry]
    let humiditys: [ChartDataEntry]
    let dewPoints: [ChartDataEntry]
    let pressures: [ChartDataEntry]
    
    init(json: JSON) {
        sunriseTime = json["daily"]["data"][0]["sunriseTime"].int!
        sunsetTime = json["daily"]["data"][0]["sunsetTime"].int!
        
        let hourlyData = json["hourly"]["data"]
        
        var allTimes = [Int]()
        for var i = 0; i <= 24; i++ {
            if let time = hourlyData[i]["time"].int {
                allTimes.append(time)
            } else {
                print("error: no time in hourly data")
            }
        }
        times = allTimes
        
        temperatures = dataEntrysFromHourlyData(hourlyData, andKey: "temperature")
        apparentTemperatures = dataEntrysFromHourlyData(hourlyData, andKey: "apparentTemperature")
        precipProbabilitys = dataEntrysFromHourlyData(hourlyData, andKey: "precipProbability")
        precipIntensitys = dataEntrysFromHourlyData(hourlyData, andKey: "precipIntensity")
        precipAccumulations = dataEntrysFromHourlyData(hourlyData, andKey: "precipAccumulation")
        windSpeeds = dataEntrysFromHourlyData(hourlyData, andKey: "windSpeed")
        cloudCovers = dataEntrysFromHourlyData(hourlyData, andKey: "cloudCover")
        visibilitys = dataEntrysFromHourlyData(hourlyData, andKey: "visibility")
        ozones = dataEntrysFromHourlyData(hourlyData, andKey: "ozone")
        humiditys = dataEntrysFromHourlyData(hourlyData, andKey: "humidity")
        dewPoints = dataEntrysFromHourlyData(hourlyData, andKey: "dewPoints")
        pressures = dataEntrysFromHourlyData(hourlyData, andKey: "pressures")
    }
    
    var jsonKeysForDataEntrys: [String: [ChartDataEntry] ] { return
        [
            "temperature" : temperatures,
            "apparentTemperature" : apparentTemperatures,
            "precipProbability" : precipProbabilitys,
            "precipIntensity" : precipIntensitys,
            "precipAccumulation" : precipAccumulations,
            "windSpeed" : windSpeeds,
            "cloudCover" : cloudCovers,
            "visibility" : visibilitys,
            "ozone" : ozones,
            "humidity" : humiditys,
            "dewPoint" : dewPoints,
            "pressure" : pressures
        ]
    }
    
    var debugDescription: String { return self.getDebugDescription() }
    
    private func getDebugDescription() -> String {
        var result = "Hourly Data\n"
        result += "  sunriseTime = \(sunriseTime)\n"
        result += "  sunsetTime = \(sunsetTime)\n"
        
        for (jsonKey, dataEntrys) in jsonKeysForDataEntrys {
            result += "  \(jsonKey) ="
            
            for dataEntry in dataEntrys {
                result += "  \(dataEntry.value)"
            }
            result += "\n"
        }
        
        return result
    }
        
}

private func dataEntrysFromHourlyData(hourlyData: JSON, andKey jsonKey: String) -> [ChartDataEntry] {
    var dataEntrys = [ChartDataEntry]()
    
    for var i = 0; i <= 24; i++ {
        if let yVal = hourlyData[i][jsonKey].double {
            let dataEntry = ChartDataEntry(value: yVal, xIndex: i)
            dataEntrys.append(dataEntry)
        } else {
            let nilEntry = ChartDataEntry(value: 0.0, xIndex: i)
            dataEntrys.append(nilEntry)
        }
    }
    
    return dataEntrys
}


/* scrapped
static let jsonKeys: [String] =
[
"temperature", "apparentTemperature",
"precipProbability", "precipIntensity", "precipAccumulation",
"windSpeed", "cloudCover", "visibility",
"ozone", "humidity", "dewpoint", "pressure"
]

private func allDataEntrysFromHourlyData(hourlyData: JSON) -> Array<Array<ChartDataEntry>> {
    let jsonKeys = HourlyDataEntryCollator.jsonKeys
    
    var allDataEntrys = Array<Array<ChartDataEntry>>.init(count: jsonKeys.count, repeatedValue: [ChartDataEntry]())
    
    for var i = 0; i <= 24; i++ {
        for var j = 0; i < jsonKeys.count; j++ {
            let jsonKey = jsonKeys[i]
            
            if let yVal = hourlyData[i][jsonKey].double {
                let dataEntry = ChartDataEntry(value: yVal, xIndex: i)
                allDataEntrys[j].append(dataEntry)
            } else {
                let nilEntry = ChartDataEntry(value: 0.0, xIndex: i)
                allDataEntrys[j].append(nilEntry)
            }
        }
    }
    
    return allDataEntrys
}
*/



