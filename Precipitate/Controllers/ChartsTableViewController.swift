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
    case TwelveHour = 1
    case FortyEightHour = 2
    case SevenDay = 3
}

class ChartsTableViewController: UITableViewController {
    static let storyboard: UIStoryboard = UIStoryboard(name: "Weather", bundle: nil)
    static let storyboardId: String = "ChartsTableViewController"
    
    class func createNew() -> ChartsTableViewController {
        return self.storyboard.instantiateViewControllerWithIdentifier(self.storyboardId) as! ChartsTableViewController
    }
    
    var chartSettings = [LineChartDataSettings]()
    
    var chartDatas = [String : LineChartData]()
    
    var timeScale: ChartsTableViewControllerTimeScaleOption = .NotDetermined
    
    var timeScaleLabel: String {
        switch self.timeScale {
        case .NotDetermined:
            return ""
        case .TwelveHour:
            return "12-hour"
        case .FortyEightHour:
            return "48-hour"
        case .SevenDay:
            return "7-day"
        }
    }
    
    var chartViewColor: UIColor {
        switch self.timeScale {
        case .NotDetermined:
            return UIColor.s00Thorzum()
        case .TwelveHour:
            return UIColor.s00Thorzum()
        case .FortyEightHour:
            return UIColor.p00Zumthor()
        case .SevenDay:
            return UIColor.t00TwilightBlue()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.allowsSelection = false
        
        self.tableView.contentInset.bottom = 24.0
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = self.chartViewColor
        header.textLabel?.textAlignment = NSTextAlignment.Center
    }
        
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartSettings.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chartCell: LineChartCell = tableView.dequeueReusableCellWithIdentifier("lineChartCell", forIndexPath: indexPath) as! LineChartCell
        
        let chartSetting = chartSettings[indexPath.row]
        chartCell.title.text = "\(chartSetting.label) (\(chartSetting.units))"
        chartCell.lineChartView.data = chartDatas[chartSetting.label]
        chartCell.lineChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter() // chartSetting.formatter
        chartCell.lineChartView.rightAxis.valueFormatter = DefaultAxisValueFormatter() //  chartSetting.formatter
        chartCell.lineChartView.rightAxis.enabled = DeviceType.IS_IPHONE_6P
        
        switch self.timeScale {
        case .TwelveHour:
            chartCell.lineChartView.setVisibleXRange(minXRange: 12, maxXRange: 12)
            break;
        case .FortyEightHour:
            chartCell.lineChartView.setVisibleXRange(minXRange: 48, maxXRange: 48)
            break;
        case .SevenDay:
            chartCell.lineChartView.setVisibleXRange(minXRange: 7, maxXRange: 7)
        default:
            break;
        }
        
        chartCell.lineChartView.backgroundColor = self.chartViewColor
        chartCell.lineChartView.gridBackgroundColor = UIColor(white: 1.0, alpha: 0.5)
        
        return chartCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let pageControlHeight: CGFloat = 40.0
        let orientation = UIApplication.sharedApplication().statusBarOrientation
        if (orientation == .LandscapeLeft || orientation == .LandscapeRight) {
            return ScreenSize.SCREEN_WIDTH - UIApplication.sharedApplication().statusBarFrame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - self.tableView.sectionHeaderHeight - pageControlHeight
        }
        
        let tableViewDisplayHeight: CGFloat = ScreenSize.SCREEN_HEIGHT - UIApplication.sharedApplication().statusBarFrame.size.height - (self.navigationController?.navigationBar.frame.size.height)! - self.tableView.sectionHeaderHeight - pageControlHeight
        
        if (DeviceType.IS_IPHONE_4_OR_LESS) {
            return  tableViewDisplayHeight / 2
        }
        return tableViewDisplayHeight / 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.timeScaleLabel
        default:
            return nil
        }
    }
    
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let tableViewHeaderHeight = self.tableView(self.tableView, heightForHeaderInSection: 0)
        let rowHeight = self.tableView(self.tableView, heightForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        let cellOffsetCount = (targetContentOffset.memory.y - tableViewHeaderHeight) / rowHeight
        let cellOffset = round(cellOffsetCount) * rowHeight
        
        targetContentOffset.memory.y = cellOffset + tableViewHeaderHeight
    }
}
