//
//  WeatherData.swift
//  Precipitate
//
//  Created by Mark Murray on 10/12/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import Foundation

protocol DataBlockType: Codable {}

struct Weather: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let offset: Int
    
    let currently: Currently?
    let minutely: DataBlock<Minutely>?
    let hourly: DataBlock<Hourly>?
    let daily: DataBlock<Daily>?
    let alerts: [WeatherAlert]?
    let flags: Flags?
}

struct Currently: DataBlockType {
    let time: Date
    let summary: String
    let icon: String
    let temperature: Double
    let apparentTemperature: Double
    let cloudCover: Double
    let dewPoint: Double
    let humidity: Double
    let nearestStormBearing: Int?
    let nearestStormDistance: Double
    let ozone: Double
    let precipIntensity: Double
    let precipProbability: Double
    let precipType: String?
    let pressure: Double
    let uvIndex: Double
    let visibility: Double
    let windBearing: Double
    let windGust: Double
    let windSpeed: Double
}

struct DataBlock<T: DataBlockType>: Codable {
    let summary: String
    let icon: String
    let data: [T]
}

struct Minutely: DataBlockType {
    let time: Date
    let precipIntensity: Double
    let precipIntensityError: Double?
    let precipProbability: Double
    let precipType: String?
}

struct Hourly: DataBlockType {
    let time: Date
    let summary: String
    let icon: String
    let precipIntensity: Double
    let precipProbability: Double
    let precipAccumulation: Double?
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

struct Daily: DataBlockType {
    let time: Date
    let summary: String
    let icon: String
    let sunriseTime: Date
    let sunsetTime: Date
    let moonPhase: Double
    let precipIntensity: Double
    let precipIntensityMax: Double
    let precipIntensityMaxTime: Date
    let precipProbability: Double
    let precipAccumulation: Double?
    let precipType: String?
    let temperatureHigh: Double
    let temperatureHighTime: Date
    let temperatureLow: Double
    let temperatureLowTime: Date
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Date
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Date
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let uvIndexTime: Date
    let visibility: Double?
}

struct WeatherAlert: Codable {
    let time: Date
    let expires: Date
    let title: String
    let description: String
    let regions: [String]
    let severity: String
    let uri: String
}

struct Flags: Codable {
    let units: String
    let sources: [String]
    let isdStations: [String]?
    let darkskyUnavailable: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case units
        case sources
        case isdStations = "isd-stations"
        case darkskyUnavailable = "darksky-unavailable"
    }
}
