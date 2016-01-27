//
//  SettingsStore.swift
//  Precipitate
//
//  Created by Mark Murray on 1/27/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftySettings
import SwiftyUserDefaults

class SettingsStore: SettingsStorageType {
    
    subscript(key: String) -> Bool? {
        get {
            return Defaults[key].bool
        }
        set {
            Defaults[key] = newValue
        }
    }
    
    subscript(key: String) -> Float? {
        get {
            return Float(Defaults[key].doubleValue)
        }
        set {
            Defaults[key] = newValue
        }
    }
    
    subscript(key: String) -> Int? {
        get {
            return Defaults[key].int
        }
        set {
            Defaults[key] = newValue
        }
    }
    
    subscript(key: String) -> String? {
        get {
            return Defaults[key].string
        }
        set {
            Defaults[key] = newValue
        }
    }
    
}