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
    var chartSettings = [LineChartDataSettings]()
    
    var chartDatas = [String : LineChartData]()
    //var chartKeys = [String]()
    var timescale: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.allowsSelection = false
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartSettings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chartCell: LineChartCell = tableView.dequeueReusableCellWithIdentifier("lineChartCell", forIndexPath: indexPath) as! LineChartCell
        
        let chartSetting = chartSettings[indexPath.row]
        chartCell.title.text = "\(chartSetting.label) (\(chartSetting.units))"
        chartCell.lineChartView.data = chartDatas[chartSetting.label]
        chartCell.lineChartView.leftAxis.valueFormatter = chartSetting.formatter
        chartCell.lineChartView.rightAxis.enabled = false
        
        // LineChartView settings
        
//        lineChartCell.lineChartView.descriptionText = ""
//        lineChartCell.lineChartView.doubleTapToZoomEnabled = false
//        lineChartCell.lineChartView.pinchZoomEnabled = false
//        lineChartCell.lineChartView.backgroundColor = UIColor.glitter()
//        lineChartCell.lineChartView.layer.cornerRadius = 10
        
        //////////////////////
        
        return chartCell
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
