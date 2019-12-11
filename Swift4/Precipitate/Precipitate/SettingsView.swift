//
//  SettingsViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 6/7/19.
//  Copyright © 2019 Mark Edward Murray. All rights reserved.
//

import SwiftUI
import Combine

enum HourDisplay: Int, CaseIterable {
    case _12 = 1
    case _24
    
    var display: String {
        switch self {
        case ._12: return "12-hour"
        case ._24: return "24-hour"
        }
    }
}

struct SettingsView : View {
    @State var units: DarkSky.Request.Units = .auto
    @State var language: DarkSky.Request.Language = .english
    
    @State var hourDisplay: HourDisplay = ._12
    
    var body: some View {
        Text("Settings")
//        List {
//            Section(header: Text("Dark Sky API")) {
//                Picker(selection: $units, label: Text("Units")) {
//                    ForEach(DarkSky.Request.Units.allCases.identified(by: \.self)) { unit in
//                        Text(unit.rawValue).tag(unit)
//                    }
//                }
//                Picker(selection: $language, label: Text("Language")) {
//                    ForEach(DarkSky.Request.Language.allCases.identified(by: \.self)) { lang in
//                        Text(lang.rawValue).tag(lang)
//                    }
//                }
//            }
//            Section(header: Text("Charts")) {
//                SegmentedControl(selection: $hourDisplay) {
//                    ForEach(HourDisplay.allCases.identified(by: \.self)) { hour in
//                        Text(hour.display).tag(hour)
//                    }
//                }
//            }
//        }.listStyle(.grouped)
//         .navigationBarTitle(Text("Settings"))
    }
}

#if DEBUG
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
