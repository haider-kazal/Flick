//
//  TMDbMovieDetails.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbMovieDetails: Codable {
    let isAdult: Bool?
    let backdropURL: URL
    //let belongs_to_collection : Belongs_to_collection?
    let budget: Int
    let genres: [TMDbGenre]
    let homepage: URL?
    let id: Int
    let imdbID: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterURL: URL
    let productionCompanies: [TMDbProductionCompany]
    //let production_countries : [Production_countries]?
    let releaseDate: Date
    let revenue: Int
    let runtime: Int?
    //let spoken_languages : [Spoken_languages]?
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case isAdult = "adult"
        case backdropURL = "backdrop_path"
        //case belongs_to_collection = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterURL = "poster_path"
        case productionCompanies = "production_companies"
        //case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        //case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isAdult = try container.decode(Bool.self, forKey: .isAdult)
        let backdropPath = try container.decode(String.self, forKey: .backdropURL)
        backdropURL = URL(string: "\(Constants.TMDbConstants.backdropImageBaseURLString)\(backdropPath)")!
        //belongs_to_collection = try values.decode(Belongs_to_collection.self, forKey: .belongs_to_collection)
        budget = try container.decode(Int.self, forKey: .budget)
        genres = try container.decode([TMDbGenre].self, forKey: .genres)
        homepage = try container.decodeIfPresent(URL.self, forKey: .homepage)
        id = try container.decode(Int.self, forKey: .id)
        imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        originalTitle = try container.decode(String.self, forKey: .originalTitle)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .posterURL)
        posterURL = URL(string: "\(Constants.TMDbConstants.posterImageBaseURLString)\(posterPath)")!
        productionCompanies = try container.decode([TMDbProductionCompany].self, forKey: .productionCompanies)
        //productionCountries = try container.decode([Production_countries].self, forKey: .productionCountries)
        releaseDate = try container.decode(Date.self, forKey: .releaseDate)
        revenue = try container.decode(Int.self, forKey: .revenue)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        //spoken_languages = try container.decode([Spoken_languages].self, forKey: .spoken_languages)
        status = try container.decode(String.self, forKey: .status)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        title = try container.decode(String.self, forKey: .title)
        video = try container.decode(Bool.self, forKey: .video)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}
