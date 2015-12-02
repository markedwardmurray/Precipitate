//
//  ViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 11/25/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import CoreLocation
import ForecastIO
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var probability: UILabel!
    @IBOutlet weak var intensity: UILabel!
    @IBOutlet weak var icon: UILabel!
    
    let forecastClient = APIClient(apiKey: marksAPIKey)
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getForecastForCurrentLocation() {
        if let location = locationManager.location {
            locationManager.stopUpdatingLocation()
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            print("lat: \(latitude), lng: \(longitude)")
            
            forecastClient.getForecast(latitude: latitude, longitude: longitude) { (currentForecast, error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    NSOperationQueue.mainQueue().addOperationWithBlock{ () -> Void in
                        
                        if let precipProbability = currentForecast?.currently?.precipProbability {
                            print(precipProbability)
                            self.probability.text = "\(precipProbability * 100) %"
                        }
                        if let precipIntensity = currentForecast?.currently?.precipIntensity {
                            print(precipIntensity)
                            self.intensity.text = "\(precipIntensity)"
                        }
                        if let weatherIcon = currentForecast?.currently?.icon {
                            print(weatherIcon)
                            self.icon.text = "\(weatherIcon)"
                        }
                    }
                }
            }
            
        } else {
            print("location is nil")
        }
    }

    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("status: \(status.rawValue)")
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations: \(locations)")
        self.getForecastForCurrentLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    @IBAction func updateTapped(sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
}

