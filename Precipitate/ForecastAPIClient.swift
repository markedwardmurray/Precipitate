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
import INTULocationManager

class ForecastAPIClient {
    static let sharedInstance = ForecastAPIClient()
    static let forecastURL = "https://api.forecast.io/forecast/"
    static var forecastUnitsOption = ForecastUnitsOption.UK2
    
    static let fileURL = NSURL.fileURLWithPath(NSTemporaryDirectory() + "forecast.json")
    
    private let apiKey = marksAPIKey
    
    func getRecentlyCachedForecastOrNewAPIResponse(completion: (json: JSON?) -> Void) {
        //print("read cache")
        let json = self.retrieveCachedJSON()
        if let json = json {
            let minutesAgo = 1
            if self.json(json, isRecentWithinMinutesAgo: minutesAgo) {
                print("json cache is less than \(minutesAgo) minutes old, return cache")
                completion(json: json)
            } else {
                print("json cache is more than \(minutesAgo) minutes old, requesting new API response.")
                self.getForecastForCurrentLocationCompletion({ (json) -> Void in
                    completion(json: json)
                })
            }
        } else {
            print("no cached json retrieved, making API request")
            self.getForecastForCurrentLocationCompletion({ (json) -> Void in
                completion(json: json)
            })
        }
    }
    
    func getForecastForCurrentLocationCompletion(completion: (json: JSON?) -> Void) {
        
        let locationManager = INTULocationManager.sharedInstance()
        
        locationManager.requestLocationWithDesiredAccuracy(INTULocationAccuracy.Block, timeout: NSTimeInterval(20), delayUntilAuthorized: true) { (location, accuracy, status) -> Void in
            print(status)
            
            if location == nil {
                print("location request returned nil")
                completion(json: nil)
            } else {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                self.getForecastForLatitude(latitude, longitude: longitude, completion: { (json) -> Void in
                    //print(json)
                    
                    completion(json: json)
                })
            }
        }
    }
    
    func getForecastForLatitude(latitude: Double, longitude: Double, completion: (json: JSON?) -> Void) {
        let units = ForecastAPIClient.forecastUnitsOption.rawValue.lowercaseString
        
        let url = NSURL(string: "\(ForecastAPIClient.forecastURL)\(apiKey)/\(latitude),\(longitude)?units=\(units)&exclude=[minutely]")!
        
        Alamofire.request(.GET, url ).responseJSON { response in
            print("Alamofire response: \(response)")
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    if let error = json["error"].string {
                        print("Alamofire json error: \(error)")
                        completion(json: nil)
                    } else {
                        self.cacheJSON(json)
                        print("ForecastAPIClient: return fresh API response")
                        completion(json: json)
                    }
                }
            case .Failure(let error):
                print("Alamofire error: \(error)")
                completion(json: nil)
            }
        }
    }
    
    func json(json: JSON, isRecentWithinMinutesAgo minutesAgo: Int) -> Bool {
        if let jsonTime = json["currently"]["time"].int {
            let jsonTimeInterval: NSTimeInterval = Double(jsonTime)
            let jsonDate = NSDate(timeIntervalSince1970: jsonTimeInterval)
            
            let minutesAgoInterval: NSTimeInterval = Double(-minutesAgo*60)
            let minutesAgoDate = NSDate(timeIntervalSinceNow: minutesAgoInterval)
            
            let earlier = jsonDate.earlierDate(minutesAgoDate)
            
            return earlier.isEqualToDate(minutesAgoDate)
        } else {
            return false
        }
    }
        
    func retrieveCachedJSON() -> JSON? {   // should throw
        
        let manager = NSFileManager.defaultManager()
        let path = ForecastAPIClient.fileURL.path!
        
        if manager.fileExistsAtPath(path) {
            if let data = NSData(contentsOfURL: ForecastAPIClient.fileURL) {
                let json = JSON(data: data)
                return json
            } else {
                print("no data from file")
                return nil
            }
        } else {
            print("error, no file at path")
            return nil
        }
    }  // this method is ugly
    
    func cacheJSON(json: JSON) {
        let manager = NSFileManager.defaultManager()
        let path = ForecastAPIClient.fileURL.path!
        
        if manager.fileExistsAtPath(path) {
            do {
                try manager.removeItemAtPath(path)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        do {
            let data = try json.rawData(options: NSJSONWritingOptions.PrettyPrinted)
            manager.createFileAtPath(path, contents: data, attributes: nil)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
