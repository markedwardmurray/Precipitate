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

        self.apiClient.getForecastForCurrentLocationCompletion { (json) -> Void in
            self.lineChartDataManager.json = json
            
            let summaryVC = self.storyboard?.instantiateViewControllerWithIdentifier("summaryVC") as! SummaryViewController
            self.setEmbeddedSummaryViewController(summaryVC)
            
            let pageVC = self.storyboard?.instantiateViewControllerWithIdentifier("pageVC") as! PageViewController
            self.setEmbeddedPageViewController(pageVC)
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
