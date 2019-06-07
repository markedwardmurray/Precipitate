//
//  DarkSky.swift
//  Precipitate
//
//  Created by Mark Murray on 10/12/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import SwiftUI

typealias CLLocationCoordinate2D = CoreLocation.CLLocationCoordinate2D

class DarkSky {
    static let shared = DarkSky()
    
    static func provide(apiKey: String) {
        DarkSky.shared.provide(apiKey: apiKey)
    }
    
    func provide(apiKey: String) {
        self.apiKey = apiKey
    }
    
    var timeoutInterval: TimeInterval = 10.0
    
    private let baseURL = "https://api.darksky.net/forecast/"
    
    private var apiKey: String?
    
    private var requestURL: String {
        guard let apiKey = apiKey else {
            fatalError("API Key cannot be nil")
        }
        return baseURL + apiKey + "/"
    }
    
    func request(_ request: DarkSky.Request, completion: @escaping (DarkSky.Request, Result<Weather>) -> Void) {
        
        Alamofire.request( request )
            .validate()
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    completion(request, .failure(error))
                case .success(let data):
                    let decoder = JSONDecoder()
                    let weather = try! decoder.decode(Weather.self, from: data)
                    
                    completion(request, .success(weather))
                }
        }
    }
}

extension DarkSky {
    struct Request: URLRequestConvertible {
        // path arguments
        let coordinate: CLLocationCoordinate2D
        var time: Date? = nil
        
        // parameters
        var language: Language = .english
        var units: Units = .unitedStates
        var exclude: Exclude = Exclude(rawValue: Exclude.daily)
        
        private var parameters: [String : String] {
            var parameters: [String : String] = [
                "lang" : language.rawValue,
                "units" : units.rawValue
            ]
            if let excludeString = exclude.asString {
                parameters["exclude"] = excludeString
            }
            return parameters
        }
        
        func asURLRequest() throws -> URLRequest {
            var url_str = DarkSky.shared.requestURL + "\(coordinate.latitude),\(coordinate.longitude)"
            if let time = time {
                url_str += ",\(Int(time.timeIntervalSince1970))"
            }
            
            if parameters.count > 0 {
                url_str += "?"
                url_str.append( parameters.map { (key, value) -> String in
                    return "\(key)=\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                    }.joined(separator: "&") )
            }
            
            do {
                var request = try URLRequest(url: url_str, method: .get)
                request.timeoutInterval = DarkSky.shared.timeoutInterval
                
                return request
            } catch {
                throw error
            }
        }
    }
}

extension DarkSky.Request {
    struct Exclude: OptionSet {
        let rawValue: Int
        
        static let none      = 0
        static let currently = 0b00000001
        static let minutely  = 0b00000010
        static let hourly    = 0b00000100
        static let daily     = 0b00001000
        static let alerts    = 0b00010000
        static let flags     = 0b00100000
        
        var asString: String? {
            guard rawValue != Exclude.none else {
                return nil
            }
            
            let values = [
                Exclude.currently : "currently",
                Exclude.minutely  : "minutely",
                Exclude.hourly    : "hourly",
                Exclude.daily     : "daily",
                Exclude.alerts    : "alerts",
                Exclude.flags     : "flags"
            ]
            
            var strings: [String] = []
            for (key, value) in values {
                if contains( Exclude(rawValue: key) ) {
                    strings.append(value)
                }
            }
            
            return strings.joined(separator: ",")
        }
    }
}

extension DarkSky.Request {
    enum Units: String, CaseIterable {
        /// automatically select units based on geographic location
        case auto
        /// same as si, except that windSpeed is in kilometers per hour
        case canada = "ca"
        /// same as si, except that nearestStormDistance and visibility are in miles and windSpeed is in miles per hour
        case unitedKingdom = "uk2"
        /// Imperial units (the default)
        case unitedStates = "us"
        /// SI units
        case internaionalSystem = "si"
    }
}

extension DarkSky.Request {
    enum Language: String, CaseIterable {
        case arabic = "ar"
        case azerbaijani = "az"
        case belarusian = "be"
        case bulgarian = "bg"
        case bosnian = "bs"
        case catalan = "ca"
        case czech = "cs"
        case german = "de"
        case greek = "el"
        case english = "en"
        case spanish = "es"
        case estonian = "et"
        case french = "fr"
        case croatian = "hr"
        case hungarian = "hu"
        case indonesian = "id"
        case talian = "it"
        case icelandic = "is"
        case cornish = "kw"
        case norwegianBokmal = "nb"
        case dutch = "nl"
        case polish = "pl"
        case portuguese = "pt"
        case russian = "ru"
        case slovak = "sk"
        case slovenian = "sl"
        case serbian = "sr"
        case swedish = "sv"
        case tetum = "tet"
        case turkish = "tr"
        case ukrainian = "uk"
        case igpayAtinlay = "x-pig-latin"
        case simplifiedChinese = "sh"
        case traditionalChinese = "zh-tw"
    }
}
