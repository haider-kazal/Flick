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
    
    /*
     func makeAuthCoordinatorBox(router: Router) -> Coordinator & AuthCoordinatorOutput
     
     func makeOnboardingCoordinator(router: Router) -> Coordinator & OnboardingCoordinatorOutput
     
     func makeItemCoordinator(navController: UINavigationController?) -> Coordinator
     func makeItemCoordinator() -> Coordinator
     
     func makeSettingsCoordinator() -> Coordinator
     func makeSettingsCoordinator(navController: UINavigationController?) -> Coordinator
     
     func makeItemCreationCoordinatorBox() ->
       (configurator: Coordinator & ItemCreateCoordinatorOutput,
       toPresent: Presentable?)
     
     func makeItemCreationCoordinatorBox(navController: UINavigationController?) ->
       (configurator: Coordinator & ItemCreateCoordinatorOutput,
       toPresent: Presentable?)
     */
}

final class DefaultCoordinatorFactory: CoordinatorFactory {
    var tabBarCoordinator: (configurator: Coordinator, toPresent: Presentable) {
        let homeTabBarController = HomeTabBarController()
        let homeCoordinator = HomeCoordinator(with: homeTabBarController, coordinatorFactory: DefaultCoordinatorFactory())
        return (homeCoordinator, homeTabBarController)
    }
    
    func discoverCoordinator(embedIn navigationController: UINavigationController) -> Coordinator {
        preconditionFailure("Not yet implemented")
    }
}
