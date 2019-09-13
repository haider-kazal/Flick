//
//  DetailsCoordinator.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class DetailsCoordinator: Coordinator {
    private let factory: DiscoverCoordinatorFactory
    private let appRouter: AppRouter
    
    private let rootViewController: Presentable
    
    lazy var childCoordinators: [Coordinator] = []
    
    init(for movie: TMDbDiscoverMovie, factory: DiscoverCoordinatorFactory, appRouter: AppRouter) {
        self.factory = factory
        self.appRouter = appRouter
        rootViewController = factory.detailViewController(for: movie)
    }
    
    init(for tvShow: TMDbDiscoverTVShow, factory: DiscoverCoordinatorFactory, appRouter: AppRouter) {
        self.factory = factory
        self.appRouter = appRouter
        rootViewController = factory.detailViewController(for: tvShow)
    }
    
    func start() {
        appRouter.push(viewController: rootViewController, withAnimation: true, hidingBottomBar: true, onCompletion: nil)
    }
}
