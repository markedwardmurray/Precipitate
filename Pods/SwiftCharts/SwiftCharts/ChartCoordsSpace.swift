//
//  ChartCoordsSpace.swift
//  SwiftCharts
//
//  Created by ischuetz on 27/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

/**
 A ChartCoordsSpace calculates the chart's inner frame and generates the axis layers based on given axis models, chart size and chart settings. In doing so it's able to calculate the frame for the inner area of the chart where points, bars, lines, etc. are drawn to represent data.
 
 ````
                         ┌────────────────────────────────────────────────┐
                         │                ChartSettings.top               │
                         │  ┌────┬────────────────────────────────┬────┐  │
                         │  │    │                X               │    │  │
                         │  │    │               high             │    │  │
                         │  ├────┼────────────────────────────────┼────┤  │
                         │  │    │                                │    │  │
                         │  │    │                                │    │  │
                         │  │    │                                │    │  │
                         │  │    │                                │    │  │
 ChartSettings.leading ──┼▶ │ Y  │        Chart Inner Frame       │ Y  │ ◀┼── ChartSettings.trailing
                         │  │low │                                │high│  │
                         │  │    │                                │    │  │
                         │  │    │                                │    │  │
                         │  ├────┼────────────────────────────────┼────┤  │
                         │  │    │                X               │    │  │
                         │  │    │               low              │    │  │
                         │  └────┴────────────────────────────────┴────┘  │
                         │               ChartSettings.bottom             │
                         └────────────────────────────────────────────────┘
                         │─────────────────── chartSize ──────────────────│
 ````
 */
public class ChartCoordsSpace {
    
    public typealias ChartAxisLayerModel = (p1: CGPoint, p2: CGPoint, axisValues: [ChartAxisValue], axisTitleLabels: [ChartAxisLabel], settings: ChartAxisSettings)
    public typealias ChartAxisLayerGenerator = (ChartAxisLayerModel) -> ChartAxisLayer
    
    private let chartSettings: ChartSettings
    private let chartSize: CGSize
    
    public private(set) var chartInnerFrame: CGRect = CGRectZero

    private let yLowModels: [ChartAxisModel]
    private let yHighModels: [ChartAxisModel]
    private let xLowModels: [ChartAxisModel]
    private let xHighModels: [ChartAxisModel]

    private let yLowGenerator: ChartAxisLayerGenerator
    private let yHighGenerator: ChartAxisLayerGenerator
    private let xLowGenerator: ChartAxisLayerGenerator
    private let xHighGenerator: ChartAxisLayerGenerator

    public private(set) var yLowAxes: [ChartAxisLayer] = []
    public private(set) var yHighAxes: [ChartAxisLayer] = []
    public private(set) var xLowAxes: [ChartAxisLayer] = []
    public private(set) var xHighAxes: [ChartAxisLayer] = []

    /**
     A convenience initializer with default axis layer generators

     - parameter chartSettings: The chart layout settings
     - parameter chartSize:     The desired size of the chart
     - parameter yLowModels:    The chart axis model used to generate the Y low axis
     - parameter yHighModels:   The chart axis model used to generate the Y high axis
     - parameter xLowModels:    The chart axis model used to generate the X low axis
     - parameter xHighModels:   The chart axis model used to generate the X high axis

     - returns: The coordinate space with generated axis layers
     */
    public convenience init(chartSettings: ChartSettings, chartSize: CGSize, yLowModels: [ChartAxisModel] = [], yHighModels: [ChartAxisModel] = [], xLowModels: [ChartAxisModel] = [], xHighModels: [ChartAxisModel] = []) {
        
        let yLowGenerator: ChartAxisLayerGenerator = {model in
            ChartAxisYLowLayerDefault(p1: model.p1, p2: model.p2, axisValues: model.axisValues, axisTitleLabels: model.axisTitleLabels, settings: model.settings)
        }
        let yHighGenerator: ChartAxisLayerGenerator = {model in
            ChartAxisYHighLayerDefault(p1: model.p1, p2: model.p2, axisValues: model.axisValues, axisTitleLabels: model.axisTitleLabels, settings: model.settings)
        }
        let xLowGenerator: ChartAxisLayerGenerator = {model in
            ChartAxisXLowLayerDefault(p1: model.p1, p2: model.p2, axisValues: model.axisValues, axisTitleLabels: model.axisTitleLabels, settings: model.settings)
        }
        let xHighGenerator: ChartAxisLayerGenerator = {model in
            ChartAxisXHighLayerDefault(p1: model.p1, p2: model.p2, axisValues: model.axisValues, axisTitleLabels: model.axisTitleLabels, settings: model.settings)
        }
        
        self.init(chartSettings: chartSettings, chartSize: chartSize, yLowModels: yLowModels, yHighModels: yHighModels, xLowModels: xLowModels, xHighModels: xHighModels, yLowGenerator: yLowGenerator, yHighGenerator: yHighGenerator, xLowGenerator: xLowGenerator, xHighGenerator: xHighGenerator)
    }
    
