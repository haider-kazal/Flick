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
    
    private(set) lazy var rootViewController = UINavigationController()
    private(set) lazy var discoverAppRouter = DefaultAppRouter(rootNavigationController: rootViewController)
    
    private weak var window: UIWindow?
    
    lazy var childCoordinators: [Coordinator] = []
    
    init(with window: UIWindow?, router: AppRouter) {
        self.window = window
        self.router = router
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
        window?.tintColor = .systemGreen
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func addDefaultDependency() {
        let discoverCoordinator: DiscoverCoordinator = .init(factory: DefaultDiscoverCoordinatorFactory(), appRouter: discoverAppRouter)
        addAsChild(coordinator: discoverCoordinator)
        router.changeRootTo(viewController: discoverCoordinator.rootViewController, withAnimation: true, hidingNavigationBar: false)
    }
}
