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
                guard let hourly = weather.hourly else { return }
                
                self.chartsTableViewController.model.chartCellModels = HourlyChartBuilder(hourly).chartCellModels
            }
        }
    }
}

