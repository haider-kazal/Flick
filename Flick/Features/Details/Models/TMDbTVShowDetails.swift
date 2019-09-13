//
//  TMDbTVShowDetails.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbTVShowDetails: Codable {
    let backdropURL: URL
    //let createdBy : [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [TMDbGenre]?
    let homepage : String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    //let lastEpisodeToAir : LastEpisodeToAir?
    let name: String?
    //let networks : [Network]?
    //let nextEpisodeToAir : AnyObject?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let overview: String
    let popularity: Float?
    let posterURL: URL
    let productionCompanies: [TMDbProductionCompany]
    //let seasons : [Season]?
    //let status : String?
    //let type : String?
    let voteAverage : Float?
    let voteCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropURL = "backdrop_path"
        //case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case inProduction = "in_production"
        case languages = "languages"
        case lastAirDate = "last_air_date"
        //case lastEpisodeToAir = "last_episode_to_air"
        case name = "name"
        //case networks = "networks"
        //case nextEpisodeToAir = "next_episode_to_air"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case posterURL = "poster_path"
        case productionCompanies = "production_companies"
        //case seasons = "seasons"
        //case status = "status"
        //case type = "type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let backdropPath = try container.decode(String.self, forKey: .backdropURL)
        backdropURL = URL(string: "\(Constants.TMDbConstants.backdropImageBaseURLString)\(backdropPath)")!
        //createdBy = try container.decodeIfPresent([CreatedBy].self, forKey: .createdBy)
        episodeRunTime = try container.decodeIfPresent([Int].self, forKey: .episodeRunTime)
        firstAirDate = try container.decodeIfPresent(String.self, forKey: .firstAirDate)
        genres = try container.decodeIfPresent([TMDbGenre].self, forKey: .genres)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        inProduction = try container.decodeIfPresent(Bool.self, forKey: .inProduction)
        languages = try container.decodeIfPresent([String].self, forKey: .languages)
        lastAirDate = try container.decodeIfPresent(String.self, forKey: .lastAirDate)
        //lastEpisodeToAir = LastEpisodeToAir(from: decoder)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        //networks = try container.decodeIfPresent([Network].self, forKey: .networks)
        //nextEpisodeToAir = try container.decodeIfPresent(AnyObject.self, forKey: .nextEpisodeToAir)
        numberOfEpisodes = try container.decodeIfPresent(Int.self, forKey: .numberOfEpisodes)
        numberOfSeasons = try container.decodeIfPresent(Int.self, forKey: .numberOfSeasons)
        originCountry = try container.decodeIfPresent([String].self, forKey: .originCountry)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .posterURL)
        posterURL = URL(string: "\(Constants.TMDbConstants.posterImageBaseURLString)\(posterPath)")!
        productionCompanies = try container.decode([TMDbProductionCompany].self, forKey: .productionCompanies)
        //seasons = try container.decodeIfPresent([Season].self, forKey: .seasons)
        //status = try container.decodeIfPresent(String.self, forKey: .status)
        //type = try container.decodeIfPresent(String.self, forKey: .type)
        voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }
}
