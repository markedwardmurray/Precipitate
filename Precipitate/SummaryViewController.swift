//
//  SummaryViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/14/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import FontAwesome_swift
import MarqueeLabel_Swift
import SwiftyUserDefaults

class SummaryViewController: UIViewController {
    let lineChartDataManager = LineChartDataManager.sharedInstance

    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var summaryLabel: MarqueeLabel!
    @IBOutlet weak var settingsButton: UIButton!
    var shouldShowSettings: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.setUpSubviews()
    }
    
    func setUpSubviews() {
        if let currentlyIcon = lineChartDataManager.chartDataSetManager.dataEntryCollator?.currentlyIcon {
            
            let weatherIconName = WeatherIconName(rawValue: currentlyIcon)
            let (icon, size) = weatherIconForName(weatherIconName)
            
            iconButton.titleLabel?.font = UIFont(name: "Weather Icons", size: size)
            
            iconButton.setTitle(icon, forState: UIControlState.Normal)
            iconButton.setTitleColor(UIColor.s3Chambray(), forState:UIControlState.Normal)
            
            iconButton.setTitle(icon, forState: UIControlState.Highlighted)
            iconButton.setTitleColor(UIColor.s1FadedBlue(), forState:UIControlState.Highlighted)
            
        }
        
        if let summary = lineChartDataManager.chartDataSetManager.dataEntryCollator?.summary {
            self.summaryLabel.text = summary + "   "
            self.summaryLabel.triggerScrollStart()
            self.summaryLabel.animationDelay = 2.0;
        }
        
        settingsButton.titleLabel?.font = UIFont.fontAwesomeOfSize(25)
        settingsButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.Gear), forState:UIControlState.Normal)
        settingsButton.setTitleColor(UIColor.s3Chambray(), forState:UIControlState.Normal)
        settingsButton.setTitle(String.fontAwesomeIconWithName(FontAwesome.Gear), forState:UIControlState.Highlighted)
        settingsButton.setTitleColor(UIColor.s3Chambray(), forState:UIControlState.Highlighted)
    }
    
    @IBAction func iconTapped(sender: AnyObject) {
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
