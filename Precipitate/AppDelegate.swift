//
//  AppDelegate.swift
//  Precipitate
//
//  Created by Mark Murray on 11/25/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

// lat 40.705313  lng -74.013959

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let apiClient = ForecastAPIClient()
        
        apiClient.getForecastForLatitude(40.705313, longitude: -74.013959) { (json) -> Void in
            print("AppDelegate: \(json)")
        }
        
        // perfect answer
        // apimanager: does a return AND a completion block
        // return -> immediately shows any cached data, optional return type
        //  --> call completionBlock twice? instead
        // completionblock -> new update with the current API response
        // caveats:
        // save the timestamp
        // check the json -> how old are you, or nil
        // if need to make internet request, do it immediately
        // parallelize things when possible
        
        // first implementation
        // always hit the internet, and always cache it
        // read from the cache, no error handling
        
        // second implementation
        // always parse things in
        // both the return and the completionBlock
        // no error handling
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

