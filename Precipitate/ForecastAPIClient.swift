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
    
    static let fileURL = NSURL.fileURLWithPath(NSTemporaryDirectory() + "forecast.json")
    
    private let apiKey = marksAPIKey
    
    func getForecastForCurrentLocationCompletion(completion: (json: JSON) -> Void) {
        
        //print("read cache")
        let json = self.retrieveCachedJSON()
        if let json = json {
            print("ForecastAPIClient: return cache")
            completion(json: json)
        }
        
        let locationManager = INTULocationManager.sharedInstance()
        locationManager.requestLocationWithDesiredAccuracy(INTULocationAccuracy.Block, timeout: NSTimeInterval(20), delayUntilAuthorized: true) { (location, accuracy, status) -> Void in
            print(status)
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            self.getForecastForLatitude(latitude, longitude: longitude, completion: { (json) -> Void in
                //print(json)
                
                completion(json: json)
            })
        }
    }
    
    func getForecastForLatitude(latitude: Double, longitude: Double, completion: (json: JSON) -> Void) {
        /*
        //print("read cache")
        if let json = self.retrieveCachedJSON() {
            print("ForecastAPIClient: return cache")
            completion(json: json)
        }
        */
        
        let url = NSURL(string: "\(ForecastAPIClient.forecastURL)\(apiKey)/\(latitude),\(longitude)")!
        
        Alamofire.request(.GET, url ).responseJSON { response in
            switch response.result {
            case .Success:
                //print("response success")
                if let value = response.result.value {
                    let json = JSON(value)
                    //print("write to cache")
                    self.cacheJSON(json)
                    print("ForecastAPIClient: return fresh API response")
                    completion(json: json)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
        
    func retrieveCachedJSON() -> JSON? {   // should throw
        
        /*
        let cachedURL = NSURL(string: "Precipitate/saved-forecast.json")!
        let data = NSData(contentsOfURL: cachedURL)
        if let data = data {
            return JSON(data)
        }
        */
        
        let manager = NSFileManager.defaultManager()
        let path = ForecastAPIClient.fileURL.path!
        
        if manager.fileExistsAtPath(path) {
            if let data = NSData(contentsOfURL: ForecastAPIClient.fileURL) {
                //print("data \(data)")
                let json = JSON(data: data)
                //print("json: \(json)")
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
        print("path: \(path)")
        
        if manager.fileExistsAtPath(path) {
            do {
                //print("remove old cache")
                try manager.removeItemAtPath(path)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        do {
            //print("create file for cache")
            let data = try json.rawData(options: NSJSONWritingOptions.PrettyPrinted)
            manager.createFileAtPath(path, contents: data, attributes: nil)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
