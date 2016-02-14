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

    @IBOutlet weak var iconLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    var shouldShowSettings: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpSubviews()
    }
    
    func setUpSubviews() {
        if let currentlyIcon = lineChartDataManager.chartDataSetManager.dataEntryCollator?.currentlyIcon {
            iconLabel.text = weatherIconForIconString(currentlyIcon)
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
