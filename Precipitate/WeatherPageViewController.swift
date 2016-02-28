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
    
    var presentationIndex: Int = 0
    
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
        let todayTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        todayTVC.timeScale = ChartsTableViewControllerTimeScaleOption.Today
        // setup for KIF - begin
        todayTVC.tableView.accessibilityLabel = "todayTableView"
        todayTVC.tableView.accessibilityIdentifier = "todayTableView"
        // setup for KIF - end
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            todayTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            todayTVC.chartDatas = hourlyDatas
        }
        
        let tomorrowTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        tomorrowTVC.timeScale = ChartsTableViewControllerTimeScaleOption.Tomorrow
        // setup for KIF - begin
        tomorrowTVC.tableView.accessibilityLabel = "tomorrowTableView"
        tomorrowTVC.tableView.accessibilityIdentifier = "tomorrowTableView"
        // setup for KIF - end
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            tomorrowTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            tomorrowTVC.chartDatas = hourlyDatas
        }
        
        let thisWeekTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        thisWeekTVC.timeScale = ChartsTableViewControllerTimeScaleOption.Weekly
        // setup for KIF - begin
        thisWeekTVC.tableView.accessibilityLabel = "thisWeekTableView"
        thisWeekTVC.tableView.accessibilityIdentifier = "thisWeekTableView"
        // setup for KIF - end
        if let dailyDatas = lineChartDataManager.dailyDatas {
            thisWeekTVC.chartSettings = LineChartDataManager.sharedInstance.dailyChartSettings()
            thisWeekTVC.chartDatas = dailyDatas
            //dailyTVC.chartKeys = DataEntryCollator.dailyKeys
        }
        
        pages = [todayTVC, tomorrowTVC, thisWeekTVC]
        
        self.setViewControllers([todayTVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
                
        let currentIndex = self.pages.indexOf(chartsTVC)
        
        if let currentIndex = currentIndex {
            if (currentIndex != 0) {
                let newIndex = currentIndex - 1
                self.presentationIndex = newIndex
                return self.pages[newIndex]
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
                let newIndex = currentIndex + 1
                self.presentationIndex = newIndex
                return self.pages[newIndex]
            }
        }
        return nil;
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.presentationIndex
    }
    
}
