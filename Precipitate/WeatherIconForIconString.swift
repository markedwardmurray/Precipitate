//
//  WeatherIconForIconString.swift
//  Precipitate
//
//  Created by Mark Murray on 12/14/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation

func weatherIconForIconString(iconString: String) -> String {
    switch iconString {
    case "clear-day":
        return "☀️"
    case "clear-night":
        return "🌛"
    case "rain":
        return "💦"
    case "snow":
        return "❄️"
    case "sleet":
        return "🌨"
    case "wind":
        return "🌬"
    case "fog":
        return "🌁"
    case "cloudy":
        return "🌥"
    case "partly-cloudy-day":
        return "🌤"
    case "partly-cloudy-night":
        return "☁️"
    default:
        return "💫"
    }
}

