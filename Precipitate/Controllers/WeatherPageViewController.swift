//
//  WeatherPageViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import FontAwesome_swift
import MarqueeLabel_Swift

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
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
        
        self.loadNavigationItems()
        
        self.loadChildVCs()
        
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.havelockBlue()
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(reloadCharts), name:"NotificationDisplaySettingsDidChange", object: nil)
    }
    
    func loadNavigationItems() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
            NSFontAttributeName : UIFont(name: "Weather Icons", size: 25)!,
            NSForegroundColorAttributeName : UIColor.s3Chambray()
            ], forState: .Normal)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
            NSForegroundColorAttributeName : UIColor.s3Chambray()
            ], forState: .Highlighted)
        if let currentlyIcon = LineChartDataManager.sharedInstance.chartDataSetManager.dataEntryCollator?.currentlyIcon {
            let weatherIconName = WeatherIconName(rawValue: currentlyIcon)
            let (icon, size) = weatherIconForName(weatherIconName)
            
            self.navigationItem.leftBarButtonItem?.title = icon
            self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
                NSFontAttributeName : UIFont(name: "Weather Icons", size: size)!,
                NSForegroundColorAttributeName : UIColor.s3Chambray()
                ], forState: .Normal)
        }
        
        let width = ScreenSize.SCREEN_WIDTH - 55 - 55
        let titleView = MarqueeLabel(frame: CGRect(x: 0, y: 0, width: width, height: 24))
        titleView.font = UIFont(name: "Courier", size: 18)
        titleView.textAlignment = .Center
        if let summary = LineChartDataManager.sharedInstance.chartDataSetManager.dataEntryCollator?.summary {
            titleView.text = summary
        } else {
            titleView.text = "Cloudy with a chance of meatballs."
        }
        titleView.trailingBuffer = 36
        titleView.fadeLength = 16
        titleView.triggerScrollStart()
        titleView.animationDelay = 2.0
        self.navigationItem.titleView = titleView
        
        self.navigationItem.rightBarButtonItem?.title = String.fontAwesomeIconWithName(FontAwesome.Gear)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSFontAttributeName : UIFont.fontAwesomeOfSize(25),
            NSForegroundColorAttributeName : UIColor.s3Chambray()
            ], forState: .Normal)
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
            NSForegroundColorAttributeName : UIColor.s1FadedBlue()
            ], forState: .Highlighted)
    }
    
    func reloadCharts() {
        LineChartDataManager.sharedInstance.json = LineChartDataManager.sharedInstance.json
        self.loadChildVCs()
    }
    
    func loadChildVCs() {
        let twelveHourTVC: ChartsTableViewController! = ChartsTableViewController.createNew()
        twelveHourTVC.timeScale = ChartsTableViewControllerTimeScaleOption.TwelveHour
        // setup for KIF - begin
        twelveHourTVC.tableView.accessibilityLabel = "twelveHourTableView"
        twelveHourTVC.tableView.accessibilityIdentifier = "twelveHourTableView"
        // setup for KIF - end
        if let hourlyDatas = LineChartDataManager.sharedInstance.hourlyDatas {
            twelveHourTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            twelveHourTVC.chartDatas = hourlyDatas
        }
        
        let fortyEightHourTVC: ChartsTableViewController! = ChartsTableViewController.createNew()
        fortyEightHourTVC.timeScale = ChartsTableViewControllerTimeScaleOption.FortyEightHour
        // setup for KIF - begin
        fortyEightHourTVC.tableView.accessibilityLabel = "fortyEightHourTableView"
        fortyEightHourTVC.tableView.accessibilityIdentifier = "fortyEightHourTableView"
        // setup for KIF - end
        if let hourlyDatas = LineChartDataManager.sharedInstance.hourlyDatas {
            fortyEightHourTVC.chartSettings = LineChartDataManager.sharedInstance.hourlyChartSettings()
            fortyEightHourTVC.chartDatas = hourlyDatas
        }
        
        let sevenDayTVC: ChartsTableViewController! = ChartsTableViewController.createNew()
        sevenDayTVC.timeScale = ChartsTableViewControllerTimeScaleOption.SevenDay
        // setup for KIF - begin
        sevenDayTVC.tableView.accessibilityLabel = "sevenDayTableView"
        sevenDayTVC.tableView.accessibilityIdentifier = "sevenDayWeekTableView"
        // setup for KIF - end
        if let dailyDatas = LineChartDataManager.sharedInstance.dailyDatas {
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
