//
//  WeatherIconName.swift
//  Precipitate
//
//  Created by Mark Murray on 12/14/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

enum WeatherIconName: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    case Hail = "hail"
    case Thunderstorm = "thunderstorm"
    case Tornado = "tornado"
}

// Weather icons by https://erikflowers.github.io/weather-icons/
func weatherIconForName(name: WeatherIconName?) -> (String, CGFloat) {
    if let name = name {
        switch name {
        case .ClearDay:
            return ("\u{f00d}", 25.0) // wi-day-sunny
        case .ClearNight:
            return ("\u{f0d1}", 25.0) // wi-moon-alt-waxing-crescent-2
        case .Rain:
            return ("\u{f01c}", 25.0) // wi-sprinkle
        case .Snow:
            return ("\u{f01b}", 25.0) // wi-snow
        case .Sleet:
            return ("\u{f017}", 25.0) // wi-rain-mix
        case .Wind:
            return ("\u{f011}", 25.0) // wi-cloudy-gusts
        case .Fog:
            return ("\u{f014}", 25.0) // wi-fog
        case .Cloudy:
            return ("\u{f013}", 25.0) // wi-cloudy
        case .PartlyCloudyDay:
            return ("\u{f002}", 25.0) // wi-day-cloudy
        case .PartlyCloudyNight:
            return ("\u{f086}", 25.0) // wi-night-alt-cloudy
        case .Hail:
            return ("\u{f071}", 25.0) // wi-meteor
        case .Thunderstorm:
            return ("\u{f01e}", 25.0) // wi-thunderstorm
        case .Tornado:
            return ("\u{f056}", 25.0) // wi-tornado
        }
    } else {
        return ("❄️", 25.0)
    }
}

