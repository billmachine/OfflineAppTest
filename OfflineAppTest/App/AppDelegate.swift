//
//  AppDelegate.swift
//  OfflineAppTest
//
//  Created by Ahmad Billi Afandi on 22/09/20.
//  Copyright © 2020 nostratech. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var rootViewController: UIViewController = {
        let controller = UIViewController()
        return controller
    }()
    
    lazy var appDIContainer: AppDIContainer = {
        return AppDIContainer(navigationController: rootViewController)
    }()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
        
        self.appDIContainer.instantiateMainModule().start(with: .go)
        
        return true
    }

}
