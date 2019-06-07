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
import SwiftUI

class ChartsTableViewController: UITableViewController {
    
    struct Model {
        var chartCellModels: [ChartCellModel] = []
    }
    
    var model: Model = .init() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(pushSettingsViewController))
        
        tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.reuseIdentifier)
        
        tableView.rowHeight = (tableView.bounds.size.width / 2) + 20
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.chartCellModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chartCell = tableView.dequeueReusableCell(withIdentifier: ChartCell.reuseIdentifier, for: indexPath) as! ChartCell
        
        chartCell.model = model.chartCellModels[indexPath.row]
        
        return chartCell
    }
    
    @objc func pushSettingsViewController() {
        let vc = UIHostingController(rootView: SettingsView())
        navigationController?.pushViewController(vc, animated: true)
    }
}

