//
//  MovieDetailsViewController.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController<MovieDetailsView, MovieDetailsViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.briefDetails.title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async { [weak self] in
            self?.rootView.tableView.tableHeaderView?.layoutIfNeeded()
            self?.rootView.tableView.tableHeaderView = self?.rootView.tableView.tableHeaderView
        }
    }
}
