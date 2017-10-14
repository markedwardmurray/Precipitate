//
//  ChartsTableViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 10/12/17.
//  Copyright © 2017 Mark Edward Murray. All rights reserved.
//

import UIKit
import Anchorage
import SwiftChart

class ChartsTableViewController: UITableViewController {
    
    struct Model {
        var chartSeriess: [ChartSeries] = []
    }
    
    var model: Model = .init() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.reuseIdentifier)
        
        tableView.rowHeight = 88
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.chartSeriess.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chartCell = tableView.dequeueReusableCell(withIdentifier: ChartCell.reuseIdentifier, for: indexPath) as! ChartCell
        
        let chartSeries = model.chartSeriess[indexPath.row]
        chartCell.chart.add(chartSeries)
        
        return chartCell
    }
}

