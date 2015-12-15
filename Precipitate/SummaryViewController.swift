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
        
        self.setUpSubviews()
    }
    
    func setUpSubviews() {
        if let currentlyIcon = lineChartDataManager.chartDataSetManager.dataEntryCollator?.currentlyIcon {
            iconLabel.text = weatherIconForIconString(currentlyIcon)
        }
    }
    
}
