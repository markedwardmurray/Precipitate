//
//  ForecastAPIClient.swift
//  Precipitate
//
//  Created by Mark Murray on 12/2/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ForecastAPIClient {
    static let sharedInstance = ForecastAPIClient()   // is this threadsafe?
    static let forecastURL = "https://api.forecast.io/forecast/"
    
    private let apiKey = marksAPIKey
    
    func getForecastForLatitude(latitude: Double, longitude: Double, completion: (json: JSON) -> Void) {
        let url = NSURL(string: "\(ForecastAPIClient.forecastURL)\(apiKey)/\(latitude),\(longitude)")!
        
        Alamofire.request(.GET, url ).responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    completion(json: json)
                }
            case .Failure(let error):
                print(error)
            }

            
//            if let data = response.data {
////                print(data)
////                let json = JSON(data)
////                debugPrint(json)
////            
////                let str = json.description
////                let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
//                let manager = NSFileManager.defaultManager()
//                if !manager.fileExistsAtPath(filepath) {
//                    manager.createFileAtPath(filepath, contents: data, attributes: nil)
//                }                
//            }
        }
    }
}
