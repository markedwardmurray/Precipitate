//
//  InitialViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyUserDefaults

class InitialViewController: UIViewController {
   
    let apiClient = ForecastAPIClient.sharedInstance
    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    @IBOutlet weak var summaryContainer: UIView!
    @IBOutlet weak var pageContainer: UIView!
    
    weak var summaryViewController: SummaryViewController!
    weak var pageViewController: PageViewController!
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerObservers()
        self.defineSpinner()
        
    }
    
    private func registerObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showSettings", name: "showSettings", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showWeather", name: "showWeather", object: nil)
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

        // delay to let the frames load correctly
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            if (Defaults["units"].int == nil) {
                Defaults["units"] = 0
                self.showSettings()
                self.presentWelcomeAlertController()
            } else {
                self.loadViewsAfterGettingData()
            }
        })
    }
    
    func loadViewsAfterGettingData() {
        
        self.spinner.startAnimating()
        
        self.apiClient.getRecentlyCachedForecastOrNewAPIResponse { (json) -> Void in
            
            self.spinner.stopAnimating()
            
            if let json = json {
                self.lineChartDataManager.json = json
                
                self.pageViewController.setUpChildVCs()
                self.summaryViewController.setUpSubviews()
            } else {
                self.presentDataErrorAlertController()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embeddedPageVCSegue" {
            self.pageViewController = segue.destinationViewController as! PageViewController
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
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("pageVC") as! PageViewController
        self.setEmbeddedMainViewController(self.pageViewController)
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
        let alertController = UIAlertController(title: "Welcome to Precipitate!", message: "Since this is your first time opening the app, please select your preferred units option before receiving weather data. You can change this option later but doing so won't take effect until the following weather data request.\n\nTap the ⚙ button when you are done.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Got it!", style: .Cancel) { (action) in
            print(action)
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func presentDataErrorAlertController() {
        let alertController = UIAlertController(title: "Data Error!", message: "Something went wrong—there is no weather data to display. Please make sure that your phone has an internet connection and that location services are enabled.", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            print(action)
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
