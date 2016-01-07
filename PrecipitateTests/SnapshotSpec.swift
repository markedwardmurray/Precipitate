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
        
        // The ReferenceImages folder is ignored by git to keep the image files from ballooning the repository over time. Run a test with recordingSession set to 'true' to record snapshots on your local machine. Then set recordingSession to 'false' to run the test.
        let recordingSession: Bool = false
        
        let tester = self.tester()
        
        var initialVC = InitialViewController()
        
        beforeEach {
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("initialVC")
            
            initialVC = mainVC as! InitialViewController
            
            tester.tapViewWithAccessibilityLabel("OK")
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = initialVC
            
            if let savedForecastPath = NSBundle.mainBundle().pathForResource("saved-forecast", ofType: "json") {
                
                if let savedData = NSData(contentsOfFile: savedForecastPath) {
                    
                    let savedJSON = JSON.init(data: savedData, options: NSJSONReadingOptions.AllowFragments, error: nil)
                    //print(savedJSON)
                    initialVC.lineChartDataManager.json = savedJSON
                    
                    initialVC.pageViewController.setUpChildVCs()
                    initialVC.summaryViewController.setUpSubviews()
                    
                    tester.tapViewWithAccessibilityLabel("OK")
                }
            }
        }

        describe("initialVC") {
            it("correctly loads first hourly charts") {
                
                if recordingSession {
                    expect(initialVC).to( recordSnapshot() )
                } else {
                    expect(initialVC).to( haveValidSnapshot() )
                }
            }
            
            it("correctly loads last hourly charts") {
                tester.waitForViewWithAccessibilityLabel("hourlyTableView") as! UITableView
                tester.swipeViewWithAccessibilityLabel("hourlyTableView", inDirection: KIFSwipeDirection.Up)
                
                    tester.waitForTimeInterval(NSTimeInterval(1))
                
                if recordingSession {
                    expect(initialVC).to( recordSnapshot() )
                } else {
                    expect(initialVC).to( haveValidSnapshot() )
                }
            }
            
            /* cannot get KIF to swipe the page view
            
            it("correctly loads first daily charts") {
                tester.waitForViewWithAccessibilityLabel("pageVC") as! UITableView
                
                tester.swipeViewWithAccessibilityLabel("pageVC", inDirection: KIFSwipeDirection.Left)
                
                tester.waitForTimeInterval(NSTimeInterval(1))
                
                if recordingSession {
                    expect(initialVC).to( recordSnapshot() )
                } else {
                    expect(initialVC).to( haveValidSnapshot() )
                }
            }
            
            it("correctly loads last daily charts") {
                tester.waitForViewWithAccessibilityLabel("pageVC") as! UITableView
                tester.swipeViewWithAccessibilityLabel("pageVC", inDirection: KIFSwipeDirection.Left)
                
                tester.waitForViewWithAccessibilityLabel("dailyTableView")
                
                tester.swipeViewWithAccessibilityLabel("dailyTableView", inDirection: KIFSwipeDirection.Up)
                
                tester.waitForTimeInterval(NSTimeInterval(1))
                
                if recordingSession {
                    expect(initialVC).to( recordSnapshot() )
                } else {
                    expect(initialVC).to( haveValidSnapshot() )
                }
            }
            */
        }
    }
}


