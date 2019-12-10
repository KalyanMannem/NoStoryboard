//
//  AppDelegate.swift
//  NoStoryboard
//
//  Created by Kalyan Mannem on 10/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = ViewController()
        homeViewController.view.backgroundColor = UIColor.red
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        return true
    }

}

