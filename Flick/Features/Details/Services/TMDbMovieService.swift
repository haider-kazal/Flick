//
//  TMDbMovieService.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import UIKit

enum TMDbMovieServiceError: Error {
    case networkError(error: Error)
    case decodingError(error: DecodingError)
    case unspecifiedError(error: Error)
}

protocol TMDbMovieService {
    func credits(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<TMDbCredit, TMDbMovieServiceError>) -> Void)?)
    
    func details(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<TMDbMovieDetails, TMDbMovieServiceError>) -> Void)?)
    
    //func images(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverMovie], TMDbMovieServiceError>) -> Void)?)
    
    //func videos(forMovieID id: Int, queue: DispatchQueue?, onCompletion completionHandler: ((Swift.Result<[TMDbDiscoverMovie], TMDbMovieServiceError>) -> Void)?)
}

final class DefaultTMDbMovieService: TMDbMovieService {
    func credits(forMovieID id: Int,
                 queue: DispatchQueue?,
                 onCompletion completionHandler: ((Swift.Result<TMDbCredit, TMDbMovieServiceError>) -> Void)?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ConnectionManager
            .request(with: TMDbMovieRouter.credits(forID: id))
            .validate()
            .responseData { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
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
                 onCompletion completionHandler: ((Swift.Result<TMDbMovieDetails, TMDbMovieServiceError>) -> Void)?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ConnectionManager
            .request(with: TMDbMovieRouter.details(forID: id))
            .validate()
            .responseData { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch response.result {
                case let .success(data):
                    let dateFormatter: DateFormatter = .init()
                    dateFormatter.dateFormat = "YYYY-MM-dd"
                    
                    let jsonDecoder: JSONDecoder = .init()
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    do {
                        let details = try jsonDecoder.decode(TMDbMovieDetails.self, from: data)
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
