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
    
    var model: ChartCellModel = .init() {
        didSet {
            titleLabel.text = model.title
            chart.configure(model)
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var chart: Chart = {
        let chart = Chart()
        chart.clipsToBounds = true
        return chart
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(chart)
        
        titleLabel.topAnchor == contentView.topAnchor + 8
        titleLabel.horizontalAnchors == contentView.horizontalAnchors + 8
        chart.topAnchor == titleLabel.bottomAnchor + 4
        chart.horizontalAnchors == contentView.horizontalAnchors + 8
        chart.bottomAnchor == contentView.bottomAnchor - 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
