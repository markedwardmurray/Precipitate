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
import SwiftyUserDefaults

enum ForecastError: ErrorType {
    case CacheReadFailed
    case LocationRequestFailed
}

class ForecastAPIClient {
    static let sharedInstance = ForecastAPIClient()
    static let forecastURL = "https://api.forecast.io/forecast/"
    //static var forecastUnitsOption = ForecastUnitsOption.UK2
    
    static let fileURL = NSURL.fileURLWithPath(NSTemporaryDirectory() + "forecast.json")
    
    private let apiKey = marksAPIKey
    
    func getRecentlyCachedForecastOrNewAPIResponse(completion: (json: JSON?, error: ErrorType?) -> Void) {
        //print("read cache")
        
        var cachedJSON = JSON([:])
        do {
            cachedJSON = try self.retrieveCachedJSON()
        }
        catch {
            print("no cached json retrieved, making API request")
            self.getForecastForCurrentLocationCompletion({ (json, error) -> Void in
                completion(json: json, error: error)
            })
            return;
        }
        
        let minutesAgo = 60.0
        if self.cache(cachedJSON, isRecentWithinMinutesAgo: minutesAgo) {
            
            print("json cache is less than \(minutesAgo) minutes old, return cache")
            completion(json: cachedJSON, error: nil)
            return;
        }
        
        print("json cache is more than \(minutesAgo) minutes old, requesting new API response.")
        self.getForecastForCurrentLocationCompletion({ (json, error) -> Void in
            if error != nil {
                print("API request failed, returning cached JSON, error:\(error)")
                completion(json: cachedJSON, error: error)
                return;
            }
            
            completion(json: json, error: nil)
        })
    }
    
    func getForecastForCurrentLocationCompletion(completion: (json: JSON?, error: ErrorType?) -> Void) {
        
        let locationManager = INTULocationManager.sharedInstance()
        
        locationManager.requestLocationWithDesiredAccuracy(INTULocationAccuracy.Block, timeout: NSTimeInterval(20), delayUntilAuthorized: true) { (location, accuracy, status) -> Void in
            print(status)
            
            guard location != nil else {
                print("location request returned nil")
                completion(json: nil, error: ForecastError.LocationRequestFailed)
                return;
            }
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            self.getForecastForLatitude(latitude, longitude: longitude, completion: { (json, error) -> Void in
                //print(json)
                completion(json: json, error: error)
            })
        }
    }
    
    func getForecastForLatitude(latitude: Double, longitude: Double, completion: (json: JSON?, error: ErrorType?) -> Void) {
        let unitsKey = Defaults["units"].int
        print(unitsKey)
        let units = ForecastUnits.unitsOptionForKey(unitsKey).rawValue
        
        let languageOption = ForecastLanguageOption(rawValue: Defaults["lang"].int!)
        let languageKey = ForecastLanguage.languageKeyForOption(languageOption).rawValue
        
        let url = NSURL(string: "\(ForecastAPIClient.forecastURL)\(apiKey)/\(latitude),\(longitude)?units=\(units)&lang=\(languageKey)&exclude=[minutely]")!
        print(url)
        
        let request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 6.0
        
        Alamofire.request( request )
            .validate()
            .responseJSON { response in
            //print("Alamofire response: \(response)")
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    guard json.error == nil else {
                        print(json.error)
                        completion(json: nil, error: json.error)
                        return;
                    }
                    
                    self.cacheJSON(json)
                    print("ForecastAPIClient: return fresh API response")
                    completion(json: json, error: nil)
                }
            case .Failure(let error):
                print("Alamofire error: \(error)")
                completion(json: nil, error: error)
            }
        }
    }
    
    func cache(json: JSON, isRecentWithinMinutesAgo minutesAgo: Double) -> Bool {
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
        
    func retrieveCachedJSON() throws -> JSON {
        
        let manager = NSFileManager.defaultManager()
        let path = ForecastAPIClient.fileURL.path!
        
        guard manager.fileExistsAtPath(path) else {
            print("error, no file at path")
            throw ForecastError.CacheReadFailed
        }
        guard let data = NSData(contentsOfURL: ForecastAPIClient.fileURL) else {
            print("no data from file")
            throw ForecastError.CacheReadFailed
        }
        let json = JSON(data: data)
        return json
    }
    
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
