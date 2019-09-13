//
//  TMDbProductionCompany.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbProductionCompany: Codable {
    let id: Int
    let logoURL: URL?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoURL = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        let logoPath = try container.decodeIfPresent(String.self, forKey: .logoURL)
        logoURL = logoPath != nil ? URL(string: "\(Constants.TMDbConstants.logoImageBaseURLString)\(logoPath!)")! : nil
        name = try container.decode(String.self, forKey: .name)
        originCountry = try container.decode(String.self, forKey: .originCountry)
    }
}
