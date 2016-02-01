//
//  SettingsViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 1/26/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import UIKit
import SwiftySettings

class SettingsViewController: SwiftySettingsViewController {
    var storage = SettingsStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController? .setNavigationBarHidden(false, animated:true)
        let doneButton = UIButton(type: UIButtonType.Custom)
        doneButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        //doneButton.sizeToFit()
        let doneButtonItem = UIBarButtonItem(customView: doneButton)
        //self.navigationController?.navigationItem.rightBarButtonItem = doneButtonItem
        //self.navigationItem.rightBarButtonItem = doneButtonItem
        
        self.splitViewController?.navigationController?.navigationItem.rightBarButtonItem = doneButtonItem
        
        loadSettingsTopDown()
    }
    
    func loadSettingsTopDown() {
        /* Top Down settings */
        settings = SwiftySettings(storage: storage, title: "Settings") {
            [   Section(title: "Forecast API") {
                [   OptionsButton(key: "units", title: "Units Option") {
                    [   Option(title: "US — ºF, inches, miles, mph", optionId: 0),
                        Option(title: "SI — ºC, mm, Km, m/s", optionId: 1),
                        Option(title: "UK — ºC, mm, miles, mph", optionId: 2),
                        Option(title: "CA — ºC, mm, Km, kph", optionId: 3)
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
                        Option(title: "Weekday", optionId: 1)
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
