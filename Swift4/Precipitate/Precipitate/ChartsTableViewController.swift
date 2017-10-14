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
        var chartModels: [ChartModel] = []
    }
    
    var model: Model = .init() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.reuseIdentifier)
        
        tableView.rowHeight = tableView.bounds.size.width / 2
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.chartModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chartCell = tableView.dequeueReusableCell(withIdentifier: ChartCell.reuseIdentifier, for: indexPath) as! ChartCell
        
        chartCell.model.chartModel = model.chartModels[indexPath.row]
        
        return chartCell
    }
}

