//
//  SearchCoordinatorFactory.swift
//  Flick
//
//  Created by Haider Kazal on 11/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

protocol SearchCoordinatorFactory {
    var searchViewController: SearchViewController { get }
}

//final class DefaultSearchCoordinatorFactory: SearchCoordinatorFactory {
//    var searchViewController: SearchViewController {
//        let viewModel = DefaultSearchViewModel
//    }
//}
