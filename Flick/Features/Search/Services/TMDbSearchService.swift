//
//  TMDbSearchService.swift
//  Flick
//
//  Created by Haider Kazal on 11/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

enum TMDbSearchServiceError: Error {
    case networkError(error: Error)
    case decodingError(error: DecodingError)
    case unspecifiedError(error: Error)
}
