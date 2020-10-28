//
//  AppDelegate.swift
//  reddittest
//
//  Created by Realitian on 2020/10/28.
//  Copyright © 2020 Billy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let homeViewController = HomeViewController(nibName: HomeViewController.className, bundle: nil)
        let navigatgionController = UINavigationController(rootViewController: homeViewController)
        window?.rootViewController = navigatgionController
        
        navigatgionController.navigationBar.barTintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        navigatgionController.navigationBar.tintColor = UIColor.white
        navigatgionController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        return true
    }
    
    
}
