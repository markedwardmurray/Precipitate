//
//  SnapshotSpec.swift
//  Precipitate
//
//  Created by Mark Murray on 12/15/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import KIF
import Quick
import Nimble
import Nimble_Snapshots
import SwiftyJSON

@testable import Precipitate

class SnapshotSpec: QuickSpec {
    override func spec() {
        
        let recordingSession: Bool = false
        
        let tester = self.tester()
        
        var initialVC = InitialViewController()
        
        beforeEach {
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("initialVC")
            
            initialVC = mainVC as! InitialViewController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = initialVC
            
            if let savedForecastPath = NSBundle.mainBundle().pathForResource("saved-forecast", ofType: "json") {
                
                if let savedData = NSData(contentsOfFile: savedForecastPath) {
                    
                    let savedJSON = JSON.init(data: savedData, options: NSJSONReadingOptions.AllowFragments, error: nil)
                    //print(savedJSON)
                    initialVC.lineChartDataManager.json = savedJSON
                    
                    initialVC.pageViewController.setUpChildVCs()
                    initialVC.summaryViewController.setUpSubviews()
                }
            }
        }

        describe("in some context") {
            it("has valid snapshot") {
                tester.waitForTimeInterval(NSTimeInterval(3))
                
                if recordingSession {
                    expect(initialVC).to( recordSnapshot() )
                } else {
                    expect(initialVC).to( haveValidSnapshot() )
                }
            }
        }
    }
}


