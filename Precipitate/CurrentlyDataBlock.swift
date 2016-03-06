//
//  CurrentlyDataBlock.swift
//  Precipitate
//
//  Created by Mark Murray on 2/29/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CurrentlyDataBlock {
    let time: NSTimeInterval
    let icon: String
    let moonPhase: Double
    let summary: String
    let temperature: Double
    let apparentTemperature: Double
    
    let precipProbability: Double
    let precipIntensity: Double
    
    let cloudCover: Double
    let visibility: Double
    let windSpeed: Double
    let windBearing: Int
    let nearestStormDistance: Int
    let nearestStormBearing: Int
    
    let ozone: Double
    let humidity: Double
    let dewPoint: Double
    let pressure: Double
    
    init(json: JSON) {
        self.time = json["currently"]["time"].double!
        self.icon = json["currently"]["icon"].string!
        self.moonPhase = json["daily"]["data"][0]["moonPhase"].double!
        self.summary = json["currently"]["summary"].string!
        self.temperature = json["currently"]["temperature"].double!
        self.apparentTemperature = json["currently"]["apparentTemperature"].double!
        
        self.precipProbability = json["currently"]["precipProbability"].double!
        self.precipIntensity = json["currently"]["precipIntensity"].double!
        
        self.cloudCover = json["currently"]["cloudCover"].double!
        self.visibility = json["currently"]["visibility"].double!
        self.windSpeed = json["currently"]["windSpeed"].double!
        self.windBearing = json["currently"]["windBearing"].int!
        self.nearestStormDistance = json["currently"]["nearestStormDistance"].int!
        self.nearestStormBearing = json["currently"]["nearestStormBearing"].int!
        
        self.ozone = json["currently"]["ozone"].double!
        self.humidity = json["currently"]["humidity"].double!
        self.dewPoint = json["currently"]["dewPoint"].double!
        self.pressure = json["currently"]["pressure"].double!
    }
}
