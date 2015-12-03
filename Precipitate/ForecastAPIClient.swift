//
//  ForecastAPIClient.swift
//  Precipitate
//
//  Created by Mark Murray on 12/2/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?)

class ForecastAPIClient {
    static let sharedInstance = ForecastAPIClient()
    static let forecastURL = "https://api.forecast.io/forecast/"
    
    private let apiKey = marksAPIKey
    
    func getForecastForLatitude(latitude: Double, longitude: Double, onCompletion: (ServiceResponse) ) {
        let url = NSURL(string: "\(ForecastAPIClient.forecastURL)\(apiKey)/\(latitude),\(longitude)")!
        
        let request = NSURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let data = data {
                let json:JSON = JSON(data: data)
                onCompletion((json, error))
            }
        })
        task.resume()
    }
}
