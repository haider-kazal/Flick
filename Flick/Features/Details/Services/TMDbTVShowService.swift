//
//  TMDbTVShowService.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import UIKit

enum TMDbTVShowServiceError: Error {
    case networkError(error: Error)
    case decodingError(error: DecodingError)
    case unspecifiedError(error: Error)
}

protocol TMDbTVShowService {
    func credits(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<TMDbCredit, TMDbTVShowServiceError>) -> Void)?)
    
    func details(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<TMDbTVShowDetails, TMDbTVShowServiceError>) -> Void)?)
    
    //func images(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverMovie], TMDbTVShowServiceError>) -> Void)?)
    
    //func videos(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverMovie], TMDbTVShowServiceError>) -> Void)?)
}

final class DefaultTMDbTVShowService: TMDbTVShowService {
    func credits(forMovieID id: Int,
                 queue: DispatchQueue?,
                 onCompletion completionHandler: ((Swift.Result<TMDbCredit, TMDbTVShowServiceError>) -> Void)?) {
        ConnectionManager
            .request(with: TMDbTVShowRouter.credits(forID: id))
            .validate()
            .responseData { (response) in
                switch response.result {
                case let .success(data):
                    let dateFormatter: DateFormatter = .init()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    
                    let jsonDecoder: JSONDecoder = .init()
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    do {
                        let details = try jsonDecoder.decode(TMDbCredit.self, from: data)
                        completionHandler?(.success(details))
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
                
        }
    }
    
    func details(forMovieID id: Int,
                 queue: DispatchQueue?,
                 onCompletion completionHandler: ((Swift.Result<TMDbTVShowDetails, TMDbTVShowServiceError>) -> Void)?) {
        ConnectionManager
            .request(with: TMDbTVShowRouter.details(forID: id))
            .validate()
            .responseData { (response) in
                switch response.result {
                case let .success(data):
                    let dateFormatter: DateFormatter = .init()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    
                    let jsonDecoder: JSONDecoder = .init()
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    do {
                        let details = try jsonDecoder.decode(TMDbTVShowDetails.self, from: data)
                        completionHandler?(.success(details))
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
                
        }
    }
}
