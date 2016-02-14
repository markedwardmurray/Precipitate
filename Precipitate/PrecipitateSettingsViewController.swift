//
//  PrecipitateSettingsViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 1/26/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import UIKit
import SwiftySettings

class PrecipitateSettingsViewController: SwiftySettingsViewController {
    var storage = SettingsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSettingsTopDown()
    }
    
    func loadSettingsTopDown() {
        /* Top Down settings */
        let us = ForecastUnits(option: ForecastUnitsOption.US)
        let si = ForecastUnits(option: ForecastUnitsOption.SI)
        let uk2 = ForecastUnits(option: ForecastUnitsOption.UK2)
        let ca = ForecastUnits(option: ForecastUnitsOption.CA)
        
        settings = SwiftySettings(storage: storage, title: "Settings") {
            [   Section(title: "Forecast API") {
                [   OptionsButton(key: "units", title: "Units") {
                    [   Option(title: "\(us.info.ticker) - \(us.info.units)", optionId: 0),
                        Option(title: "\(si.info.ticker) - \(si.info.units)", optionId: 1),
                        Option(title: "\(uk2.info.ticker) - \(uk2.info.units)", optionId: 2),
                        Option(title: "\(ca.info.ticker) - \(ca.info.units)", optionId: 3)
                        ]
                    },
                    OptionsButton(key: "lang", title: "Language") {
                    [   Option(title: "English", optionId: 0)
                        ]
                    }
                ]
            },
                Section(title: "Charts") {
                [   OptionsButton(key: "hours", title: "Hour Display") {
                    [   Option(title: "24-hour", optionId: 0),
                        Option(title: "12-hour", optionId: 1)
                        ]
                    },
                    OptionsButton(key: "days", title: "Date Display") {
                    [   Option(title: "Date Digit", optionId: 0),
                        Option(title: "Weekday Letter", optionId: 1)
                        ]
                    }
                ]
            }]
            }
        }
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
