//
//  SummaryViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/14/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    let lineChartDataManager = LineChartDataManager.sharedInstance

    @IBOutlet weak var iconLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentlyIcon = lineChartDataManager.chartDataSetManager.dataEntryCollator?.currentlyIcon {
            iconLabel.text = self.iconForIconString(currentlyIcon)
        }
    }
    
    func iconForIconString(iconString: String) -> String {
        switch iconString {
        case "clear-day":
            return ""
        case "clear-night":
            return ""
        case "rain":
            return ""
        case "snow":
            return ""
        case "sleet":
            return ""
        case "wind":
            return ""
        case "fog":
            return ""
        case "cloudy":
            return ""
        case "partly-cloudy-day":
            return ""
        case "partly-cloudy-night":
            return ""
        default:
            return ""
        }
    }
}
