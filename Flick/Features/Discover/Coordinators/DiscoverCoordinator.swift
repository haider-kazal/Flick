//
//  DiscoverCoordinator.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class DiscoverCoordinator: Coordinator {
    private let factory: DiscoverCoordinatorFactory
    private let appRouter: AppRouter
    
    private(set) lazy var rootViewController = factory.listViewController
    
    lazy var childCoordinators: [Coordinator] = []
    
    init(factory: DiscoverCoordinatorFactory, appRouter: AppRouter) {
        self.factory = factory
        self.appRouter = appRouter
    }
    
    func start() {
        showDiscoverList()
    }
    
    private func showDiscoverList() {
        appRouter.changeRootTo(viewController: rootViewController, withAnimation: false, hidingNavigationBar: false)
        rootViewController.rootView.coordinator = self
    }
    
    func showDetails(for movie: TMDbDiscoverMovie) {
        let coordinator = DetailsCoordinator(for: movie, factory: factory, appRouter: appRouter)
        coordinator.start()
    }
    
    func showDetails(for tvShow: TMDbDiscoverTVShow) {
        let coordinator = DetailsCoordinator(for: tvShow, factory: factory, appRouter: appRouter)
        coordinator.start()
    }
}
