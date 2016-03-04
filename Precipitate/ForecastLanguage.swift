//
//  ForecastLanguage.swift
//  Precipitate
//
//  Created by Mark Murray on 3/4/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyJSON

/* enum ForecastLanguageKey: Int {
case None       = 0
case Arabic     = 1
case Bosnian    = 2
case Czech      = 3
case German     = 4
case Greek      = 5
case English    = 6
case Spanish    = 7
case French     = 8
case Croatian   = 9
case Hungarian  = 10
case Italian    = 11
case Icelandic  = 12
case Cornish    = 13
case Norwegian  = 14 // (Norwegian Bokmål),
case Dutch      = 15
case Polish     = 16
case Portuguese = 17
case Russian    = 18
case Slovak     = 19
case Serbian    = 20
case Swedish    = 21
case Tetum      = 22
case Turkish    = 23
case Ukrainian  = 24
case PigLatin   = 25 // (Igpay Atinlay),
case Chinese    = 26
case ChineseTW  = 27
} */

enum ForecastLanguageOption: String {
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
    static func languageOptionForKey(key: Int?) -> ForecastLanguageOption {
        if let key = key {
            switch key {
            case 0:
                return ForecastLanguageOption.None
            case 1:
                return ForecastLanguageOption.Arabic
            case 2:
                return ForecastLanguageOption.Bosnian
            case 3:
                return ForecastLanguageOption.Czech
            case 4:
                return ForecastLanguageOption.German
                
            case 5:
                return ForecastLanguageOption.Greek
            case 6:
                return ForecastLanguageOption.English
            case 7:
                return ForecastLanguageOption.Spanish
            case 8:
                return ForecastLanguageOption.French
            case 9:
                return ForecastLanguageOption.Croatian
                
            case 10:
                return ForecastLanguageOption.Hungarian
            case 11:
                return ForecastLanguageOption.Italian
            case 12:
                return ForecastLanguageOption.Icelandic
            case 13:
                return ForecastLanguageOption.Cornish
            case 14:
                return ForecastLanguageOption.Norwegian
                
            case 15:
                return ForecastLanguageOption.Dutch
            case 16:
                return ForecastLanguageOption.Polish
            case 17:
                return ForecastLanguageOption.Portuguese
            case 18:
                return ForecastLanguageOption.Russian
            case 19:
                return ForecastLanguageOption.Slovak
                
            case 20:
                return ForecastLanguageOption.Serbian
            case 21:
                return ForecastLanguageOption.Swedish
            case 22:
                return ForecastLanguageOption.Tetum
            case 23:
                return ForecastLanguageOption.Turkish
            case 24:
                return ForecastLanguageOption.Ukrainian
            case 25:
                return ForecastLanguageOption.PigLatin
                
            case 26:
                return ForecastLanguageOption.Chinese
            case 27:
                return ForecastLanguageOption.ChineseTW
            default:
                return ForecastLanguageOption.None
            }
        } else {
            return ForecastLanguageOption.None
        }
    }
    
    let option: ForecastLanguageOption
    
    init() {
        self.option = ForecastLanguageOption.English
    }
    
    init(option: ForecastLanguageOption) {
        self.option = option
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
    
    static func optionFromJSON(json: JSON) -> ForecastLanguageOption {
        if let lang = json["flags"]["language"].string {
            if let option = ForecastLanguageOption(rawValue: lang) {
                return option
            }
        }
        return ForecastLanguageOption.None
    }
}

