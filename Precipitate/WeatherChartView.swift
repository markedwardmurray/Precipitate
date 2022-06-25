//
//  WeatherChartView.swift
//  Precipitate2
//
//  Created by Mark Murray on 6/25/22.
//

import Charts
import SwiftUI
import WeatherKit

struct WeatherChartView: View {
    var hourlyForecast: Forecast<HourWeather>
    
    var body: some View {
        Chart(hourlyForecast.forecast) { forecast in
            LineMark(x: .value("Hour", forecast.date), y: .value("Temperature", forecast.temperature.value))
            
        }
    }
}

//struct WeatherChartView_Previews: PreviewProvider {
//    static var previews: some View {
////        WeatherChartView(hourlyForecast:)
//    }
//}

extension HourWeather: Identifiable {
    public var id: Date {
        date
    }
}
