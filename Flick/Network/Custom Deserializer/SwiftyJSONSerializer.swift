//
//  SwiftyJSONDeserializer.swift
//  Flick
//
//  Created by Haider Kazal on 8/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

extension Request {
    static var dateFormatterForDecoding: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatterForDecoding)
        return jsonDecoder
    }()
    
    /// Used to serialize Alamofire's response to SwiftyJSON's JSON.
    ///
    /// - Parameters:
    ///   - options: Options to be used when creating JSON object from Data.
    ///   - response: The metadatas returned upon API request.
    ///   - data: The data returned from API request. Will be nil if API request fails.
    ///   - error: The error returned from API request. Will be nil if API request is successful.
    /// - Returns: This method will return a Result enum, containing the status of serialization. Will return success with value if JSON object creation is successful, and will return null JSON if response status is 204 or 205. And if the request fails, failure will be returned with error object.
    
    public static func serializeResponseUsingSwiftyJSON(options: JSONSerialization.ReadingOptions,
                                                   response: HTTPURLResponse?,
                                                   data: Data?,
                                                   error: Error?) -> Result<JSON> {
        
        // If error is not nil, the request has failed, and should return failure with the error information
        guard error == nil else {
            return .failure(error!)
        }
        
        // If response is nil, or the status codes are 204 or 205, the data is empty and should return empty JSON
        // HTTP status code 204 means the server has successfully fulfilled the request and that there is no additional content to send in the response payload body. (Check out https://httpstatuses.com/204)
        // HTTP status code 205 means the server has fulfilled the request and desires that the user agent reset the "document view", which caused the request to be sent, to its original state as received from the origin server. (Check out https://httpstatuses.com/205)
        
        guard let response = response,
            response.statusCode != 204 && response.statusCode != 205 else {
                return .success(JSON.null)
        }
        
        // If valid data cannot be unwrapped or the input data is of zero length, it is considered an failure.
        
        guard let validData = data,
            validData.count > 0 else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: validData, options: options)
            return .success(JSON(json))
        } catch {
            return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
        }
    }
}

extension DataRequest {
    
    /// Parses the response as SwiftyJSON's JSON object.
    ///
    /// - Parameter options: Options used while reading JSON data.
    /// - Returns: Serializer used for serializing JSON.
    
    static func parseUsingSwitfyJSON(options: JSONSerialization.ReadingOptions) -> DataResponseSerializer<JSON> {
        return DataResponseSerializer(serializeResponse: { (request, response, data, error) in
            return Request.serializeResponseUsingSwiftyJSON(options: options, response: response, data: data, error: error)
        })
    }
    
    /// This method is used for getting response as SwiftyJSON's JSON object.
    ///
    /// - Parameters:
    ///   - queue: The queue for completing completionHandler. Default value is nil.
    ///   - options: Options used while reading JSON data. Default value is .allowFragments.
    ///   - completionHandler: The closure to be executed upon parsing.
    /// - Returns: The own request.
    
    @discardableResult
    func responseSwiftyJSON(queue: DispatchQueue? = nil,
                        options: JSONSerialization.ReadingOptions = .allowFragments,
                        completionHandler: @escaping (DataResponse<JSON>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataRequest.parseUsingSwitfyJSON(options: options),
                        completionHandler: completionHandler)
    }
}
