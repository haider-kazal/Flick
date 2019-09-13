//
//  TMDbDiscoverTVShow.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbDiscoverTVShow: Codable, Identifiable {
    let averageVote: Float
    let backdropURL: URL
    let firstAirDate: Date
    let genreIDs: [Int]
    let id: Int
    let name: String
    let popularity: Float
    let posterURL: URL
    let originCountries: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case averageVote = "vote_average"
        case backdropURL = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDs = "genre_ids"
        case id = "id"
        case name = "name"
        case popularity = "popularity"
        case posterURL = "poster_path"
        case originCountries = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case voteCount = "vote_count"
    }
    
    init(averageVote: Float,
         backdropURL: URL,
         firstAirDate: Date,
         genreIDs: [Int],
         id: Int,
         name: String,
         originCountries: [String],
         originalLanguage: String,
         originalName: String,
         overview: String,
         popularity: Float,
         posterURL: URL,
         voteCount: Int
    ) {
        self.averageVote = averageVote
        self.backdropURL = backdropURL
        self.firstAirDate = firstAirDate
        self.genreIDs = genreIDs
        self.id = id
        self.name = name
        self.popularity = popularity
        self.posterURL = posterURL
        self.originCountries = originCountries
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.voteCount = voteCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let averageVote = try container.decode(Float.self, forKey: .averageVote)
        let backdropPath = try container.decode(String.self, forKey: .backdropURL)
        let backdropURL = URL(string: "\(Constants.TMDbConstants.backdropImageBaseURLString)\(backdropPath)")!
        let firstAirDate = try container.decode(Date.self, forKey: .firstAirDate)
        let genreIDs = try container.decode([Int].self, forKey: .genreIDs)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let originCountries = try container.decode([String].self, forKey: .originCountries)
        let originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        let originalName = try container.decode(String.self, forKey: .originalName)
        let overview = try container.decode(String.self, forKey: .overview)
        let popularity = try container.decode(Float.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .posterURL)
        let posterURL = URL(string: "\(Constants.TMDbConstants.posterImageBaseURLString)\(posterPath)")!
        
        
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        
        self.init(averageVote: averageVote,
             backdropURL: backdropURL,
             firstAirDate: firstAirDate,
             genreIDs: genreIDs,
             id: id,
             name: name,
             originCountries: originCountries,
             originalLanguage: originalLanguage,
             originalName: originalName,
             overview: overview,
             popularity: popularity,
             posterURL: posterURL,
             voteCount: voteCount
        )
    }
}
