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
        let backButton = UIButton(type: UIButtonType.Custom)
        backButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.sizeToFit()
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        
        loadSettingsTopDown()
    }
    
    func loadSettingsTopDown() {
        /* Top Down settings */
        settings = SwiftySettings(storage: storage, title: "Settings") {
            [Section(title: "Forecast API") {
                [OptionsButton(key: "units", title: "Units Option") {
                    [   Option(title: "US - United States", optionId: 0),
                        Option(title: "SI - International Sytem", optionId: 1),
                        Option(title: "UK - United Kingdom", optionId: 2),
                        Option(title: "CA - Canada", optionId: 3)]
                        },
                    OptionsButton(key: "lang", title: "Language") {
                        [Option(title: "English", optionId: 0)]
                    }
                ]
                }]
            }
        }
//    func loadSettingsTopDown() {
//        /* Top Down settings */
//        settings = SwiftySettings(storage: storage, title: "Settings") {
//            
//            [Section(title: "Forecast API") {
//                OptionsSection(key: "units", title: "Units Option") {
//                    [   Option(title: "US - United States", optionId: 0),
//                        Option(title: "SI - International System", optionId: 1),
//                        Option(title: "UK - United Kingdom", optionId: 2),
//                        Option(title: "CA - Canada", optionId: 3)]
//                }]
//            }]
//        }
//    }
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
