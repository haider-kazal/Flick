//
//  CoordinatorFactory.swift
//  Flick
//
//  Created by Haider Kazal on 6/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    var tabBarCoordinator: (configurator: Coordinator, toPresent: Presentable) { get }
    
    func discoverCoordinator(embedIn navigationController: UINavigationController) -> Coordinator
    //func searchCoordinator(embedIn navigationController: UINavigationController) -> Coordinator
}

final class DefaultCoordinatorFactory: CoordinatorFactory {
    var tabBarCoordinator: (configurator: Coordinator, toPresent: Presentable) {
        let homeTabBarController = HomeTabBarController()
        let homeCoordinator = HomeCoordinator(coordinatorFactory: DefaultCoordinatorFactory())
        return (homeCoordinator, homeTabBarController)
    }
    
    func discoverCoordinator(embedIn navigationController: UINavigationController) -> Coordinator {
        let factory = DefaultDiscoverCoordinatorFactory()
        let discoverRouter = DefaultAppRouter(rootNavigationController: navigationController)
        
        let coordinator = DiscoverCoordinator(factory: factory, appRouter: discoverRouter)
        return coordinator
    }
    
    /*func searchCoordinator(embedIn navigationController: UINavigationController) -> Coordinator {
        #warning("Not yet implemented!")
        fatalError("Not yet implemented!")
    }*/
}
