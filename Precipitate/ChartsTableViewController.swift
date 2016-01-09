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

class ChartsTableViewController: UITableViewController {
    var chartDatas = [String : LineChartData]()
    var chartKeys = [String]()
    var timescale: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartKeys.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let lineChartCell: LineChartCell = tableView.dequeueReusableCellWithIdentifier("lineChartCell", forIndexPath: indexPath) as! LineChartCell
        
        let chartKey = chartKeys[indexPath.row]
        let chartData = chartDatas[chartKey]
        lineChartCell.lineChartView.data = chartData
            
        // LineChartView settings
        
        lineChartCell.lineChartView.descriptionText = ""
        lineChartCell.lineChartView.doubleTapToZoomEnabled = false
        
        //////////////////////
        
        return lineChartCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.timescale
        default:
            return nil
        }
    }
}
