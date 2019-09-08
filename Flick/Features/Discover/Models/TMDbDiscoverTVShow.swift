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
    let genreIDS: [Int]
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
        case genreIDS = "genre_ids"
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
}
