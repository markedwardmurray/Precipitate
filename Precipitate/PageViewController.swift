//
//  PageViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let apiClient = ForecastAPIClient.sharedInstance
    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    var pages = [ChartsTableViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.apiClient.getForecastForCurrentLocationCompletion { (json) -> Void in
            self.lineChartDataManager.json = json
            self.setUpChildVCs()
        }
    }
    
    func setUpChildVCs() {
        let hourlyTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            hourlyTVC.chartDatas = hourlyDatas
            hourlyTVC.chartKeys = hourlyChartKeys
        }
        
        let dailyTVC: ChartsTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("chartsTVC") as! ChartsTableViewController
        if let dailyDatas = lineChartDataManager.dailyDatas {
            dailyTVC.chartDatas = dailyDatas
            dailyTVC.chartKeys = dailyChartKeys
        }
        
        pages = [hourlyTVC, dailyTVC]
        
        self.setViewControllers([hourlyTVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
        
        let currentIndex = pages.indexOf(chartsTVC)!
        
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let chartsTVC = viewController as! ChartsTableViewController
        
        let currentIndex = pages.indexOf(chartsTVC)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    var hourlyChartKeys: [String] =
    [
        "temperature",
        "apparentTemperature",
        
        "precipProbability",
        "precipIntensity",
        "precipAccumulation",
        
        "windSpeed",
        "cloudCover",
        "visibility",
        
        "ozone",
        "humidity",
        "dewpoint",
        "pressure",
    ]
    
    var dailyChartKeys: [String] =
    [
        "temperatureMin",
        "temperatureMax",
        "apparentTemperatureMin",
        "apparentTemperatureMax",
        
        "precipProbability",
        "precipIntensity",
        "precipIntensityMax",
        
        "windSpeed",
        "cloudCover",
        "visibility",
        
        "ozone",
        "humidity",
        "dewpoint",
        "pressure"
    ]
}
