//
//  WeatherData.swift
//  Precipitate
//
//  Created by Mark Murray on 10/12/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let hourly: Hourly?
    
    struct Hourly: Codable {
        let summary: String
        let icon: String
        let data: [HourlyData]
        
        struct HourlyData: Codable {
            let time: Date
            let summary: String
            let icon: String
            let precipIntensity: Double
            let precipProbability: Double
            let precipType: String?
            let temperature: Double
            let apparentTemperature: Double
            let dewPoint: Double
            let humidity: Double
            let windSpeed: Double
            let windBearing: Int
            let windGust: Double
            let uvIndex: Int
            let visibility: Double
            let cloudCover: Double
            let pressure: Double
            let ozone: Double
        }
    }
}
