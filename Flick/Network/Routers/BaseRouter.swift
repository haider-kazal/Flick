//
//  BaseRouter.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation

protocol BaseRouter: URLRequestConvertible {
    var fullURL: URL? { get }
    
    var baseURL: URL { get }
    var commonPathExtension: String { get }
    var path: String { get }
    
    var method: HTTPMethod { get }
    var queries: [String: String]? { get }
    var body: Parameters? { get }
    
    var headers: HTTPHeaders? { get }
    var bodyEncoder: ParameterEncoding? { get }
}

extension BaseRouter {
    var fullURL: URL? {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        urlComponents.path = "\(commonPathExtension)\(path)"
        urlComponents.queryItems = queries?.map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let fullURL = fullURL else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30
        
        headers?.forEach({ urlRequest.addValue($0.value, forHTTPHeaderField: $0.name) })
        
        guard doesMethodHaveBody(method) else {
            return urlRequest
        }
       
        guard let encoder = bodyEncoder else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: body)
            return urlRequest
        }
       
        urlRequest = try encoder.encode(urlRequest, with: body)
        return urlRequest
    }
    
    private func doesMethodHaveBody(_ method: HTTPMethod) -> Bool {
        return (method != .get && method != .connect && method != .head && method != .options && method != .trace)
    }
}
