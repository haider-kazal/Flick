//
//  AppDelegate.swift
//  Flick
//
//  Created by Haider Kazal on 27/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private(set) var rootViewController = UINavigationController()
    
    private lazy var appRouter: AppRouter = DefaultAppRouter(rootNavigationController: rootViewController)
    private(set) lazy var appCoordinator: AppCoordinator = .init(with: window, router: appRouter)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        //window.rootViewController = rootViewController
        self.window = window
        
        appCoordinator.startWith(launchOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        appCoordinator.startsWith(userActivity: userActivity)
        return true
    }
}
