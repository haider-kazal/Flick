//
//  DiscoverCoordinatorFactory.swift
//  Flick
//
//  Created by Haider Kazal on 11/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol DiscoverCoordinatorFactory {
    var listViewController: DiscoverViewController { get }
    
    func detailViewController(for movie: TMDbDiscoverMovie) -> UIViewController
    func detailViewController(for tvShow: TMDbDiscoverTVShow) -> UIViewController
}

final class DefaultDiscoverCoordinatorFactory: DiscoverCoordinatorFactory {
    var listViewController: DiscoverViewController {
        let viewModel = DefaultDiscoverViewModel(with: DefaultTMDbDiscoverService())
        let view = DiscoverView(with: viewModel)
        let viewController = DiscoverViewController(with: view, and: viewModel)
        return viewController
    }
    
    func detailViewController(for movie: TMDbDiscoverMovie) -> UIViewController {
        let viewModel = DefaultMovieDetailsViewModel(with: DefaultTMDbMovieService(), for: movie)
        let view = MovieDetailsView(with: viewModel)
        let viewController = MovieDetailsViewController(with: view, and: viewModel)
        return viewController
    }
    
    func detailViewController(for tvShow: TMDbDiscoverTVShow) -> UIViewController {
        let viewModel = DefaultTVShowDetailsViewModel(with: DefaultTMDbTVShowService(), for: tvShow)
        let view = TVShowDetailsView(with: viewModel)
        let viewController = TVShowDetailsViewController(with: view, and: viewModel)
        return viewController
    }
}
