//
//  WeatherPageViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    var pages = [ChartsTableViewController]()
    
    override func viewDidLayoutSubviews() {
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
        // hides the footer
        // Objective-C implementation by Zerotool (Stack Overflow)
        var scrollView: UIScrollView?
        var pageControl: UIPageControl?
        
        if (self.view.subviews.count == 2) {
            for view in self.view.subviews {
                if (view.isKindOfClass(UIScrollView)) {
                    scrollView = view as? UIScrollView
                } else if (view.isKindOfClass(UIPageControl)) {
                    pageControl = view as? UIPageControl
                }
            }
        }
        
        if let scrollView = scrollView {
            if let pageControl = pageControl {
                scrollView.frame = self.view.bounds
                self.view.bringSubviewToFront(pageControl)
            }
        }
        
        super.viewDidLayoutSubviews()
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        // KIF
        self.accessibilityLabel = "pageVC"
        
        self.setUpChildVCs()
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.havelockBlue()
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
    }
    
    func setUpChildVCs() {
        let twelveHourTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        twelveHourTVC.timeScale = ChartsTableViewControllerTimeScaleOption.TwelveHour
        // setup for KIF - begin
        twelveHourTVC.tableView.accessibilityLabel = "twelveHourTableView"
        twelveHourTVC.tableView.accessibilityIdentifier = "twelveHourTableView"
        // setup for KIF - end
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            twelveHourTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            twelveHourTVC.chartDatas = hourlyDatas
        }
        
        let fortyEightHourTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        fortyEightHourTVC.timeScale = ChartsTableViewControllerTimeScaleOption.FortyEightHour
        // setup for KIF - begin
        fortyEightHourTVC.tableView.accessibilityLabel = "fortyEightHourTableView"
        fortyEightHourTVC.tableView.accessibilityIdentifier = "fortyEightHourTableView"
        // setup for KIF - end
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            fortyEightHourTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            fortyEightHourTVC.chartDatas = hourlyDatas
        }
        
        let sevenDayTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        sevenDayTVC.timeScale = ChartsTableViewControllerTimeScaleOption.SevenDay
        // setup for KIF - begin
        sevenDayTVC.tableView.accessibilityLabel = "sevenDayTableView"
        sevenDayTVC.tableView.accessibilityIdentifier = "sevenDayWeekTableView"
        // setup for KIF - end
        if let dailyDatas = lineChartDataManager.dailyDatas {
            sevenDayTVC.chartSettings = LineChartDataManager.sharedInstance.dailyChartSettings()
            sevenDayTVC.chartDatas = dailyDatas
            //dailyTVC.chartKeys = DataEntryCollator.dailyKeys
        }
        
        pages = [twelveHourTVC, fortyEightHourTVC, sevenDayTVC]
        
        self.setViewControllers([twelveHourTVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
                
        let currentIndex = self.pages.indexOf(chartsTVC)
        
        if let currentIndex = currentIndex {
            if (currentIndex != 0) {
                return self.pages[currentIndex - 1]
            }
        }
        return nil;
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
        
        let currentIndex = self.pages.indexOf(chartsTVC)
        
        if let currentIndex = currentIndex {
            let lastIndex = self.pages.count - 1
            if (currentIndex != lastIndex) {
                return self.pages[currentIndex + 1]
            }
        }
        return nil;
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        let visibleVC = self.viewControllers?.first as! ChartsTableViewController?
        if let visibleVC = visibleVC {
            return self.pages.indexOf(visibleVC)!
        }
        return 0
    }
    
}
