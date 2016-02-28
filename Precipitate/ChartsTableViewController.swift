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

enum ChartsTableViewControllerTimeScaleOption: Int {
    case NotDetermined = 0
    case Today = 1
    case Tomorrow = 2
    case Weekly = 3
}

class ChartsTableViewController: UITableViewController {
    var chartSettings = [LineChartDataSettings]()
    
    var chartDatas = [String : LineChartData]()
    
    var timeScale: ChartsTableViewControllerTimeScaleOption = .NotDetermined
    
    var timeScaleLabel: String {
        switch self.timeScale {
        case .NotDetermined:
            return ""
        case .Today:
            return "Today (next 24 hours)"
        case .Tomorrow:
            return "Following 24 Hours"
        case .Weekly:
            return "This Week (next 7 days)"
        }
    }
    
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
        
        return chartCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.timeScaleLabel
        default:
            return nil
        }
    }
}
