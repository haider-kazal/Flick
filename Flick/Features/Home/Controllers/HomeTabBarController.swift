//
//  HomeTabBarController.swift
//  Flick
//
//  Created by Haider Kazal on 7/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class HomeTabBarController: BaseTabBarController, HomeTabBarAction {
    var onDiscoverSelected: ((UINavigationController) -> Void)?
    var onSearchSelected: ((UINavigationController) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [ UINavigationController(), UINavigationController() ]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let navigationController = viewControllers?[selectedIndex] as? UINavigationController else { return }
        
        switch selectedIndex {
        case 0:
            onDiscoverSelected?(navigationController)
        case 1:
            onSearchSelected?(navigationController)
        default:
            return
        }
    }
}
