//
//  InitialViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
   
    let apiClient = ForecastAPIClient.sharedInstance
    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    @IBOutlet weak var summaryContainer: UIView!
    @IBOutlet weak var pageContainer: UIView!
    
    weak var summaryViewController: SummaryViewController!
    weak var pageViewController: PageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // delay to let the frames load correctly
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.001 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            self.loadViewsAfterGettingData()
        })
    }
    
    func loadViewsAfterGettingData() {
        self.apiClient.getRecentlyCachedForecastOrNewAPIResponse { (json) -> Void in
            if let json = json {
                self.lineChartDataManager.json = json
                
                self.pageViewController.setUpChildVCs()
                self.summaryViewController.setUpSubviews()
            } else {
                let alertController = UIAlertController(title: "Data Error!", message: "Something went wrong—there is no weather data to display. Please make sure that your phone has an internet connection and that location services are enabled.", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                    print(action)
                }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
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
    
}
