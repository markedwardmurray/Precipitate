//
//  WeatherIconForIconString.swift
//  Precipitate
//
//  Created by Mark Murray on 12/14/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

func weatherIconForIconString(iconString: String) -> String {
    switch iconString {
    case "clear-day":
        return "\u{f00d}" // wi-day-sunny
    case "clear-night":
        return "\u{f0d1}" // wi-moon-alt-waxing-crescent-2
    case "rain":
        return "\u{f01c}" // wi-sprinkle
    case "snow":
        return "❄" //"\u{f01b}" wi-snow
    case "sleet":
        return "\u{f017}" // wi-rain-mix
    case "wind":
        return "\u{f011}" // wi-cloudy-gusts
    case "fog":
        return "\u{f062}" // wi-smoke
    case "cloudy":
        return "\u{f013}" // wi-cloudy
    case "partly-cloudy-day":
        return "\u{f002}" // wi-day-cloudy
    case "partly-cloudy-night":
        return "\u{f086}" // wi-night-alt-cloudy
    case "hail":
        return "\u{f071}" // wi-meteor
    case "thunderstorm":
        return "\u{f01e}" // wi-thunderstorm
    case "tornado":
        return "\u{f056}" // wi-tornado
    default:
        return "💫"
    }
}