    public init(chartSettings: ChartSettings, chartSize: CGSize, yLowModels: [ChartAxisModel], yHighModels: [ChartAxisModel], xLowModels: [ChartAxisModel], xHighModels: [ChartAxisModel], yLowGenerator: ChartAxisLayerGenerator, yHighGenerator: ChartAxisLayerGenerator, xLowGenerator: ChartAxisLayerGenerator, xHighGenerator: ChartAxisLayerGenerator) {
        self.chartSettings = chartSettings
        self.chartSize = chartSize
        
        self.yLowModels = yLowModels
        self.yHighModels = yHighModels
        self.xLowModels = xLowModels
        self.xHighModels = xHighModels
        
        self.yLowGenerator = yLowGenerator
        self.yHighGenerator = yHighGenerator
        self.xLowGenerator = xLowGenerator
        self.xHighGenerator = xHighGenerator
        
        self.chartInnerFrame = self.calculateChartInnerFrame()
        
        self.yLowAxes = self.generateYLowAxes()
        self.yHighAxes = self.generateYHighAxes()
        self.xLowAxes = self.generateXLowAxes()
        self.xHighAxes = self.generateXHighAxes()
    }
    
    private func generateYLowAxes() -> [ChartAxisLayer] {
        return generateYAxisShared(axisModels: self.yLowModels, offset: chartSettings.leading, generator: self.yLowGenerator)
    }
    
    private func generateYHighAxes() -> [ChartAxisLayer] {
        let chartFrame = self.chartInnerFrame
        return generateYAxisShared(axisModels: self.yHighModels, offset: chartFrame.origin.x + chartFrame.width, generator: self.yHighGenerator)
    }
    
    private func generateXLowAxes() -> [ChartAxisLayer] {
        let chartFrame = self.chartInnerFrame
        let y = chartFrame.origin.y + chartFrame.height
        return self.generateXAxesShared(axisModels: self.xLowModels, offset: y, generator: self.xLowGenerator)
    }
    
    private func generateXHighAxes() -> [ChartAxisLayer] {
        return self.generateXAxesShared(axisModels: self.xHighModels, offset: chartSettings.top, generator: self.xHighGenerator)
    }

    /**
     Uses a generator to make X axis layers from axis models. This method is used for both low and high X axes.

     - parameter axisModels: The models used to generate the axis layers
     - parameter offset:     The offset in points for the generated layers
     - parameter generator:  The generator used to create the layers

     - returns: An array of ChartAxisLayers
     */
    private func generateXAxesShared(axisModels axisModels: [ChartAxisModel], offset: CGFloat, generator: ChartAxisLayerGenerator) -> [ChartAxisLayer] {
        let chartFrame = self.chartInnerFrame
        let chartSettings = self.chartSettings
        let x = chartFrame.origin.x
        let length = chartFrame.width
        
        return generateAxisShared(axisModels: axisModels, offset: offset, boundingPointsCreator: { offset in
            (p1: CGPointMake(x, offset), p2: CGPointMake(x + length, offset))
            }, nextLayerOffset: { layer in
                layer.rect.height + chartSettings.spacingBetweenAxesX
            }, generator: generator)
    }
    
