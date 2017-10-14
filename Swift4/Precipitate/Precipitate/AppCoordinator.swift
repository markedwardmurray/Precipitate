//
//  AppCoordinator.swift
//  Precipitate
//
//  Created by Mark Murray on 10/13/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import UIKit
import SwiftChart
import DateToolsSwift

class AppCoordinator {
    
    lazy var navigationController: UINavigationController = {
        let navCon = UINavigationController(rootViewController: chartsTableViewController )
        return navCon
    }()
    
    lazy var chartsTableViewController: ChartsTableViewController = {
        let chartsTVC = ChartsTableViewController()
        return chartsTVC
    }()
    
    func start() {
        let coordinate = CLLocationCoordinate2D(latitude: 40.7787898, longitude: -73.9065882)
        let request = DarkSky.Request(coordinate: coordinate,
                                      time: nil,
                                      language: .english,
                                      units: .unitedStates,
                                      exclude: DarkSky.Request.Exclude(rawValue: DarkSky.Request.Exclude.none)
        )
        DarkSky.shared.request(request) { (_, result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                guard let hourly = weather.hourly?.data else { return }
                
                var chartCellModel = ChartCellModel()
                chartCellModel.title = "Temperature"
                
                let times: [TimeInterval] = hourly.map { $0.time }
                let indexSet = (0..<(times.count)).filter { $0 % 4 == 0 }
                chartCellModel.xLabels = indexSet.map { times[$0] }
                chartCellModel.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
                    let date = Date(timeIntervalSince1970: TimeInterval(labelValue))
                    return "\(date.hour)"
                }
                
                let temperatures = ChartSeries(data: hourly.map { (x: $0.time, y: $0.temperature) })
                temperatures.color = .blue
                
                let apparentTemperatures = ChartSeries(data: hourly.map { (x: $0.time, y: $0.apparentTemperature) })
                apparentTemperatures.color = .cyan
                
                chartCellModel.series = [temperatures, apparentTemperatures].reversed()
                
                self.chartsTableViewController.model.chartCellModels = [chartCellModel]
            }
        }
    }
}

