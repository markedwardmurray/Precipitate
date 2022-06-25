//
//  WeatherClient.swift
//  Precipitate2
//
//  Created by Mark Murray on 6/25/22.
//

import CoreLocation
import Foundation
import WeatherKit

// TODO: attribution requirements https://developer.apple.com/weatherkit/get-started/#attribution-requirements
class WeatherClient {
    static let shared = WeatherClient()
    
    private let service = WeatherService()
    
    func fetchCurrentWeather() async throws -> Weather {
        try await service.weather(for: CLLocation.brantPark)
    }
}

extension CLLocation {
    // @40.751875,-73.9844408,16.81z
    static let brantPark = CLLocation(latitude: 40.751, longitude: -73.984)
}
