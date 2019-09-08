//
//  AppCoordinator.swift
//  Flick
//
//  Created by Haider Kazal on 28/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let router: AppRouter
    private let coordinatorFactory: CoordinatorFactory
    
    lazy var childCoordinators: [Coordinator] = []
    
    private weak var window: UIWindow?
    
    init(with window: UIWindow) {
        self.window = window
        self.router = DefaultAppRouter(rootNavigationController: UINavigationController())
        self.coordinatorFactory = DefaultCoordinatorFactory()
    }
    
    func startWith(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        addDefaultDependency()
        start()
    }
    
    func startsWith(userActivity: NSUserActivity) {
        addDefaultDependency()
        start()
    }
    
    func start() {
        childCoordinators.forEach({ $0.start() })
        window?.makeKeyAndVisible()
    }
    
    private func addDefaultDependency() {
        let tabBarCoordinator = coordinatorFactory.tabBarCoordinator
        addAsChild(coordinator: tabBarCoordinator.configurator)
        router.changeRootTo(viewController: tabBarCoordinator.toPresent, withAnimation: true, hidingNavigationBar: false)
    }
}
