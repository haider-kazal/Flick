//
//  HomeCoordinator.swift
//  Flick
//
//  Created by Haider Kazal on 7/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
    private let coordinatorFactory: CoordinatorFactory
    
    let discoverNavigationController = UINavigationController()
    lazy var discoverAppRouter = DefaultAppRouter(rootNavigationController: discoverNavigationController)
    
    private(set) lazy var homeTabBarController: HomeTabBarController = .init()
    
    lazy var childCoordinators: [Coordinator] = []
    
    init(coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
    }
    
    func start() {
        addChildrens()
    }
    
    private func addChildrens() {
        let discoverCoordinator: DiscoverCoordinator = .init(factory: DefaultDiscoverCoordinatorFactory(), appRouter: discoverAppRouter)
        addAsChild(coordinator: discoverCoordinator)
        discoverCoordinator.start()
        homeTabBarController.viewControllers = [discoverAppRouter.rootNavigationController!]
    }
}
