//
//  ForecastLanguage.swift
//  Precipitate
//
//  Created by Mark Murray on 3/4/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ForecastLanguageOption: Int {
    case None       = 0
    case Arabic     = 10
    case Bosnian    = 20
    case Czech      = 30
    case German     = 40
    case Greek      = 50
    case English    = 60
    case Spanish    = 70
    case French     = 80
    case Croatian   = 90
    case Hungarian  = 100
    case Italian    = 110
    case Icelandic  = 120
    case Cornish    = 130
    case Norwegian  = 140
    case Dutch      = 150
    case Polish     = 160
    case Portuguese = 170
    case Russian    = 180
    case Slovak     = 190
    case Serbian    = 200
    case Swedish    = 210
    case Tetum      = 220
    case Turkish    = 230
    case Ukrainian  = 240
    case PigLatin   = 250
    case Chinese    = 260
    case ChineseTW  = 270
}

enum ForecastLanguageKey: String {
    case None       = ""
    case Arabic     = "ar"
    case Bosnian    = "bs"
    case Czech      = "cs"
    case German     = "de"
    case Greek      = "el"
    case English    = "en"
    case Spanish    = "es"
    case French     = "fr"
    case Croatian   = "hr"
    case Hungarian  = "hu"
    case Italian    = "it"
    case Icelandic  = "is"
    case Cornish    = "kw"
    case Norwegian  = "nb" // (Norwegian Bokmål),
    case Dutch      = "nl"
    case Polish     = "pl"
    case Portuguese = "pt"
    case Russian    = "ru"
    case Slovak     = "sk"
    case Serbian    = "sr"
    case Swedish    = "sv"
    case Tetum      = "tet"
    case Turkish    = "tr"
    case Ukrainian  = "uk"
    case PigLatin   = "x-pig-latin" // (Igpay Atinlay),
    case Chinese    = "zh" // (simplified Chinese), or zh-tw
    case ChineseTW  = "zh-tw"
}

struct ForecastLanguage {
    
    static func keyFromJSON(json: JSON) -> ForecastLanguageKey {
        if let lang = json["flags"]["language"].string {
            if let key = ForecastLanguageKey(rawValue: lang) {
                return key
            }
        }
        return ForecastLanguageKey.None
    }
    
    static func languageOptionForKey(key: ForecastLanguageKey?) -> ForecastLanguageOption {
        if let key = key {
            switch key {
            case ForecastLanguageKey.None:
                return ForecastLanguageOption.None
            case ForecastLanguageKey.Arabic:
                return ForecastLanguageOption.Arabic
            case ForecastLanguageKey.Bosnian:
                return ForecastLanguageOption.Bosnian
            case ForecastLanguageKey.Czech:
                return ForecastLanguageOption.Czech
            case ForecastLanguageKey.German:
                return ForecastLanguageOption.German
                
            case ForecastLanguageKey.Greek:
                return ForecastLanguageOption.Greek
            case ForecastLanguageKey.English:
                return ForecastLanguageOption.English
            case ForecastLanguageKey.Spanish:
                return ForecastLanguageOption.Spanish
            case ForecastLanguageKey.French:
                return ForecastLanguageOption.French
            case ForecastLanguageKey.Croatian:
                return ForecastLanguageOption.Croatian
                
            case ForecastLanguageKey.Hungarian:
                return ForecastLanguageOption.Hungarian
            case ForecastLanguageKey.Italian:
                return ForecastLanguageOption.Italian
            case ForecastLanguageKey.Icelandic:
                return ForecastLanguageOption.Icelandic
            case ForecastLanguageKey.Cornish:
                return ForecastLanguageOption.Cornish
            case ForecastLanguageKey.Norwegian:
                return ForecastLanguageOption.Norwegian
                
            case ForecastLanguageKey.Dutch:
                return ForecastLanguageOption.Dutch
            case ForecastLanguageKey.Polish:
                return ForecastLanguageOption.Polish
            case ForecastLanguageKey.Portuguese:
                return ForecastLanguageOption.Portuguese
            case ForecastLanguageKey.Russian:
                return ForecastLanguageOption.Russian
            case ForecastLanguageKey.Slovak:
                return ForecastLanguageOption.Slovak
                
            case ForecastLanguageKey.Serbian:
                return ForecastLanguageOption.Serbian
            case ForecastLanguageKey.Swedish:
                return ForecastLanguageOption.Swedish
            case ForecastLanguageKey.Tetum:
                return ForecastLanguageOption.Tetum
            case ForecastLanguageKey.Turkish:
                return ForecastLanguageOption.Turkish
            case ForecastLanguageKey.Ukrainian:
                return ForecastLanguageOption.Ukrainian
            case ForecastLanguageKey.PigLatin:
                return ForecastLanguageOption.PigLatin
                
            case ForecastLanguageKey.Chinese:
                return ForecastLanguageOption.Chinese
            case ForecastLanguageKey.ChineseTW:
                return ForecastLanguageOption.ChineseTW
//            default:
//                return ForecastLanguageOption.None
            }
        } else {
            return ForecastLanguageOption.None
        }
    }
    
