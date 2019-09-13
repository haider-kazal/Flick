//
//  ConnectionManager.swift
//  Flick
//
//  Created by Haider Kazal on 11/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation

class ConnectionManager {
    private static let sessionManager: SessionManager = .init()
    
    class func request(with router: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(router).validate()
    }
}
