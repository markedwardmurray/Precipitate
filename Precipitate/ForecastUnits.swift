//
//  ForecastUnits.swift
//  Precipitate
//
//  Created by Mark Murray on 1/21/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation

enum ForecastUnitsOption: String {
    case US = "us"
    case SI = "si"
    case UK2 = "uk2"
    case CA = "ca"
}

struct ForecastUnits {
    let option: ForecastUnitsOption
    
    init() {
        self.option = ForecastUnitsOption.US
    }
    
    init(option: ForecastUnitsOption) {
        self.option = option
    }
    
    struct Units {
        let short: String, long: String
    }
    
    var systemDescription: Units {
        switch option {
        case .US:
            return Units(short: "U.S.", long: "United States")
        case .SI:
            return Units(short: "S.I.", long: "International System")
        case .CA:
            //FIXME: CA strings not set
            return Units(short: "ca", long: "ca")
        case .UK2:
            return Units(short: "U.K.", long: "United Kingdom")
        }
    }
    
    var forTemperature: Units {
        switch option {
        case .US:
            return Units(short: "ºF", long: "degrees Fahrenheit")
        case .SI, .CA, .UK2:
            return Units(short: "ºC", long: "degrees Celcius")
        }
    }
    
    var forDistance: Units {
        switch option {
        case .US, .UK2:
            return Units(short: "mi", long: "miles")
        case .SI, .CA:
            return Units(short: "km", long: "Kilometers")
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
            return Units(short: "mm/hr", long: "millimeters per hour")
        }
    }
    
    var forPrecipAccumulation: Units {
        switch option {
        case .US:
            return Units(short: "in", long: "inches")
        case .SI, .CA, .UK2:
            return Units(short: "cm", long: "Centimeters")
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
}
