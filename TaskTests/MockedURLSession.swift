//
//  MockedURLSession.swift
//  TaskTests
//
//  Created by Hemalatha K on 22/04/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation
import UIKit
@testable import Task

class MockURLSession: NetworksessionProtocol {
    var cachedURL: URL?
    var mockedResponsedata: Data?

    var baseURL: URL {
        return URL(string: "http://localhost")!
    }
    var urlSession: URLSession {
        return URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
    }

   // var type
    func enqueue<T>(networkRequest: T, completion: @escaping (Result<T.ResponseType, Error>) -> Void) where T : NetworkRequest {

        // Just using mock data without making original network request

        let data = mockedResponsedata
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let _ = try? networkRequest.makeURLRequest(with: self.baseURL) else {
            return
        }

        do {
            let response = try networkRequest.makeResponse(with: data, urlresponse: nil, error: nil)
            completion(.success(response))
        } catch {
            print(error)
            completion(.failure(error))
        }
    }
}
