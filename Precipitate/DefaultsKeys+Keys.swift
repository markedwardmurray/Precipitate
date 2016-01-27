//
//  DefaultsKeys+Keys.swift
//  Precipitate
//
//  Created by Mark Murray on 1/27/16.
//  Copyright © 2016 markedwardmurray. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let units = DefaultsKey<Int>("units")
    static let lang = DefaultsKey<String?>("lang")
    static let launchCount = DefaultsKey<Int>("launchCount")
    static let apiCallCount = DefaultsKey<Int>("apiCallCount")
}
