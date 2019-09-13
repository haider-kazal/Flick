//
//  SearchCoordinator.swift
//  Flick
//
//  Created by Haider Kazal on 11/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

final class SearchCoordinator: Coordinator {
    private let factory: DiscoverCoordinatorFactory
    private let appRouter: AppRouter
    
    lazy var childCoordinators: [Coordinator] = []
    
    public init(factory: DiscoverCoordinatorFactory, appRouter: AppRouter) {
        self.factory = factory
        self.appRouter = appRouter
    }
    
    func start() {
        
    }
}
