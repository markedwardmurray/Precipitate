//
//  ChartsTableViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/7/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import SwiftyJSON
import Charts
import INTULocationManager

class ChartsTableViewController: UITableViewController {
    let apiClient = ForecastAPIClient.sharedInstance
    let lineChartDataManager = LineChartDataManager.sharedInstance
    let locationManager = INTULocationManager.sharedInstance()
    
    var json: JSON?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // just saving on API calls, using the cache instead
        
        locationManager.requestLocationWithDesiredAccuracy(INTULocationAccuracy.Block, timeout: NSTimeInterval(20), delayUntilAuthorized: true) { (location, accuracy, status) -> Void in
            print(status)
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            self.apiClient.getForecastForLatitude(latitude, longitude: longitude, completion: { (json) -> Void in
                //print(json)
                self.lineChartDataManager.json = json
                self.tableView.reloadData()
            })
        }
        

        
        json = apiClient.retrieveCachedJSON()
        NSLog("retrieved json")
        
        if let json = json {
            lineChartDataManager.json = json
        } else {
            print("no cached json")
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = lineChartDataManager.hourlyDatas?.count {
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let lineChartCell: LineChartCell = tableView.dequeueReusableCellWithIdentifier("lineChartCell", forIndexPath: indexPath) as! LineChartCell
        
        if let hourlyDatas = lineChartDataManager.hourlyDatas {
            let hourlyChartKey = self.hourlyChartKeys[indexPath.row]
            lineChartCell.lineChartView.data = hourlyDatas[hourlyChartKey]
        }
        
        // chart view settings
        
        lineChartCell.lineChartView.descriptionText = ""
        lineChartCell.lineChartView.doubleTapToZoomEnabled = false
        
        //////////////////////
        
        return lineChartCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
}
