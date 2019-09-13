//
//  DiscoverViewController.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Kingfisher
import UIKit

class DiscoverViewController: BaseViewController<DiscoverView, DiscoverViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
