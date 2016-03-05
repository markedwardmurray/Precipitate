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
                    [   Option(title: "\(ar010.info.flag) \(ar010.info.name) (\(ar010.option.rawValue))", optionId: 10),
                        Option(title: "\(bs020.info.flag) \(bs020.info.name) (\(bs020.option.rawValue))", optionId: 20),
                        Option(title: "\(cs030.info.flag) \(cs030.info.name) (\(cs030.option.rawValue))", optionId: 30),
                        Option(title: "\(de040.info.flag) \(de040.info.name) (\(de040.option.rawValue))", optionId: 40),
                        Option(title: "\(el050.info.flag) \(el050.info.name) (\(el050.option.rawValue))", optionId: 50),
                        Option(title: "\(en060.info.flag) \(en060.info.name) (\(en060.option.rawValue))", optionId: 60),
                        Option(title: "\(es070.info.flag) \(es070.info.name) (\(es070.option.rawValue))", optionId: 70),
                        Option(title: "\(fr080.info.flag) \(fr080.info.name) (\(fr080.option.rawValue))", optionId: 80),
                        Option(title: "\(hr090.info.flag) \(hr090.info.name) (\(hr090.option.rawValue))", optionId: 90),
                        Option(title: "\(hu100.info.flag) \(hu100.info.name) (\(hu100.option.rawValue))", optionId: 100),
                        Option(title: "\(it110.info.flag) \(it110.info.name) (\(it110.option.rawValue))", optionId: 110),
                        Option(title: "\(is120.info.flag) \(is120.info.name) (\(is120.option.rawValue))", optionId: 120),
                        Option(title: "\(kw130.info.flag) \(kw130.info.name) (\(kw130.option.rawValue))", optionId: 130),
                        Option(title: "\(nb140.info.flag) \(nb140.info.name) (\(nb140.option.rawValue))", optionId: 140),
                        Option(title: "\(nl150.info.flag) \(nl150.info.name) (\(nl150.option.rawValue))", optionId: 150),
                        Option(title: "\(pl160.info.flag) \(pl160.info.name) (\(pl160.option.rawValue))", optionId: 160),
                        Option(title: "\(pt170.info.flag) \(pt170.info.name) (\(pt170.option.rawValue))", optionId: 170),
                        Option(title: "\(ru180.info.flag) \(ru180.info.name) (\(ru180.option.rawValue))", optionId: 180),
                        Option(title: "\(sk190.info.flag) \(sk190.info.name) (\(sk190.option.rawValue))", optionId: 190),
                        Option(title: "\(sr200.info.flag) \(sr200.info.name) (\(sr200.option.rawValue))", optionId: 200),
                        Option(title: "\(sv210.info.flag) \(sv210.info.name) (\(sv210.option.rawValue))", optionId: 210),
                        Option(title: "\(tet220.info.flag) \(tet220.info.name) (\(tet220.option.rawValue))", optionId: 220),
                        Option(title: "\(tr230.info.flag) \(tr230.info.name) (\(tr230.option.rawValue))", optionId: 230),
                        Option(title: "\(uk240.info.flag) \(uk240.info.name) (\(uk240.option.rawValue))", optionId: 240),
                        Option(title: "\(pig250.info.flag) \(pig250.info.name)", optionId: 250),
                        Option(title: "\(zh260.info.flag) \(zh260.info.name) (\(zh260.option.rawValue))", optionId: 260),
                        Option(title: "\(zhtw270.info.flag) \(zhtw270.info.name) (\(zhtw270.option.rawValue))", optionId: 270)
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
