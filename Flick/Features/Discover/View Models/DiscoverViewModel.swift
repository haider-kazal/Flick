//
//  DiscoverViewModel.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

protocol DiscoverViewModel: BaseViewModel {
    associatedtype MoviesViewModel: DiscoverMoviesViewModel
    associatedtype TVShowsViewModel: DiscoverTVShowsViewModel
    
    var moviesViewModel: MoviesViewModel { get }
    var tvShowsViewModel: TVShowsViewModel { get }
    var numberOfSections: Int { get }
}

protocol DiscoverMoviesViewModel: BaseViewModel {
    var movies: [TMDbDiscoverMovie] { get }
    var numberOfElements: Int { get }
    var updateMoviesUISection: (() -> Void)? { get set }
}

protocol DiscoverTVShowsViewModel: BaseViewModel {
    var tvShows: [TMDbDiscoverTVShow] { get }
    var numberOfElements: Int { get }
    var updateTVShowsUISection: (() -> Void)? { get set }
}

enum DiscoverViewModelSection: Int, CaseIterable {
    case movies = 0
    case tvShows = 1
}

final class DefaultDiscoverMoviesViewModel: DiscoverMoviesViewModel {
    typealias Services = TMDbDiscoverService
    
    private let apiService: TMDbDiscoverService
    
    private(set) var movies: [TMDbDiscoverMovie] = [] {
        didSet {
            updateMoviesUISection?()
        }
    }
    
    var numberOfElements: Int { return movies.count }
    
    var updateMoviesUISection: (() -> Void)?

    init(with services: TMDbDiscoverService) {
        apiService = services
    }
}

final class DefaultDiscoverTVShowsViewModel: DiscoverTVShowsViewModel {
    typealias Services = TMDbDiscoverService
    
    private let apiService: TMDbDiscoverService
    
    private(set) var tvShows: [TMDbDiscoverTVShow] = [] {
        didSet {
            updateTVShowsUISection?()
        }
    }
    
    var numberOfElements: Int { return tvShows.count }
    
    var updateTVShowsUISection: (() -> Void)?
    
    init(with services: TMDbDiscoverService) {
        apiService = services
    }
}

final class DefaultDiscoverViewModel: DiscoverViewModel {
    typealias MoviesViewModel = DefaultDiscoverMoviesViewModel
    typealias TVShowsViewModel = DefaultDiscoverTVShowsViewModel
    
    var moviesViewModel: DefaultDiscoverMoviesViewModel
    var tvShowsViewModel: DefaultDiscoverTVShowsViewModel
    
    typealias Services = TMDbDiscoverService
    
    var numberOfSections: Int {
        return DiscoverViewModelSection.allCases.count
    }
    
    init(with services: TMDbDiscoverService) {
        //apiService = services
        moviesViewModel = .init(with: services)
        tvShowsViewModel = .init(with: services)
    }
}
