//
//  AppDelegate.swift
//  Style Playground
//
//  Created by shadowsheep on 29/04/2020.
//  Copyright © 2020 shadowsheep. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // https://stackoverflow.com/questions/57467003/xcode-11-opt-out-of-uiscenedelegate-swiftui-on-ios-13
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        StyleManager.styleMe(theme: StyleManager.getTheme())
        
        return true
    }
}

