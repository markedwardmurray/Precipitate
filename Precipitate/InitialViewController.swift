//
//  InitialViewController.swift
//  Precipitate
//
//  Created by Mark Murray on 12/9/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import UIKit
import INTULocationManager
import SwiftyJSON
import Charts


class InitialViewController: UIViewController {

    let lineChartDataManager = LineChartDataManager.sharedInstance
    
    var json: JSON?    

    @IBOutlet weak var pageContainer: UIView!
    
    override func viewDidLoad() {

        
        /*
        json = apiClient.retrieveCachedJSON()
        NSLog("retrieved json")
        
        if let json = json {
            lineChartDataManager.json = json
        } else {
            print("no cached json")
        }
        */
    }
    
}
