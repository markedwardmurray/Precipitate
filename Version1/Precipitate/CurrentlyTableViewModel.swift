//
//  CurrentlyTableViewModel.swift
//  Precipitate
//
//  Created by Mark Murray on 3/1/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation

struct CurrentlyTableViewCellModel {
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

class CurrentlyTableViewModel {
    var dataBlock: CurrentlyDataBlock? {
        didSet {
            if let dataBlock = dataBlock {
                self.icon = dataBlock.icon
                self.summary = dataBlock.summary
                self.generateCellModels()
            }
        }
    }
    
    private(set) var icon = String()
    private(set) var summary = String()
    private(set) var cellModels = [CurrentlyTableViewCellModel]()
    
    private func generateCellModels() {
        cellModels.removeAll()
        
//        cellModels.append(CurrentlyTableViewCellModel(title: "Temperature", subtitle: dataBlock?.temperature.string))
    }
}

