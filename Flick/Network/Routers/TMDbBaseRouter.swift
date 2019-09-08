//
//  TMDbBaseRouter.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation

protocol TMDbBaseRouter: BaseRouter { }

extension TMDbBaseRouter {
    var baseURL: URL { URL(string: "https://api.themoviedb.org")! }
    
    var fullURL: URL? {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        urlComponents.path = "\(commonPathExtension)\(path)"
        
        var queryItems = queries?.map { URLQueryItem(name: $0, value: $1) }
        queryItems?.append(URLQueryItem(name: "api_key", value: Constants.TMDbConstants.apiKey))
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
}
