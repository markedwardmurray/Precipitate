//
//  InitialViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import FontAwesome_swift
import SnapKit
import SwiftyUserDefaults

class InitialViewController: UIViewController {
   
    let apiClient = ForecastAPIClient.sharedInstance
    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    @IBOutlet weak var summaryContainer: UIView!
    @IBOutlet weak var pageContainer: UIView!
    
    weak var summaryViewController: SummaryViewController!
    weak var weatherPageViewController: WeatherPageViewController!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerObservers()
        self.defineSpinner()
        
        // delay to let the frames load correctly
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            if (Defaults["openedOnce"].bool == nil) {
                Defaults["openedOnce"] = true
                
                Defaults["units"] = 0
                Defaults["lang"] = 6
                self.showSettings()
                self.presentWelcomeAlertController()
            } else {
                //self.loadViewsAfterGettingData()
            }
        })
    }
    
    private func registerObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showSettings", name: "showSettings", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showWeather", name: "showWeather", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "save", name: "applicationWillResignActive", object: UIApplication.sharedApplication().delegate)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: "applicationDidBecomeActive", object: UIApplication.sharedApplication().delegate)
    }
    
    func save() {
        Defaults["shouldShowSettings"] = self.summaryViewController.shouldShowSettings
    }
    
    func reload() {
        if let shouldShowSettings = Defaults["shouldShowSettings"].bool {
            shouldShowSettings ? self.showSettings() : self.showWeather()
        }
    }
    
    private func defineSpinner() {
        let centerX = UIScreen.mainScreen().bounds.size.width / 2
        let centerY = UIScreen.mainScreen().bounds.size.height / 2
        self.spinner.center = CGPointMake(centerX, centerY)
        
        let transform = CGAffineTransformMakeScale(3.0, 3.0)
        self.spinner.transform = transform
        
        self.spinner.hidesWhenStopped = true
        
        self.view.addSubview(spinner)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadViewsAfterGettingData() {
        
        self.spinner.startAnimating()
        
        self.apiClient.getRecentlyCachedForecastOrNewAPIResponse { (json, error) -> Void in
            self.spinner.stopAnimating()
            
            if let error = error {
                print("~~~~~~~~~~~~~ERROR~~~~~~~~~\n\(error)")
                self.presentAlertWithNSError(error as NSError)
            }
            
            if let json = json {
                self.lineChartDataManager.json = json
                
                self.weatherPageViewController.setUpChildVCs()
                self.summaryViewController.setUpSubviews()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embeddedPageVCSegue" {
            self.weatherPageViewController = segue.destinationViewController as! WeatherPageViewController
        }
        else if segue.identifier == "embeddedSummaryVCSegue" {
            self.summaryViewController = segue.destinationViewController as! SummaryViewController
        }
        else {
            print("InitialVC - unrecognized segue identifier: \(segue.identifier)")
        }
    }
    
//MARK: ContainerView voodoo
    
    func showWeather() {
        print("show weather")
        self.weatherPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("weatherPageVC") as! WeatherPageViewController
        self.setEmbeddedMainViewController(self.weatherPageViewController)
        self.loadViewsAfterGettingData()
    }
    
    func showSettings() {
        print("show settings")
        let settingsVC = PrecipitateSettingsViewController()
        self.summaryViewController.shouldShowSettings = true;
        self.setEmbeddedMainViewController(settingsVC)
    }
    
    func setEmbeddedMainViewController(viewController: UIViewController) {
        if (self.childViewControllers.contains(viewController)) {
            return
        }
        
        for childVC in self.childViewControllers {
            if (childVC === self.summaryViewController) {
                continue
            }
            
            childVC.willMoveToParentViewController(nil)
            
            if (childVC.isViewLoaded()) {
                childVC.view.removeFromSuperview()
            }
            childVC.removeFromParentViewController()
        }
        
        self.addChildViewController(viewController)
        self.pageContainer.addSubview(viewController.view)
        viewController.view.snp_updateConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        viewController.didMoveToParentViewController(self)
    }
    
//MARK: Alert Controllers
    
    func presentWelcomeAlertController() {
        let gear = String.fontAwesomeIconWithName(FontAwesome.Gear)
        let alertController = UIAlertController(title: "Welcome to Precipitate!", message: nil, preferredStyle: .Alert)
        
        let message = NSAttributedString(string: "Please select your preferences for the following options:\n\nForecast API: Units\nForecast API: Language\n\nYou can change these options later but they won't take immediate effect.\n\nTap the \(gear) when you are done.", attributes: [NSFontAttributeName : UIFont.fontAwesomeOfSize(14)])
        alertController.setValue(message, forKey: "attributedMessage")
        
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
            self.loadViewsAfterGettingData()
        }
        alertController.addAction(tryAgainAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func presentAlertWithNSError(nsError: NSError) {
        let alertController = UIAlertController(title: "Error!", message: nsError.localizedDescription, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) in }
        alertController.addAction(cancelAction)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default) { (action) in
            self.loadViewsAfterGettingData()
        }
        alertController.addAction(tryAgainAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
