//
//  LineChartCell.swift
//  Precipitate
//
//  Created by Mark Murray on 12/7/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import Charts

class LineChartCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func awakeFromNib() {
        self.lineChartView.descriptionText = ""
        self.lineChartView.doubleTapToZoomEnabled = false
        self.lineChartView.pinchZoomEnabled = false
        self.lineChartView.dragEnabled = false
        self.lineChartView.backgroundColor = UIColor.glitter()
        self.lineChartView.gridBackgroundColor = UIColor.aliceBlue()
        self.lineChartView.layer.cornerRadius = 10
        self.lineChartView.layer.masksToBounds = true
        self.lineChartView.drawMarkers = true
    }
}
