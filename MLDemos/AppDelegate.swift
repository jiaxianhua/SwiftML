//
//  AppDelegate.swift
//  MLDemos
//
//  Created by iosdevlog on 2019/4/6.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.blue,
             NSAttributedString.Key.font: UIFont(name: "Papyrus", size: 48) ??
                UIFont.systemFont(ofSize: 48)]
        
        return true
    }

}