    /**
     Uses a generator to make Y axis layers from axis models. This method is used for both low and high Y axes.

     - parameter axisModels: The models used to generate the axis layers
     - parameter offset:     The offset in points for the generated layers
     - parameter generator:  The generator used to create the layers

     - returns: An array of ChartAxisLayers
     */
    private func generateYAxisShared(axisModels axisModels: [ChartAxisModel], offset: CGFloat, generator: ChartAxisLayerGenerator) -> [ChartAxisLayer] {
        let chartFrame = self.chartInnerFrame
        let chartSettings = self.chartSettings
        let y = chartFrame.origin.y
        let length = chartFrame.height
        
        return generateAxisShared(axisModels: axisModels, offset: offset, boundingPointsCreator: { offset in
            (p1: CGPointMake(offset, y + length), p2: CGPointMake(offset, y))
            }, nextLayerOffset: { layer in
                layer.rect.width + chartSettings.spacingBetweenAxesY
            }, generator: generator)
    }

    /**
     Uses a generator to make axis layers from axis models. This method is used for all axes.

     - parameter axisModels:            The models used to generate the axis layers
     - parameter offset:                The offset in points for the generated layers
     - parameter boundingPointsCreator: A closure that creates a tuple containing the location of the smallest and largest values along the axis. For example, boundingPointsCreator for a Y axis might return a value like (p1: CGPoint(x, 0), p2: CGPoint(x, 100)), where x is the offset of the axis layer.
     - parameter nextLayerOffset:       A closure that returns the offset of the next axis layer relative to the current layer
     - parameter generator:             The generator used to create the layers

     - returns: An array of ChartAxisLayers
     */
    private func generateAxisShared(axisModels axisModels: [ChartAxisModel], offset: CGFloat, boundingPointsCreator: (offset: CGFloat) -> (p1: CGPoint, p2: CGPoint), nextLayerOffset: (ChartAxisLayer) -> CGFloat, generator: ChartAxisLayerGenerator) -> [ChartAxisLayer] {
        
        let chartSettings = self.chartSettings
        
        return axisModels.reduce((axes: Array<ChartAxisLayer>(), x: offset)) {tuple, chartAxisModel in
            let layers = tuple.axes
            let x: CGFloat = tuple.x
            let axisSettings = ChartAxisSettings(chartSettings)
            axisSettings.lineColor = chartAxisModel.lineColor
            let points = boundingPointsCreator(offset: x)
            let layer = generator(p1: points.p1, p2: points.p2, axisValues: chartAxisModel.axisValues, axisTitleLabels: chartAxisModel.axisTitleLabels, settings: axisSettings)
            return (
                axes: layers + [layer],
                x: x + nextLayerOffset(layer)
            )
        }.0
    }

    /**
     Calculates the inner frame of the chart, which in short is the area where your points, bars, lines etc. are drawn. In order to calculate this frame the axes will be generated.

     - returns: The inner frame as a CGRect
     */
    private func calculateChartInnerFrame() -> CGRect {
        
        let totalDim = {(axisLayers: [ChartAxisLayer], dimPicker: (ChartAxisLayer) -> CGFloat, spacingBetweenAxes: CGFloat) -> CGFloat in
            return axisLayers.reduce((CGFloat(0), CGFloat(0))) {tuple, chartAxisLayer in
                let totalDim = tuple.0 + tuple.1
                return (totalDim + dimPicker(chartAxisLayer), spacingBetweenAxes)
            }.0
        }

        func totalWidth(axisLayers: [ChartAxisLayer]) -> CGFloat {
            return totalDim(axisLayers, {$0.rect.width}, self.chartSettings.spacingBetweenAxesY)
        }
        
        func totalHeight(axisLayers: [ChartAxisLayer]) -> CGFloat {
            return totalDim(axisLayers, {$0.rect.height}, self.chartSettings.spacingBetweenAxesX)
        }
        
        let yLowWidth = totalWidth(self.generateYLowAxes())
        let yHighWidth = totalWidth(self.generateYHighAxes())
        let xLowHeight = totalHeight(self.generateXLowAxes())
        let xHighHeight = totalHeight(self.generateXHighAxes())
        
        let leftWidth = yLowWidth + self.chartSettings.leading
        let topHeigth = xHighHeight + self.chartSettings.top
        let rightWidth = yHighWidth + self.chartSettings.trailing
        let bottomHeight = xLowHeight + self.chartSettings.bottom
        
        return CGRectMake(
            leftWidth,
            topHeigth,
            self.chartSize.width - leftWidth - rightWidth,
            self.chartSize.height - topHeigth - bottomHeight
        )
    }
}

