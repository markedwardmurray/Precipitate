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
                
                let summaryVC = self.storyboard?.instantiateViewControllerWithIdentifier("summaryVC") as! SummaryViewController
                self.setEmbeddedSummaryViewController(summaryVC)
                
                let pageVC = self.storyboard?.instantiateViewControllerWithIdentifier("pageVC") as! PageViewController
                self.setEmbeddedPageViewController(pageVC)
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
    
    func setEmbeddedSummaryViewController(summaryViewController: SummaryViewController) {
        self.addChildViewController(summaryViewController)
        if self.summaryContainer.subviews.count > 0 {
            let summaryView = self.summaryContainer.subviews[0]
            summaryView.removeFromSuperview()
        }
        
        self.summaryContainer.addSubview(summaryViewController.view)
        summaryViewController.didMoveToParentViewController(self)
    }
    
    func setEmbeddedPageViewController(pageViewController: PageViewController) {
        self.addChildViewController(pageViewController)
        if self.pageContainer.subviews.count > 0 {
            let pageView = self.pageContainer.subviews[0]
            pageView.removeFromSuperview()
        }

        self.pageContainer.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }
    
}
