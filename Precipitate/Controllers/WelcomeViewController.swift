//
//  WelcomeViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 7/2/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var locationManager: CLLocationManager?

    @IBOutlet var showMeTheWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMeTheWeatherButtonTapped(sender: AnyObject) {
        self.locationManager?.requestWhenInUseAuthorization()
    }
}
