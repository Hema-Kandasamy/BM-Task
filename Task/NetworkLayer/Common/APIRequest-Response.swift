 //
//  APIRequest-response.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation

 // Common make request method - Based on resource provided

 extension APIRequest: NetworkRequest {
    typealias ResponseType = Resource.ResponseType

    public func makeURLRequest(with baseURL: URL) throws -> URLRequest {
        guard let url = URL(string: resource.relativeURLString, relativeTo: baseURL)?.absoluteURL else {
            throw NetworkRequestError.unableToCreateURL
        }

        var urlComponents = URLComponents(string: resource.relativeURLString)
        urlComponents?.queryItems = resource.queryItems

        var request = URLRequest(url: (urlComponents?.url) ?? url, cachePolicy: resource.cachePolicy, timeoutInterval: 60)
        request.httpMethod = resource.method
        request.httpBody = resource.body
        return request
    }


    // Common response handler
    public func makeResponse(with bodyData: Data?, urlresponse urlResponse: URLResponse?, error: Error?) throws -> Resource.ResponseType {
        guard let data = bodyData else {
            throw NetworkResponseError.unexpectedResponse
        }
        guard let result: Resource.ResponseType = try  JSONParser.objectWithoutKey(from: data) else {
            throw NetworkResponseError.unexpectedResponse
        }
        
        return result
    }

}
