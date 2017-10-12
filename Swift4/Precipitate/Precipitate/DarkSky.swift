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
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(request, .failure(error))
                case .success(_):
                    let decoder = JSONDecoder()
                    let weather = try! decoder.decode(Weather.self, from: response.data!)
                    
                    completion(request, .success(weather))
                }
        }
    }
}

extension DarkSky {
    struct Request: URLRequestConvertible {
        let coordinate: CLLocationCoordinate2D
        
        func asURLRequest() throws -> URLRequest {
            var url_str = DarkSky.shared.requestURL + "\(coordinate.latitude),\(coordinate.longitude)"
            
            //let allParameters = Foursquare.shared.userlessRequestParameters + self.parameters
            
//            url_str.append( allParameters.map { (key, value) -> String in
//                return "\(key)=\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//                }.joined(separator: "&") )
            
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
