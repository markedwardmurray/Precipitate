//
//  ForecastUnits.swift
//  Precipitate
//
//  Created by Mark Murray on 1/21/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ForecastUnitsOption: String {
    case US = "us"
    case SI = "si"
    case UK2 = "uk2"
    case CA = "ca"
}

struct ForecastUnits {
    static func unitsOptionForKey(key: Int?) -> ForecastUnitsOption {
        if let key = key {
            switch key {
            case 0:
                return ForecastUnitsOption.US
            case 1:
                return ForecastUnitsOption.SI
            case 2:
                return ForecastUnitsOption.UK2
            case 3:
                return ForecastUnitsOption.CA
            default:
                return ForecastUnitsOption.US
            }
        } else {
            return ForecastUnitsOption.US
        }
    }
    
    let option: ForecastUnitsOption
    
    init() {
        self.option = ForecastUnitsOption.US
    }
    
    init(option: ForecastUnitsOption) {
        self.option = option
    }
    
    struct Info {
        let ticker: String, name: String, units: String
    }
    
    var info: Info {
        switch option {
        case .US:
            return Info(ticker: "US", name: "United States", units: "℉, in, in/hr, mi, mph, mbar")
        case .SI:
            return Info(ticker: "SI", name: "International System", units: " ℃, ㎝, ㎜/hr, ㏎, m/s, hPa")
        case .UK2:
            return Info(ticker: "UK", name: "United Kingdom", units: "℃, ㎝, ㎜/hr, mi, mph, hPa")
        case .CA:
            return Info(ticker: "CA", name: "Canada", units: "℃, ㎝, ㎜/hr, ㏎, kph, hPa")
        }
    }
    
    struct Units {
        let short: String, long: String
    }
    
    var forTemperature: Units {
        switch option {
        case .US:
            return Units(short: "℉", long: "degrees Fahrenheit")
        case .SI, .CA, .UK2:
            return Units(short: "℃", long: "degrees Celcius")
        }
    }
    
    var forDistance: Units {
        switch option {
        case .US, .UK2:
            return Units(short: "mi", long: "miles")
        case .SI, .CA:
            return Units(short: "㏎", long: "Kilometers")
        }
    }
    
    var forSpeed: Units {
        switch option {
        case .US, .UK2:
            return Units(short: "mph", long: "miles per hour")
        case .SI:
            return Units(short: "m/s", long: "meters per second")
        case .CA:
            return Units(short: "kph", long: "kilometers per hous")
        }
    }
    
    var forPrecipIntensity: Units {
        switch option {
        case .US:
            return Units(short: "in/hr", long: "inches per hour")
        case .SI, .CA, .UK2:
            return Units(short: "㎜/hr", long: "millimeters per hour")
        }
    }
    
    var forPrecipAccumulation: Units {
        switch option {
        case .US:
            return Units(short: "in", long: "inches")
        case .SI, .CA, .UK2:
            return Units(short: "㎝", long: "Centimeters")
        }
    }
    
    var forPressure: Units {
        switch option {
        case .US:
            return Units(short: "mbar", long: "millibars")
        case .SI, .CA, .UK2:
            return Units(short: "hPa", long: "Hectopascals")
        }
    }
    
    var forOzone: Units {
        switch option {
        case .US, .SI, .CA, .UK2:
            return Units(short: "DU", long: "Dobson Units")
        }
    }
    
    var forPercentage: Units {
        switch option {
        case .US, .SI, .CA, .UK2:
            return Units(short: "%", long: "Percentage")
        }
    }
    
    static func optionFromJSON(json: JSON) -> ForecastUnitsOption {
        let flag = json["flags"]["units"]
        switch flag {
        case "us":
            return ForecastUnitsOption.US
        case "si":
            return ForecastUnitsOption.SI
        case "uk2":
            return ForecastUnitsOption.UK2
        case "ca":
            return ForecastUnitsOption.CA
        default:
            print("Unregonized units flag in JSON")
            return ForecastUnitsOption.US
        }
    }
}
