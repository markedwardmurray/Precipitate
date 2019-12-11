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
            updateLegend()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = dynamicTextColor
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private lazy var chart: Chart = {
        let chart = Chart()
        chart.clipsToBounds = true
        return chart
    }()
    
    private lazy var legendStackView: UIStackView = {
        let legendStackView = UIStackView()
        legendStackView.axis = .horizontal
        legendStackView.alignment = .leading
        legendStackView.distribution = .equalSpacing
        legendStackView.spacing = 8
        return legendStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(chart)
        contentView.addSubview(legendStackView)
        
        titleLabel.topAnchor == contentView.topAnchor + 8
        titleLabel.horizontalAnchors == contentView.horizontalAnchors + 8
        
        chart.topAnchor == titleLabel.bottomAnchor + 4
        chart.horizontalAnchors == contentView.horizontalAnchors + 8
        
        legendStackView.topAnchor == chart.bottomAnchor + 4
        legendStackView.leadingAnchor == contentView.leadingAnchor + 20
        legendStackView.trailingAnchor <= contentView.trailingAnchor - 20
        legendStackView.bottomAnchor == contentView.bottomAnchor - 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func updateLegend() {
        legendStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        model.series.reversed().forEach { chartSeries in
            guard let legend = chartSeries.legend else { return }
            let font = UIFont.systemFont(ofSize: 12)
            
            var legendColor: UIColor {
                var color = chartSeries.color
                if !chartSeries.line, chartSeries.area {
                    color = color.withAlphaComponent(model.areaAlphaComponent)
                }
                return color
            }
            
            let label = UILabel()
            traitCollection.performAsCurrent {
                let attText = NSMutableAttributedString(string: "■ ", attributes: [
                    NSAttributedString.Key.foregroundColor: legendColor,
                    NSAttributedString.Key.font: font
                ])
                attText.append(
                    NSAttributedString(string: legend, attributes: [
                        NSAttributedString.Key.foregroundColor: dynamicTextColor,
                        NSAttributedString.Key.font: font
                    ])
                )
                label.attributedText = attText
            }
            
            legendStackView.addArrangedSubview(label)
        }
    }
}

let dynamicTextColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    return traitCollection.userInterfaceStyle == .dark ? .white : .black
}
