//
//  HomeTabBarAction.swift
//  Flick
//
//  Created by Haider Kazal on 7/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol HomeTabBarAction {
    var onDiscoverSelected: ((UINavigationController) -> Void)? { get set }
    var onSearchSelected: ((UINavigationController) -> Void)? { get set }
}
