//
//  WeatherListView.swift
//  Precipitate2
//
//  Created by Mark Murray on 6/25/22.
//

import SwiftUI
import WeatherKit

struct WeatherListView: View {
    @MainActor class ViewModel: ObservableObject {
        @Published var weather: Weather?
        
        init() {
            Task {
                do {
                    weather = try await WeatherClient.shared.fetchCurrentWeather()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        if let hourly = viewModel.weather?.hourlyForecast {
            WeatherChartView(hourlyForecast: hourly)
        }
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}


