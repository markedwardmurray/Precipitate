//
//  PageViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    var pages = [ChartsTableViewController]()
    
    var presentationIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        // KIF
        self.accessibilityLabel = "pageVC"
        
        self.view.backgroundColor = UIColor.notMyChristian()
        
        self.setUpChildVCs()
        
        /*
        let subviews: Array = self.pageViewController.view.subviews
        var pageControl: UIPageControl! = nil
        
        for (var i = 0; i < subviews.count; i++) {
            if (subviews[i] is UIPageControl) {
                pageControl = subviews[i] as! UIPageControl
                pageControl.pageIndicatorTintColor = UIColor.notMyChristian()
                pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
                break
            }
        }
        */
    }
    
    func setUpChildVCs() {
        let hourlyTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        // setup for KIF - begin
        hourlyTVC.tableView.accessibilityLabel = "hourlyTableView"
        hourlyTVC.tableView.accessibilityIdentifier = "hourlyTableView"
        // setup for KIF - end
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            hourlyTVC.timescale = "48-Hour Forecast"
            
            hourlyTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            hourlyTVC.chartDatas = hourlyDatas
            //hourlyTVC.chartKeys = DataEntryCollator.hourlyKeys
        }
        
        let dailyTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        // setup for KIF - begin
        dailyTVC.tableView.accessibilityLabel = "dailyTableView"
        dailyTVC.tableView.accessibilityIdentifier = "dailyTableView"
        // setup for KIF - end
        if let dailyDatas = lineChartDataManager.dailyDatas {
            dailyTVC.timescale = "7-Day Forecast"
            
            dailyTVC.chartSettings = LineChartDataManager.sharedInstance.dailyChartSettings()
            dailyTVC.chartDatas = dailyDatas
            //dailyTVC.chartKeys = DataEntryCollator.dailyKeys
        }
        
        pages = [hourlyTVC, dailyTVC]
        
        self.setViewControllers([hourlyTVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
        
        let currentIndex = pages.indexOf(chartsTVC)!
        
        let previousIndex = abs((currentIndex - 1) % pages.count)
        self.presentationIndex = previousIndex
        return pages[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
        
        let currentIndex = pages.indexOf(chartsTVC)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        self.presentationIndex = nextIndex
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.presentationIndex
    }
    
}
