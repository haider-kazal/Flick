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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.updateCollectionViewFlowLayout(with: view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        rootView.updateCollectionViewFlowLayout(with: size)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        rootView.updateCollectionViewFlowLayout(with: view.bounds.size)
    }
}
