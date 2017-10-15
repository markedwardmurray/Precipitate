//
//  HourlyChartBuilder.swift
//  Precipitate
//
//  Created by Mark Murray on 10/14/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import Foundation
import SwiftChart

let percentageFormatter: NumberFormatter = {
    let percentageFormatter = NumberFormatter()
    percentageFormatter.numberStyle = .percent
    return percentageFormatter
}()

struct HourlyChartBuilder {
    let dataBlock: DataBlock<Hourly>
    let times: [TimeInterval]
    
    init(_ dataBlock: DataBlock<Hourly>) {
        self.dataBlock = dataBlock
        self.times = dataBlock.data.map { $0.time }
    }
    
    var chartCellModels: [ChartCellModel] {
        return [
            temperature,
            precipProbability,
            wind,
            cloudCover,
            uvIndex
        ]
    }
    
    private func defaultChartCellModel(title: String, series: [ChartSeries] ) -> ChartCellModel {
        var chartCellModel = ChartCellModel()
        chartCellModel.title = title
        chartCellModel.series = series.reversed()
        
        chartCellModel.highlightLineColor = .clear
        
        let indexSet = (0..<(times.count)).filter { $0 % 4 == 0 }
        chartCellModel.xLabels = indexSet.map { times[$0] }
        chartCellModel.xLabelsSkipLast = true
        chartCellModel.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            let date = Date(timeIntervalSince1970: TimeInterval(labelValue))
            return "\(date.hour)"
        }
        
        return chartCellModel
    }
    
    private func percentageChartCellModel(title: String, series: [ChartSeries] ) -> ChartCellModel {
        var chartCellModel = defaultChartCellModel(title: title, series: series)
        chartCellModel.yLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return percentageFormatter.string(from: NSNumber(value: labelValue) ) ?? ""
        }
        chartCellModel.minY = 0
        chartCellModel.maxY = 1
        
        return chartCellModel
    }
    
    private var temperature: ChartCellModel {
        let temperatures = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: $0.temperature) })
        temperatures.color = .blue
        
        let apparentTemperatures = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: $0.apparentTemperature) })
        apparentTemperatures.color = .cyan
        
        return defaultChartCellModel(title: "Temperature", series: [temperatures, apparentTemperatures])
    }
    
    private var precipProbability: ChartCellModel {
        let precipProbability = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: $0.precipProbability) })
        precipProbability.color = .blue
        precipProbability.area = true
        precipProbability.line = false
        
        return percentageChartCellModel(title: "Precip %", series: [precipProbability])
    }
    
    private var cloudCover: ChartCellModel {
        let cloudCover = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: $0.cloudCover) })
        cloudCover.color = .blue
        cloudCover.area = true
        cloudCover.line = false
        
        return percentageChartCellModel(title: "Cloud Cover", series: [cloudCover])
    }
    
    private var uvIndex: ChartCellModel {
        let uvIndex = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: Double($0.uvIndex)) })
        uvIndex.color = UIColor.orange
        uvIndex.area = true
        uvIndex.line = false
        
        var chartCellModel = defaultChartCellModel(title: "UV Index", series: [uvIndex])
        chartCellModel.minY = 0
        chartCellModel.maxY = 10
        chartCellModel.areaAlphaComponent = 0.4
        
        return chartCellModel
    }
    
    private var wind: ChartCellModel {
        let windSpeed = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: $0.windSpeed) })
        windSpeed.color = .blue
        
        let windGust = ChartSeries(data: dataBlock.data.map { (x: $0.time, y: $0.windGust) })
        windGust.color = .cyan
        
        var chartCellModel = defaultChartCellModel(title: "Wind Speed", series: [windSpeed, windGust])
        chartCellModel.minY = 0

        return chartCellModel
    }
}

