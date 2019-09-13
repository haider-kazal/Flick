//
//  TVShowDetailsViewModel.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

enum TVShowDetailsSection: Int, CaseIterable {
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

protocol TVShowDetailsViewModel: BaseViewModel {
    var briefDetails: TMDbDiscoverTVShow { get }
    var details: TMDbTVShowDetails? { get }
    var casts: [TMDbCast]? { get }
    
    var numberOfSections: Int { get }
    
    var apiService: Services { get }
    
    var updateHeader: (() -> Void)? { get set }
    var updateCreditsSection: (() -> Void)? { get set }
    var updateDetailsSection: (() -> Void)? { get set }
    
    func numberOfElements(in index: Int) -> Int
    func startFetching()
}

final class DefaultTVShowDetailsViewModel: TVShowDetailsViewModel {
    typealias Services = TMDbTVShowService
    let apiService: Services
    
    let briefDetails: TMDbDiscoverTVShow
    
    private(set) var details: TMDbTVShowDetails? {
        didSet {
            updateHeader?()
            updateDetailsSection?()
        }
    }
    
    private(set) var casts: [TMDbCast]? {
        didSet {
            updateCreditsSection?()
        }
    }
    
    var numberOfSections: Int { return MovieDetailsSection.allCases.count }
    
    var updateHeader: (() -> Void)?
    var updateCreditsSection: (() -> Void)?
    var updateDetailsSection: (() -> Void)?
    
    init(with services: Services) {
        preconditionFailure("Do not use this method")
    }
    
    init(with services: Services, for tvShow: TMDbDiscoverTVShow) {
        apiService = services
        briefDetails = tvShow
        
        startFetching()
    }
    
    func numberOfElements(in sectionIndex: Int) -> Int {
        precondition(TVShowDetailsSection(rawValue: sectionIndex) != nil, "Invalid section")
        let section = TVShowDetailsSection(rawValue: sectionIndex)!
        
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

