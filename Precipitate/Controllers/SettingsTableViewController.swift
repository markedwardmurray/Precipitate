//
//  SettingsViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 7/3/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class SettingsTableViewController: UITableViewController, SettingsChildTableViewControllerDelegate {

    @IBOutlet var unitsLabel: UILabel!
    @IBOutlet var langLabel: UILabel!
    
    @IBOutlet var hoursLabel: UILabel!
    @IBOutlet var daysLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        self.tableView.separatorStyle = .None
        
        let unitsSetting = Defaults["units"].int!
        let unitsOption = ForecastUnitsOption(rawValue: unitsSetting)!
        let units = ForecastUnits(option: unitsOption)
        self.unitsLabel.text = "\(units.info.ticker) - \(units.info.units)"
        
        let langSetting = Defaults["lang"].int!
        let langOption = ForecastLanguageOption(rawValue: langSetting)!
        let lang = ForecastLanguage(option: langOption)
        self.langLabel.text = lang.settingsDescription
        
        let hoursSelection = Defaults["hours"].int!
        if hoursSelection == 0 {
            self.hoursLabel.text = "24-hour"
        } else if hoursSelection == 1 {
            self.hoursLabel.text = "12-hour"
        }
        
        let daysSelection = Defaults["days"].int!
        if daysSelection == 0 {
            self.daysLabel.text = "Date Digit"
        } else if daysSelection == 1 {
            self.daysLabel.text = "Weekday Letter"
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let childTVC = SettingsChildTableViewController()
        childTVC.delegate = self
        childTVC.settingKey = self.settingKeyForIndexPath(indexPath)
        childTVC.options = self.optionsForIndexPath(indexPath)
        
        var setting = Defaults[childTVC.settingKey].int!
        if (childTVC.settingKey == "lang") {
            for i in 0 ..< childTVC.options.count {
                if (childTVC.options[i].1 == setting) {
                    setting = i
                    break
                }
            }
        }
        childTVC.selectedIndex = setting
     
        self.navigationController?.pushViewController(childTVC, animated: true)
    }
    
    func settingKeyForIndexPath(indexPath: NSIndexPath) -> String {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return "units"
        case (0, 1):
            return "lang"
        case (1, 0):
            return "hours"
        case (1, 1):
            return "days"
        default:
            return ""
        }
    }
    
    func optionsForIndexPath(indexPath: NSIndexPath) -> [(String, Int)] {
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            /* Units option objects */
            let us = ForecastUnits(option: ForecastUnitsOption.US)
            let si = ForecastUnits(option: ForecastUnitsOption.SI)
            let uk2 = ForecastUnits(option: ForecastUnitsOption.UK2)
            let ca = ForecastUnits(option: ForecastUnitsOption.CA)
            
            return [
                ( "\(us.info.ticker) - \(us.info.units)", 0 ),
                ( "\(si.info.ticker) - \(si.info.units)", 1 ),
                ( "\(uk2.info.ticker) - \(uk2.info.units)", 2),
                ( "\(ca.info.ticker) - \(ca.info.units)", 3)
            ]
            
        case (0, 1):
            /* Language option objects */
            let ar010 = ForecastLanguage(option: ForecastLanguageOption.Arabic)
            let bs020 = ForecastLanguage(option: ForecastLanguageOption.Bosnian)
            let zh260 = ForecastLanguage(option: ForecastLanguageOption.Chinese)
            let zhtw270 = ForecastLanguage(option: ForecastLanguageOption.ChineseTW)
            let kw130 = ForecastLanguage(option: ForecastLanguageOption.Cornish)
            
            let hr090 = ForecastLanguage(option: ForecastLanguageOption.Croatian)
            let cs030 = ForecastLanguage(option: ForecastLanguageOption.Czech)
            let nl150 = ForecastLanguage(option: ForecastLanguageOption.Dutch)
            let en060 = ForecastLanguage(option: ForecastLanguageOption.English)
            let fr080 = ForecastLanguage(option: ForecastLanguageOption.French)
            
            let de040 = ForecastLanguage(option: ForecastLanguageOption.German)
            let el050 = ForecastLanguage(option: ForecastLanguageOption.Greek)
            let hu100 = ForecastLanguage(option: ForecastLanguageOption.Hungarian)
            let it110 = ForecastLanguage(option: ForecastLanguageOption.Italian)
            let is120 = ForecastLanguage(option: ForecastLanguageOption.Icelandic)
            
            let pig250 = ForecastLanguage(option: ForecastLanguageOption.PigLatin)
            let nb140 = ForecastLanguage(option: ForecastLanguageOption.Norwegian)
            let pl160 = ForecastLanguage(option: ForecastLanguageOption.Polish)
            let pt170 = ForecastLanguage(option: ForecastLanguageOption.Portuguese)
            let ru180 = ForecastLanguage(option: ForecastLanguageOption.Russian)
            
            let sr200 = ForecastLanguage(option: ForecastLanguageOption.Serbian)
            let sk190 = ForecastLanguage(option: ForecastLanguageOption.Slovak)
            let es070 = ForecastLanguage(option: ForecastLanguageOption.Spanish)
            let sv210 = ForecastLanguage(option: ForecastLanguageOption.Swedish)
            let tet220 = ForecastLanguage(option: ForecastLanguageOption.Tetum)
            
            let tr230 = ForecastLanguage(option: ForecastLanguageOption.Turkish)
            let uk240 = ForecastLanguage(option: ForecastLanguageOption.Ukrainian)
            
            return [
                (ar010.settingsDescription, ar010.option.rawValue),
                (bs020.settingsDescription, bs020.option.rawValue),
                (zh260.settingsDescription, zh260.option.rawValue),
                (zhtw270.settingsDescription, zhtw270.option.rawValue),
                (kw130.settingsDescription, kw130.option.rawValue),
                
                (hr090.settingsDescription, hr090.option.rawValue),
                (cs030.settingsDescription, cs030.option.rawValue),
                (nl150.settingsDescription, nl150.option.rawValue),
                (en060.settingsDescription, en060.option.rawValue),
                (fr080.settingsDescription, fr080.option.rawValue),
                
                (de040.settingsDescription, de040.option.rawValue),
                (el050.settingsDescription, el050.option.rawValue),
                (hu100.settingsDescription, hu100.option.rawValue),
                (it110.settingsDescription, it110.option.rawValue),
                (is120.settingsDescription, is120.option.rawValue),
                
                (pig250.settingsDescription, pig250.option.rawValue),
                (nb140.settingsDescription, nb140.option.rawValue),
                (pl160.settingsDescription, pl160.option.rawValue),
                (pt170.settingsDescription, pt170.option.rawValue),
                (ru180.settingsDescription, ru180.option.rawValue),
                
                (sr200.settingsDescription, sr200.option.rawValue),
                (sk190.settingsDescription, sk190.option.rawValue),
                (es070.settingsDescription, es070.option.rawValue),
                (sv210.settingsDescription, sv210.option.rawValue),
                (tet220.settingsDescription, tet220.option.rawValue),
                
                (tr230.settingsDescription, tr230.option.rawValue),
                (uk240.settingsDescription, uk240.option.rawValue)
            ]
            
        case (1, 0):
            return [
                ("24-hour", 0),
                ("12-hour", 1)
            ]
            
        case (1, 1):
            return [
                ("Date Digit", 0),
                ("Weekday Letter", 1)
            ]
            
        default:
            return []
        }
    }
    
    // MARK: - SettingsChildTableViewControllerDelegate
    
    func settingsChild(settingsChild: SettingsChildTableViewController, didSelectOption option: (String, Int)) {
        Defaults[settingsChild.settingKey] = option.1
        
        var displaySettingsDidChange = false
        
        switch settingsChild.settingKey {
        case "units":
            self.unitsLabel.text = option.0
        case "lang":
            self.langLabel.text = option.0
        case "hours":
            self.hoursLabel.text = option.0
            displaySettingsDidChange = true
        case "days":
            self.daysLabel.text = option.0
            displaySettingsDidChange = true
        default:
            break
        }
        
        if displaySettingsDidChange {
            NSNotificationCenter.defaultCenter().postNotificationName("NotificationDisplaySettingsDidChange", object: nil)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}

protocol SettingsChildTableViewControllerDelegate {
    func settingsChild(settingsChild: SettingsChildTableViewController, didSelectOption option: (String, Int))
}

class SettingsChildTableViewController: UITableViewController {
    
    var delegate: SettingsChildTableViewControllerDelegate?
    
    var settingKey: String = ""
    var options: [(String, Int)] = Array()
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .None
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = self.options[indexPath.row].0
        
        if indexPath.row == selectedIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.selectedIndex {
            return
        }

        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.highlighted = true
        cell?.accessoryType = .Checkmark
        
        self.delegate?.settingsChild(self, didSelectOption: self.options[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.highlighted = false
        cell?.accessoryType = .None
    }
}
