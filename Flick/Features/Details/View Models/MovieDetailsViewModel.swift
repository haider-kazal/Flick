//
//  DetailsViewModel.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

enum MovieDetailsSection: Int, CaseIterable {
    case overview = 0
    case cast = 1
    
    var title: String {
        switch self {
        case .overview:
            return "Overview"
        case .cast:
            return "Cast"
        }
    }
}

protocol MovieDetailsViewModel: BaseViewModel {
    var briefDetails: TMDbDiscoverMovie { get }
    var details: TMDbMovieDetails? { get }
    var casts: [TMDbCast]? { get }
    
    var numberOfSections: Int { get }
    
    var apiService: Services { get }
    
    var updateTaglineInUI: ((_ tagline: String) -> Void)? { get set }
    
    func numberOfElements(in index: Int) -> Int
    func startFetching()
}

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    typealias Services = TMDbMovieService
    let apiService: Services
    
    let briefDetails: TMDbDiscoverMovie
    
    private(set) var details: TMDbMovieDetails? {
        didSet {
            updateHeader?()
            updateDetailsSection?()
            guard let tagline = details?.tagline else { return }
            updateTaglineInUI?(tagline)
        }
    }
    
    private(set) var casts: [TMDbCast]? {
        didSet {
            updateCreditsSection?()
        }
    }
    
    var numberOfSections: Int { return MovieDetailsSection.allCases.count }
    
    var updateTaglineInUI: ((_ tagline: String) -> Void)?
    var updateHeader: (() -> Void)?
    var updateCreditsSection: (() -> Void)?
    var updateDetailsSection: (() -> Void)?
    
    init(with services: TMDbMovieService) {
        preconditionFailure("Do not use this method")
    }
    
    init(with services: TMDbMovieService, for movie: TMDbDiscoverMovie) {
        apiService = services
        briefDetails = movie
        
        startFetching()
    }
    
    func numberOfElements(in sectionIndex: Int) -> Int {
        precondition(MovieDetailsSection(rawValue: sectionIndex) != nil, "Invalid section")
        let section = MovieDetailsSection(rawValue: sectionIndex)!
        
        switch section {
        case .overview:
            return 1
            
        case .cast:
            guard let count = casts?.count else { return 0 }
            return count
        }
    }
    
    func startFetching() {
        apiService.details(forMovieID: briefDetails.id, queue: nil) { [weak self] (result) in
            switch result {
            case let .success(details):
                self?.details = details
                
            case let .failure(error):
                #if DEBUG
                debugPrint(error)
                #endif
            }
        }
        
        apiService.credits(forMovieID: briefDetails.id, queue: nil) { [weak self] (result) in
            switch result {
            case let .success(credits):
                self?.casts = credits.cast.sorted(by: { $0.order < $1.order })
                
            case let .failure(error):
                #if DEBUG
                debugPrint(error)
                #endif
            }
        }
    }
}
