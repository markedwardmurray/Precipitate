//
//  ChartCell.swift
//  Precipitate
//
//  Created by Mark Murray on 10/13/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import UIKit
import Anchorage
import SwiftChart

class ChartCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    lazy var chart: Chart = {
        let chart = Chart()
        return chart
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentView.addSubview(chart)
        
        chart.verticalAnchors == contentView.verticalAnchors + 8
        chart.horizontalAnchors == contentView.horizontalAnchors + 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        chart.removeAllSeries()
    }
}
