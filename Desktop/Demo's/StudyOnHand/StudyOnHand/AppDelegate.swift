//
//  AppDelegate.swift
//  StudyOnHand
//
//  Created by Nilesh's MAC on 10/7/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

enum Environment: String {
    case Staging = "staging"
    case Production = "production"
    case Local = "local"
    case QA = "qa"
    
    var baseURL: String {
        switch self {
        case .Staging: return "https://staging-api.myservice.com"
        case .Production: return "https://api.myservice.com"
        case .Local: return "https://local-api.myservice.com"
        case .QA: return "https://QA-api.myservice.com"
        }
    }
    
    var token: String {
        switch self {
        case .Staging: return "lktopir156dsq16sbi8"
        case .Production: return "5zdsegr16ipsbi1lktp"
        case .Local: return "5zdsefrh6ips6i1lxyz"
        case .QA: return "qa768r99399jnnrrn"
        }
    }
}

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.contains("Staging")
            {
                return Environment.Staging
            }else if configuration.contains("Local") {
                return Environment.Local
            }else if configuration.contains("QA") {
                return Environment.QA
            }
        }
        
        return Environment.Production
    }()
}


