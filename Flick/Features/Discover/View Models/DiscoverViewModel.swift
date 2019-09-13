//
//  DiscoverViewModel.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

enum DiscoverViewModelSection: Int, CaseIterable {
    case movies = 0
    case tvShows = 1
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .tvShows:
            return "TV Shows"
        }
    }
}

protocol DiscoverViewModel: BaseViewModel {
    var moviesViewModel: [DiscoverMovieViewModel] { get }
    var tvShowsViewModel: [DiscoverTVShowViewModel] { get }
    var numberOfSections: Int { get }
    
    var updateMoviesUISection: (() -> Void)? { get set }
    var updateTVShowsUISection: (() -> Void)? { get set }
    
    func numberOfElements(in sectionIndex: Int) -> Int
    
    func startFetchingMovies()
    func startFetchingTVShows()
}

protocol DiscoverMovieViewModel {
    var section: DiscoverViewModelSection { get }
    var movie: TMDbDiscoverMovie { get }
}

protocol DiscoverTVShowViewModel {
    var section: DiscoverViewModelSection { get }
    var tvShow: TMDbDiscoverTVShow { get }
}

final class DefaultDiscoverMovieViewModel: DiscoverMovieViewModel {
    let section: DiscoverViewModelSection = .movies
    
    let movie: TMDbDiscoverMovie
    
    
    init(with data: TMDbDiscoverMovie) {
        movie = data
    }
}

final class DefaultDiscoverTVShowViewModel: DiscoverTVShowViewModel {
    let section: DiscoverViewModelSection = .tvShows

    let tvShow: TMDbDiscoverTVShow
    
    init(with data: TMDbDiscoverTVShow) {
        tvShow = data
    }
}

final class DefaultDiscoverViewModel: DiscoverViewModel {
    typealias Services = TMDbDiscoverService
    let apiService: Services
    
    private(set) var moviesViewModel: [DiscoverMovieViewModel] = [] {
        didSet {
            updateMoviesUISection?()
        }
    }
    
    private(set) var tvShowsViewModel: [DiscoverTVShowViewModel] = [] {
        didSet {
            updateTVShowsUISection?()
        }
    }
    
    var updateMoviesUISection: (() -> Void)?
    var updateTVShowsUISection: (() -> Void)?
    
    var numberOfSections: Int { DiscoverViewModelSection.allCases.count }
    
    init(with services: TMDbDiscoverService) {
        self.apiService = services
        startFetchingMovies()
        startFetchingTVShows()
    }
    
    func numberOfElements(in sectionIndex: Int) -> Int {
        precondition(DiscoverViewModelSection.allCases.map({ $0.rawValue }).contains(sectionIndex), "Invalid section")
        let section = DiscoverViewModelSection(rawValue: sectionIndex)!
        
        switch section {
        case .movies:
            return moviesViewModel.count
        case .tvShows:
            return tvShowsViewModel.count
        }
    }
    
    func startFetchingMovies() {
        apiService.movies(queue: nil) { [weak self] (result) in
            switch result {
            case let .success(movies):
                self?.moviesViewModel = movies.map({ DefaultDiscoverMovieViewModel(with: $0) })
                
            case let .failure(error):
                #if DEBUG
                debugPrint(error)
                #endif
            }
        }
    }
    
    func startFetchingTVShows() {
        apiService.tvShows(queue: nil) { [weak self] (result) in
            switch result {
            case let .success(tvShows):
                self?.tvShowsViewModel = tvShows.map({ DefaultDiscoverTVShowViewModel(with: $0) })
                
            case let .failure(error):
                #if DEBUG
                debugPrint(error)
                #endif
            }
        }
    }
}
