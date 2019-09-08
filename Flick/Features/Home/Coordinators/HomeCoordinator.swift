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
    
    private weak var homeTabBarController: HomeTabBarController?
    
    lazy var childCoordinators: [Coordinator] = []
    
    private lazy var discoverTabSelected: ((UINavigationController) -> Void) = { [weak self] (navigationController) in
        guard navigationController.viewControllers.isEmpty else { return }
        //Add Discover Dependency
    }
    
    private lazy var searchTabSelected: ((UINavigationController) -> Void) = { [weak self] (navigationController) in
        guard navigationController.viewControllers.isEmpty else { return }
        //Add Discover Dependency
        
    }
    
    init(with homeTabBarController: HomeTabBarController, coordinatorFactory: CoordinatorFactory) {
        self.homeTabBarController = homeTabBarController
        self.coordinatorFactory = coordinatorFactory
    }
    
    func start() {
        homeTabBarController?.onDiscoverSelected = discoverTabSelected
        homeTabBarController?.onSearchSelected = searchTabSelected
    }
}
