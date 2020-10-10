//
//  AppDelegate.swift
//  GooglePlacesSearchController
//
//  Created by Dmitry Shmidt on 07/01/2015.
//  Copyright (c) 07/01/2015 Dmitry Shmidt. All rights reserved.
//

import UIKit
import GoogleMaps

let googleApiKey = "AIzaSyBdXLQ3YyLiRoSoeo3J9lw6pGA8KH2CZts"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // GMSPlacesClient.provideAPIKey("AIzaSyBdXLQ3YyLiRoSoeo3J9lw6pGA8KH2CZts")
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(googleApiKey)
        return true
    }

}
