//
//  TMDbDiscoverService.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

enum TMDbDiscoverServiceError: Error {
    case networkError(error: Error)
    case decodingError(error: DecodingError)
    case unspecifiedError(error: Error)
}

protocol TMDbDiscoverService {
    func movies(queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverMovie], TMDbDiscoverServiceError>) -> Void)?)
    
    func tvShows(queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverTVShow], TMDbDiscoverServiceError>) -> Void)?)
}

final class DefaultTMDbDiscoverService: TMDbDiscoverService {
    func movies(queue: DispatchQueue? = nil, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverMovie], TMDbDiscoverServiceError>) -> Void)?) {
        ConnectionManager
            .request(with: TMDbDiscoverRouter.movies)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case let .success(payload):
                    let json = JSON(payload)
                    
                    let dateFormatter: DateFormatter = .init()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    
                    let jsonDecoder: JSONDecoder = .init()
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    do {
                        let movies = try jsonDecoder.decode([TMDbDiscoverMovie].self, from: json["results"].rawData())
                        completionHandler?(.success(movies))
                    } catch let error as DecodingError {
                        #if DEBUG
                         debugPrint(error)
                        #endif
                        completionHandler?(.failure(.decodingError(error: error)))
                    } catch {
                        completionHandler?(.failure(.unspecifiedError(error: error)))
                    }
                    
                case let .failure(error):
                    completionHandler?(.failure(.networkError(error: error)))
                }
            })
    }
    
    func tvShows(queue: DispatchQueue? = nil, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverTVShow], TMDbDiscoverServiceError>) -> Void)?) {
        ConnectionManager
            .request(with: TMDbDiscoverRouter.tvShows)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case let .success(payload):
                    let json = JSON(payload)
                    
                    let dateFormatter: DateFormatter = .init()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    
                    let jsonDecoder: JSONDecoder = .init()
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    do {
                        let tvShows = try jsonDecoder.decode([TMDbDiscoverTVShow].self, from: json["results"].rawData())
                        completionHandler?(.success(tvShows))
                    } catch let error as DecodingError {
                        #if DEBUG
                        debugPrint(error)
                        #endif
                        completionHandler?(.failure(.decodingError(error: error)))
                    } catch {
                        completionHandler?(.failure(.unspecifiedError(error: error)))
                    }
                    
                case let .failure(error):
                    completionHandler?(.failure(.networkError(error: error)))
                }
            })
    }
}
