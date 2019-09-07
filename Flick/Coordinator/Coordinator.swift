//
//  Coordinator.swift
//  Flick
//
//  Created by Haider Kazal on 27/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    @discardableResult
    func addAsChild(coordinator: Coordinator) -> Bool {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return false }
        childCoordinators.append(coordinator)
        return false
    }
    
    func removeChild(coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        
        if !coordinator.childCoordinators.isEmpty {
            coordinator
                .childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeChild(coordinator: $0) })
        }
        
        childCoordinators
            .enumerated()
            .filter({ $0.element === coordinator })
            .forEach({ childCoordinators.remove(at: $0.offset) })
    }
}
