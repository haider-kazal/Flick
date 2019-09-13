//
//  TMDbDiscoverMovie.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbDiscoverMovie: Codable {
    let averageVote: Float
    let backdropURL: URL
    let genreIDs: [Int]
    let id: Int
    let isAdult: Bool
    let isVideo: Bool
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterURL: URL
    let releaseDate: Date
    let title: String
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case averageVote = "vote_average"
        case backdropURL = "backdrop_path"
        case genreIDs = "genre_ids"
        case id = "id"
        case isAdult = "adult"
        case isVideo = "video"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterURL = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteCount = "vote_count"
    }
    
    init(averageVote: Float,
         backdropURL: URL,
         genreIDs: [Int],
         id: Int,
         isAdult: Bool,
         isVideo: Bool,
         originalLanguage: String,
         originalTitle: String,
         overview: String,
         popularity: Float,
         posterURL: URL,
         releaseDate: Date,
         title: String,
         voteCount: Int
    ) {
        self.averageVote = averageVote
        self.backdropURL = backdropURL
        self.genreIDs = genreIDs
        self.id = id
        self.isAdult = isAdult
        self.isVideo = isVideo
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterURL = posterURL
        self.releaseDate = releaseDate
        self.title = title
        self.voteCount = voteCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let averageVote = try container.decode(Float.self, forKey: .averageVote)
        let backdropPath = try container.decode(String.self, forKey: .backdropURL)
        let backdropURL = URL(string: "\(Constants.TMDbConstants.backdropImageBaseURLString)\(backdropPath)")!
        let genreIDs = try container.decode([Int].self, forKey: .genreIDs)
        let id = try container.decode(Int.self, forKey: .id)
        let isAdult = try container.decode(Bool.self, forKey: .isAdult)
        let isVideo = try container.decode(Bool.self, forKey: .isVideo)
        let originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        let originalTitle = try container.decode(String.self, forKey: .originalTitle)
        let overview = try container.decode(String.self, forKey: .overview)
        let popularity = try container.decode(Float.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .posterURL)
        let posterURL = URL(string: "\(Constants.TMDbConstants.posterImageBaseURLString)\(posterPath)")!
        let releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        let title = try container.decode(String.self, forKey: .title)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        
        self.init(averageVote: averageVote,
            backdropURL: backdropURL,
            genreIDs: genreIDs,
            id: id,
            isAdult: isAdult,
            isVideo: isVideo,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterURL: posterURL,
            releaseDate: releaseDate,
            title: title,
            voteCount: voteCount
        )
    }
}