/// A ChartCoordsSpace subclass specifically for a chart with axes along the left and bottom edges
public class ChartCoordsSpaceLeftBottomSingleAxis {

    public let yAxis: ChartAxisLayer
    public let xAxis: ChartAxisLayer
    public let chartInnerFrame: CGRect
    
    public init(chartSettings: ChartSettings, chartFrame: CGRect, xModel: ChartAxisModel, yModel: ChartAxisModel) {
        let coordsSpaceInitializer = ChartCoordsSpace(chartSettings: chartSettings, chartSize: chartFrame.size, yLowModels: [yModel], xLowModels: [xModel])
        self.chartInnerFrame = coordsSpaceInitializer.chartInnerFrame
        
        self.yAxis = coordsSpaceInitializer.yLowAxes[0]
        self.xAxis = coordsSpaceInitializer.xLowAxes[0]
    }
}

/// A ChartCoordsSpace subclass specifically for a chart with axes along the left and top edges
public class ChartCoordsSpaceLeftTopSingleAxis {
    
    public let yAxis: ChartAxisLayer
    public let xAxis: ChartAxisLayer
    public let chartInnerFrame: CGRect
    
    public init(chartSettings: ChartSettings, chartFrame: CGRect, xModel: ChartAxisModel, yModel: ChartAxisModel) {
        let coordsSpaceInitializer = ChartCoordsSpace(chartSettings: chartSettings, chartSize: chartFrame.size, yLowModels: [yModel], xHighModels: [xModel])
        self.chartInnerFrame = coordsSpaceInitializer.chartInnerFrame
        
        self.yAxis = coordsSpaceInitializer.yLowAxes[0]
        self.xAxis = coordsSpaceInitializer.xHighAxes[0]
    }
}

/// A ChartCoordsSpace subclass specifically for a chart with axes along the right and bottom edges
public class ChartCoordsSpaceRightBottomSingleAxis {
    
    public let yAxis: ChartAxisLayer
    public let xAxis: ChartAxisLayer
    public let chartInnerFrame: CGRect
    
    public init(chartSettings: ChartSettings, chartFrame: CGRect, xModel: ChartAxisModel, yModel: ChartAxisModel) {
        let coordsSpaceInitializer = ChartCoordsSpace(chartSettings: chartSettings, chartSize: chartFrame.size, yHighModels: [yModel], xLowModels: [xModel])
        self.chartInnerFrame = coordsSpaceInitializer.chartInnerFrame
        
        self.yAxis = coordsSpaceInitializer.yHighAxes[0]
        self.xAxis = coordsSpaceInitializer.xLowAxes[0]
    }
}

/// A ChartCoordsSpace subclass specifically for a chart with axes along the right and top edges
public class ChartCoordsSpaceRightTopSingleAxis {
    
    public let yAxis: ChartAxisLayer
    public let xAxis: ChartAxisLayer
    public let chartInnerFrame: CGRect
    
    public init(chartSettings: ChartSettings, chartFrame: CGRect, xModel: ChartAxisModel, yModel: ChartAxisModel) {
        let coordsSpaceInitializer = ChartCoordsSpace(chartSettings: chartSettings, chartSize: chartFrame.size, yHighModels: [yModel], xHighModels: [xModel])
        self.chartInnerFrame = coordsSpaceInitializer.chartInnerFrame
        
        self.yAxis = coordsSpaceInitializer.yHighAxes[0]
        self.xAxis = coordsSpaceInitializer.xHighAxes[0]
    }
}