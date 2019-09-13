//
//  TMDbSearchRouter.swift
//  Flick
//
//  Created by Haider Kazal on 11/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation

enum TMDbSearchRouter: TMDbBaseRouter {
    case movies(forKeyword: String)
    case tvShows(forKeyword: String)

    var commonPathExtension: String { "/3/search" }
    
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
        switch self {
        case let .movies(keyword),
             let .tvShows(keyword):
            return ["query": keyword]
        }
    }
    
    var body: Parameters? { nil }
    
    var headers: HTTPHeaders? { nil }
    
    var bodyEncoder: ParameterEncoding? { URLEncoding.default }
}

