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
    let dataConverter = DataConverter.sharedInstance
    let locationManager = INTULocationManager.sharedInstance()
    
    var json: JSON?
    
    var hourlyHumidityDataSet: LineChartDataSet?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* just saving on API calls, using the cache instead
        
        locationManager.requestLocationWithDesiredAccuracy(INTULocationAccuracy.Block, timeout: NSTimeInterval(20), delayUntilAuthorized: true) { (location, accuracy, status) -> Void in
            print(status)
            
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            self.apiClient.getForecastForLatitude(latitude, longitude: longitude, completion: { (json) -> Void in
                print(json)
                self.hourlyHumidityDataSet = self.dataConverter.hourlyHumidityDataFromJSON(json)
                self.tableView.reloadData()
            })
        }

        */
        
        json = apiClient.retrieveCachedJSON()
        
        if let json = json {
            hourlyHumidityDataSet = dataConverter.hourlyHumidityDataFromJSON(json)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let lineChartCell: LineChartCell = tableView.dequeueReusableCellWithIdentifier("lineChartCell", forIndexPath: indexPath) as! LineChartCell
        
        if let hourlyHumidityDataSet = hourlyHumidityDataSet {
            let lineChartData = LineChartData(xVals: ["now", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"], dataSets: [hourlyHumidityDataSet])

            lineChartCell.lineChartView.data = lineChartData
        }
        
        lineChartCell.lineChartView.doubleTapToZoomEnabled = false
        
        // configure the cell
        
        return lineChartCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
}
