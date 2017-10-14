//
//  Charting.swift
//  Precipitate
//
//  Created by Mark Murray on 10/13/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import SwiftChart

struct ChartModel {
    var identifier: String?
    
    /**
     Series to display in the chart.
     */
    var series: [ChartSeries] = []
    
    /**
     The values to display as labels on the x-axis. You can format these values  with the `xLabelFormatter` attribute.
     As default, it will display the values of the series which has the most data.
     */
    var xLabels: [Float]?
    
    /**
     Formatter for the labels on the x-axis. The `index` represents the `xLabels` index, `value` its value:
     */
    var xLabelsFormatter = { (labelIndex: Int, labelValue: Float) -> String in
        String(Int(labelValue))
    }
    
    /**
     Text alignment for the x-labels
     */
    var xLabelsTextAlignment: NSTextAlignment = .left
    
    /**
     Orientation for the x-labels
     */
    var xLabelsOrientation: ChartLabelOrientation = .horizontal
    
    /**
     Skip the last x-label. Setting this to false may make the label overflow the frame width.
     */
    var xLabelsSkipLast: Bool = true
    
    /**
     Values to display as labels of the y-axis. If not specified, will display the
     lowest, the middle and the highest values.
     */
    var yLabels: [Float]?
    
    /**
     Formatter for the labels on the y-axis.
     */
    var yLabelsFormatter = { (labelIndex: Int, labelValue: Float) -> String in
        String(Int(labelValue))
    }
    
    /**
     Displays the y-axis labels on the right side of the chart.
     */
    var yLabelsOnRightSide: Bool = false
    
    /**
     Font used for the labels.
     */
    var labelFont: UIFont? = UIFont.systemFont(ofSize: 12)
    
    /**
     Font used for the labels.
     */
    var labelColor: UIColor = UIColor.black
    
    /**
     Color for the axes.
     */
    var axesColor: UIColor = UIColor.gray.withAlphaComponent(0.3)
    
    /**
     Color for the grid.
     */
    var gridColor: UIColor = UIColor.gray.withAlphaComponent(0.3)
    /**
     Should draw lines for labels on X axis.
     */
    var showXLabelsAndGrid: Bool = true
    /**
     Should draw lines for labels on Y axis.
     */
    var showYLabelsAndGrid: Bool = true
    
    /**
     Height of the area at the bottom of the chart, containing the labels for the x-axis.
     */
    var bottomInset: CGFloat = 20
    
    /**
     Height of the area at the top of the chart, acting a padding to make place for the top y-axis label.
     */
    var topInset: CGFloat = 20
    
    /**
     Width of the chart's lines.
     */
    var lineWidth: CGFloat = 2
    
    /**
     Custom minimum value for the x-axis.
     */
    var minX: Float?
    
    /**
     Custom minimum value for the y-axis.
     */
    var minY: Float?
    
    /**
     Custom maximum value for the x-axis.
     */
    var maxX: Float?
    
    /**
     Custom maximum value for the y-axis.
     */
    var maxY: Float?
    
    /**
     Color for the highlight line.
     */
    var highlightLineColor = UIColor.gray
    
    /**
     Width for the highlight line.
     */
    var highlightLineWidth: CGFloat = 0.5
    
    /**
     Alpha component for the area's color.
     */
    var areaAlphaComponent: CGFloat = 0.1
}

extension Chart {
    func configure(_ model: ChartModel) {
        identifier = model.identifier

        series = model.series
        
        xLabels = model.xLabels
        xLabelsFormatter = model.xLabelsFormatter
        xLabelsTextAlignment = model.xLabelsTextAlignment
        xLabelsOrientation = model.xLabelsOrientation
        xLabelsSkipLast = model.xLabelsSkipLast
        
        yLabels = model.yLabels
        yLabelsFormatter = model.yLabelsFormatter
        yLabelsOnRightSide = model.yLabelsOnRightSide

        labelFont = model.labelFont
        labelColor = model.labelColor
        axesColor = model.axesColor
        gridColor = model.gridColor

        showXLabelsAndGrid = model.showXLabelsAndGrid
        showYLabelsAndGrid = model.showYLabelsAndGrid

        bottomInset = model.bottomInset
        topInset = model.topInset

        lineWidth = model.lineWidth

        minX = model.minX
        minY = model.minY
        maxX = model.maxX
        maxY = model.maxY
        
        highlightLineColor = model.highlightLineColor
        highlightLineWidth = model.highlightLineWidth
        areaAlphaComponent = model.areaAlphaComponent
    }
}
