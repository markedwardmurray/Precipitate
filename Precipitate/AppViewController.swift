//
//  AppViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 7/2/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyUserDefaults

class AppViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    weak var welcomeViewController: WelcomeViewController!
    weak var weatherNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        
        self.loadSpinner()
        
        let status = CLLocationManager.authorizationStatus()
        if (status != .AuthorizedWhenInUse) {
            if status == .NotDetermined {
                self.showWelcome()
            } else {
                // show location issue screen
            }
        } else {
            self.showWeather()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            self.showWeather()
        } else {
            // show location issue screen
        }
    }
    
    func showWelcome() {
        let welcomeViewController = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController()! as! WelcomeViewController
        welcomeViewController.locationManager = self.locationManager
        
        self.welcomeViewController = welcomeViewController
        self.setEmbeddedMainViewController(welcomeViewController)
    }
    
    func showWeather() {
        self.spinner.startAnimating()
        
        ForecastAPIClient.sharedInstance.getRecentlyCachedForecastOrNewAPIResponse { (json, error) -> Void in
            self.spinner.stopAnimating()
            
            if let error = error {
                print("~~~~~~~~~~~~~ERROR~~~~~~~~~\n\(error)")
                self.presentAlertWithNSError(error as NSError)
            }
            
            if let json = json {
                LineChartDataManager.sharedInstance.json = json
                
                if (Defaults["forecastCount"].int == 1) {
                    self.presentWeatherDataReceivedAlert()
                }
                
                let weatherNavigationController = UIStoryboard(name: "Weather", bundle: nil).instantiateInitialViewController()! as! UINavigationController
                self.weatherNavigationController = weatherNavigationController
                self.setEmbeddedMainViewController(weatherNavigationController)
            }
        }
    }

    func setEmbeddedMainViewController(viewController: UIViewController) {
        if (self.childViewControllers.contains(viewController)) {
            return
        }
        
        for childVC in self.childViewControllers {
            childVC.willMoveToParentViewController(nil)
            
            if (childVC.isViewLoaded()) {
                childVC.view.removeFromSuperview()
            }
            childVC.removeFromParentViewController()
        }
        
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.snp_updateConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        viewController.didMoveToParentViewController(self)
    }
    
    private func loadSpinner() {
        let centerX = UIScreen.mainScreen().bounds.size.width / 2
        let centerY = UIScreen.mainScreen().bounds.size.height / 2
        self.spinner.center = CGPointMake(centerX, centerY)
        
        let transform = CGAffineTransformMakeScale(3.0, 3.0)
        self.spinner.transform = transform
        
        self.spinner.hidesWhenStopped = true
        
        self.view.addSubview(spinner)
    }
    
    //MARK: Alert Controllers
    
    func presentWeatherDataReceivedAlert() {
        let alertController = UIAlertController(title:"Weather Data Received!", message: "Precipitate has saved this data to display for the next hour. After that, it will automatically refresh the data the next time you use the app.\n\nAny changes you make to the units or language options won't take effect until the next refresh.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Got it!", style: .Cancel) { (action) in
            print(action)
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentDataErrorAlertController() {
        let alertController = UIAlertController(title: "Data Error!", message: "Something went wrong—there is no weather data to display. Please make sure that your phone has an internet connection and that location services are enabled.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
        alertController.addAction(cancelAction)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default) { (action) in
            self.showWeather()
        }
        alertController.addAction(tryAgainAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentAlertWithNSError(nsError: NSError) {
        let alertController = UIAlertController(title: "Error!", message: nsError.localizedDescription, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) in }
        alertController.addAction(cancelAction)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default) { (action) in
            self.showWeather()
        }
        alertController.addAction(tryAgainAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
