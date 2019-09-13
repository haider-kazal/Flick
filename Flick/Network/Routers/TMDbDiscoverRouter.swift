//
//  TMDbDiscoverRouter.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation

enum TMDbDiscoverRouter: TMDbBaseRouter {
    case movies
    case tvShows

    var commonPathExtension: String { "/3/discover" }
    
    var path: String {
        switch self {
        case .movies:
            return "/movie"
        case .tvShows:
            return "/tv"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queries: [String: String]? {
        return nil
    }
    
    var body: Parameters? { nil }
    
    var headers: HTTPHeaders? { nil }
    
    var bodyEncoder: ParameterEncoding? { URLEncoding.default }
}