    static func languageKeyForOption(option: ForecastLanguageOption?) -> ForecastLanguageKey {
        if let option = option {
            switch option {
            case ForecastLanguageOption.None:
                return ForecastLanguageKey.None
            case ForecastLanguageOption.Arabic:
                return ForecastLanguageKey.Arabic
            case ForecastLanguageOption.Bosnian:
                return ForecastLanguageKey.Bosnian
            case ForecastLanguageOption.Czech:
                return ForecastLanguageKey.Czech
            case ForecastLanguageOption.German:
                return ForecastLanguageKey.German
                
            case ForecastLanguageOption.Greek:
                return ForecastLanguageKey.Greek
            case ForecastLanguageOption.English:
                return ForecastLanguageKey.English
            case ForecastLanguageOption.Spanish:
                return ForecastLanguageKey.Spanish
            case ForecastLanguageOption.French:
                return ForecastLanguageKey.French
            case ForecastLanguageOption.Croatian:
                return ForecastLanguageKey.Croatian
                
            case ForecastLanguageOption.Hungarian:
                return ForecastLanguageKey.Hungarian
            case ForecastLanguageOption.Italian:
                return ForecastLanguageKey.Italian
            case ForecastLanguageOption.Icelandic:
                return ForecastLanguageKey.Icelandic
            case ForecastLanguageOption.Cornish:
                return ForecastLanguageKey.Cornish
            case ForecastLanguageOption.Norwegian:
                return ForecastLanguageKey.Norwegian
                
            case ForecastLanguageOption.Dutch:
                return ForecastLanguageKey.Dutch
            case ForecastLanguageOption.Polish:
                return ForecastLanguageKey.Polish
            case ForecastLanguageOption.Portuguese:
                return ForecastLanguageKey.Portuguese
            case ForecastLanguageOption.Russian:
                return ForecastLanguageKey.Russian
            case ForecastLanguageOption.Slovak:
                return ForecastLanguageKey.Slovak
                
            case ForecastLanguageOption.Serbian:
                return ForecastLanguageKey.Serbian
            case ForecastLanguageOption.Swedish:
                return ForecastLanguageKey.Swedish
            case ForecastLanguageOption.Tetum:
                return ForecastLanguageKey.Tetum
            case ForecastLanguageOption.Turkish:
                return ForecastLanguageKey.Turkish
            case ForecastLanguageOption.Ukrainian:
                return ForecastLanguageKey.Ukrainian
            case ForecastLanguageOption.PigLatin:
                return ForecastLanguageKey.PigLatin
                
            case ForecastLanguageOption.Chinese:
                return ForecastLanguageKey.Chinese
            case ForecastLanguageOption.ChineseTW:
                return ForecastLanguageKey.ChineseTW
                //            default:
                //                return ForecastLanguageOption.None
            }
        } else {
            return ForecastLanguageKey.None
        }
    }
    
    let option: ForecastLanguageOption
    let key: ForecastLanguageKey
    
    init() {
        self.option = ForecastLanguageOption.English
        self.key = ForecastLanguageKey.English
    }
    
    init(option: ForecastLanguageOption) {
        self.option = option
        self.key = ForecastLanguage.languageKeyForOption(option)
    }
    
    init(key: ForecastLanguageKey) {
        self.key = key
        self.option = ForecastLanguage.languageOptionForKey(key)
    }
    
    struct Info {
        let name: String, flag: String
    }
    
    var info: Info {
        switch option {
        case .None:
            return Info(name: "", flag: "")
        case .Arabic:
            return Info(name: "Arabic", flag: "🇪🇬")
        case .Bosnian:
            return Info(name: "Bosnian", flag: "🇧🇦")
        case .Czech:
            return Info(name: "Czech", flag: "🇨🇿")
        case .German:
            return Info(name: "German", flag: "🇩🇪")
        case .Greek:
            return Info(name: "Greek", flag: "🇬🇷")
        case .English:
            return Info(name: "English", flag: "🇬🇧")
        case .Spanish:
            return Info(name: "Spanish", flag: "🇪🇸")
        case .French:
            return Info(name: "French", flag: "🇫🇷")
        case .Croatian:
            return Info(name: "Croatian", flag: "🇭🇷")
        case .Hungarian:
            return Info(name: "Hungarian", flag: "🇭🇺")
        case .Italian:
            return Info(name: "Italian", flag: "🇮🇹")
        case .Icelandic:
            return Info(name: "Icelandic", flag: "🇮🇸")
        case .Cornish:
            return Info(name: "Cornish", flag: "🇬🇧")
        case .Norwegian:
            return Info(name: "Norwegian", flag: "🇳🇴")
        case .Dutch:
            return Info(name: "Dutch", flag: "🇳🇱")
        case .Polish:
            return Info(name: "Polish", flag: "🇵🇱")
        case .Portuguese:
            return Info(name: "Portuguese", flag: "🇵🇹")
        case .Russian:
            return Info(name: "Russian", flag: "🇷🇺")
        case .Slovak:
            return Info(name: "Slovak", flag: "🇸🇰")
        case .Serbian:
            return Info(name: "Serbian", flag: "🇷🇸")
        case .Swedish:
            return Info(name: "Swedish", flag: "🇸🇪")
        case .Tetum:
            return Info(name: "Tetum", flag: "🇹🇱")
        case .Turkish:
            return Info(name: "Turkish", flag: "🇹🇷")
        case .Ukrainian:
            return Info(name: "Ukrainian", flag: "🇺🇦")
        case .PigLatin:
            return Info(name: "Pig Latin", flag: "🐷")
        case .Chinese:
            return Info(name: "Chinese", flag: "🇨🇳")
        case .ChineseTW:
            return Info(name: "Chinese-TW", flag: "🇨🇳")
        }
    }
    
    var settingsDescription: String {
        if (self.key == ForecastLanguageKey.PigLatin) {
            return "\(self.info.flag) \(self.info.name)"
        }
        return "\(self.info.flag) \(self.info.name) (\(self.key.rawValue))"
    }
}

