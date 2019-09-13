//
//  TMDbCast.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbCast: Codable, Equatable {
    let castID: Int?
    let character: String
    let creditID: String
    let gender: Int?
    let id: Int
    let name: String
    let order: Int
    let profilePictureURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character = "character"
        case creditID = "credit_id"
        case gender = "gender"
        case id = "id"
        case name = "name"
        case order = "order"
        case profilePictureURL = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        castID = try container.decodeIfPresent(Int.self, forKey: .castID)
        character = try container.decode(String.self, forKey: .character)
        creditID = try container.decode(String.self, forKey: .creditID)
        gender = try container.decode(Int.self, forKey: .gender)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        order = try container.decode(Int.self, forKey: .order)
        let profilePicturePath = try container.decodeIfPresent(String.self, forKey: .profilePictureURL)
        profilePictureURL = profilePicturePath != nil ? URL(string: "\(Constants.TMDbConstants.castImageBaseURLString)\(profilePicturePath!)")! : nil
    }
    
}

