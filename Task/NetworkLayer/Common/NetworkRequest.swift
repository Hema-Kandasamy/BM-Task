//
//  NetworkRequest.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation

public enum NetworkResponseError: Error {
    case unexpectedResponse
    case unspecifiedFailure
}

// MARK: - NetworkRequest additions

 public enum NetworkRequestError: Error {
     case unableToCreateURL
     case invalidParameters
 }

 public protocol NetworkEndpoint {
     associatedtype ResponseType: Codable

     var relativeURLString: String { get }
     var headers: [String: String]? { get }
     var body: Data? { get }
     var queryItems: [URLQueryItem]? { get }
     var cachePolicy: URLRequest.CachePolicy { get }
     var acceptedStatusCode: [Int] { get }
 }

 public extension NetworkEndpoint {
     var method: String {
         return "POST"
     }

     var headers: [String: String]? {
         return nil
     }

     var body: Data? {
         return nil
     }

    var queryItems: [URLQueryItem]? {
        return nil
    }

     var cachePolicy: URLRequest.CachePolicy {
         return .useProtocolCachePolicy
     }

     var acceptedStatusCode: [Int] {
         return [200]
     }

 }

 class APIRequest<Resource: NetworkEndpoint> {
    public let resource: Resource

    public init(resource: Resource) {
        self.resource = resource
    }
}

public protocol NetworkRequest {
    associatedtype ResponseType
    func makeURLRequest(with baseURL: URL) throws -> URLRequest
    func makeResponse(with bodyData: Data?, urlresponse: URLResponse?, error: Error?) throws -> ResponseType
}
