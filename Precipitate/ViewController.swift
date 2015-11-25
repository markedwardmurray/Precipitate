//
//  ViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 11/25/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import ForecastIO

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let forecastClient = APIClient(apiKey: marksAPIKey)
        
        forecastClient.getForecast(latitude: 40.772768, longitude: -73.915739) { (currentForecast, error) -> Void in
            if error != nil {
                print(error)
            } else {
                print(currentForecast)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

