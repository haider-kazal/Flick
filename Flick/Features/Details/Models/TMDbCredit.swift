//
//  TMDbCredit.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

struct TMDbCredit: Codable {
    let cast: [TMDbCast]
    //let crew : [Crew]?
    let id : Int
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        //case crew = "crew"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cast = try container.decode([TMDbCast].self, forKey: .cast)
        //crew = try values.decodeIfPresent([Crew].self, forKey: .crew)
        id = try container.decode(Int.self, forKey: .id)
    }
    
}
