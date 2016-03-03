//
//  SummaryViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/14/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SummaryViewController: UIViewController {
    let lineChartDataManager = LineChartDataManager.sharedInstance

    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    var shouldShowSettings: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.setUpSubviews()
    }
    
    func setUpSubviews() {
        if let currentlyIcon = lineChartDataManager.chartDataSetManager.dataEntryCollator?.currentlyIcon {
            // https://erikflowers.github.io/weather-icons/
            iconButton.titleLabel?.font = UIFont(name: "Weather Icons", size: 20)
            let icon = weatherIconForIconString(currentlyIcon)
            iconButton.setTitle(icon, forState: UIControlState.Normal)
            iconButton.setTitleColor(UIColor.s3Chambray(), forState: UIControlState.Normal)
            iconButton.setTitle(icon, forState: UIControlState.Highlighted)
            iconButton.setTitleColor(UIColor.s1FadedBlue(), forState: UIControlState.Highlighted)
            
        }
        
        if let summary = lineChartDataManager.chartDataSetManager.dataEntryCollator?.summary {
            self.summaryLabel.text = summary
        }
    }
    
    @IBAction func SettingsTapped(sender: AnyObject) {
        self.shouldShowSettings = !self.shouldShowSettings
        
        if self.shouldShowSettings {
            NSNotificationCenter.defaultCenter().postNotificationName("showSettings", object: nil)
        } else {            
            NSNotificationCenter.defaultCenter().postNotificationName("showWeather", object: nil)
        }
    }
}
