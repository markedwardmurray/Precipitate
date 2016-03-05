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
        
        /* Units option objects */
        let us = ForecastUnits(option: ForecastUnitsOption.US)
        let si = ForecastUnits(option: ForecastUnitsOption.SI)
        let uk2 = ForecastUnits(option: ForecastUnitsOption.UK2)
        let ca = ForecastUnits(option: ForecastUnitsOption.CA)
        
        /* Language option objects */
        let ar010 = ForecastLanguage(option: ForecastLanguageOption.Arabic)
        let bs020 = ForecastLanguage(option: ForecastLanguageOption.Bosnian)
        let cs030 = ForecastLanguage(option: ForecastLanguageOption.Czech)
        let de040 = ForecastLanguage(option: ForecastLanguageOption.German)
        let el050 = ForecastLanguage(option: ForecastLanguageOption.Greek)
        let en060 = ForecastLanguage(option: ForecastLanguageOption.English)
        let es070 = ForecastLanguage(option: ForecastLanguageOption.Spanish)
        let fr080 = ForecastLanguage(option: ForecastLanguageOption.French)
        let hr090 = ForecastLanguage(option: ForecastLanguageOption.Croatian)
        let hu100 = ForecastLanguage(option: ForecastLanguageOption.Hungarian)
        let it110 = ForecastLanguage(option: ForecastLanguageOption.Italian)
        let is120 = ForecastLanguage(option: ForecastLanguageOption.Icelandic)
        let kw130 = ForecastLanguage(option: ForecastLanguageOption.Cornish)
        let nb140 = ForecastLanguage(option: ForecastLanguageOption.Norwegian)
        let nl150 = ForecastLanguage(option: ForecastLanguageOption.Dutch)
        let pl160 = ForecastLanguage(option: ForecastLanguageOption.Polish)
        let pt170 = ForecastLanguage(option: ForecastLanguageOption.Portuguese)
        let ru180 = ForecastLanguage(option: ForecastLanguageOption.Russian)
        let sk190 = ForecastLanguage(option: ForecastLanguageOption.Slovak)
        let sr200 = ForecastLanguage(option: ForecastLanguageOption.Serbian)
        let sv210 = ForecastLanguage(option: ForecastLanguageOption.Swedish)
        let tet220 = ForecastLanguage(option: ForecastLanguageOption.Tetum)
        let tr230 = ForecastLanguage(option: ForecastLanguageOption.Turkish)
        let uk240 = ForecastLanguage(option: ForecastLanguageOption.Ukrainian)
        let pig250 = ForecastLanguage(option: ForecastLanguageOption.PigLatin)
        let zh260 = ForecastLanguage(option: ForecastLanguageOption.Chinese)
        let zhtw270 = ForecastLanguage(option: ForecastLanguageOption.ChineseTW)
        
        /* Top Down settings */
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
                    [   Option(title: ar010.settingsDescription, optionId: ar010.option.rawValue),
                        Option(title: bs020.settingsDescription, optionId: bs020.option.rawValue),
                        Option(title: cs030.settingsDescription, optionId: cs030.option.rawValue),
                        Option(title: de040.settingsDescription, optionId: de040.option.rawValue),
                        Option(title: el050.settingsDescription, optionId: el050.option.rawValue),
                        Option(title: en060.settingsDescription, optionId: en060.option.rawValue),
                        Option(title: es070.settingsDescription, optionId: es070.option.rawValue),
                        Option(title: fr080.settingsDescription, optionId: fr080.option.rawValue),
                        Option(title: hr090.settingsDescription, optionId: hr090.option.rawValue),
                        Option(title: hu100.settingsDescription, optionId: hu100.option.rawValue),
                        Option(title: it110.settingsDescription, optionId: it110.option.rawValue),
                        Option(title: is120.settingsDescription, optionId: is120.option.rawValue),
                        Option(title: kw130.settingsDescription, optionId: kw130.option.rawValue),
                        Option(title: nb140.settingsDescription, optionId: nb140.option.rawValue),
                        Option(title: nl150.settingsDescription, optionId: nl150.option.rawValue),
                        Option(title: pl160.settingsDescription, optionId: pl160.option.rawValue),
                        Option(title: pt170.settingsDescription, optionId: pt170.option.rawValue),
                        Option(title: ru180.settingsDescription, optionId: ru180.option.rawValue),
                        Option(title: sk190.settingsDescription, optionId: sk190.option.rawValue),
                        Option(title: sr200.settingsDescription, optionId: sr200.option.rawValue),
                        Option(title: sv210.settingsDescription, optionId: sv210.option.rawValue),
                        Option(title: tet220.settingsDescription, optionId: tet220.option.rawValue),
                        Option(title: tr230.settingsDescription, optionId: tr230.option.rawValue),
                        Option(title: uk240.settingsDescription, optionId: uk240.option.rawValue),
                        Option(title: pig250.settingsDescription, optionId: pig250.option.rawValue),
                        Option(title: zh260.settingsDescription, optionId: zh260.option.rawValue),
                        Option(title: zhtw270.settingsDescription, optionId: zhtw270.option.rawValue)
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
