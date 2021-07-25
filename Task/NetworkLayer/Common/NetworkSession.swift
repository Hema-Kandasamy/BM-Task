//
//  NetworkSession.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//


import Foundation

public protocol NetworksessionProtocol {
    var baseURL: URL { get }
    var urlSession: URLSession { get }
    func enqueue<T: NetworkRequest>(networkRequest: T, completion: @escaping (Result<T.ResponseType, Error>) -> Void)
}

public extension NetworksessionProtocol {
    func enqueue<T: NetworkRequest>(networkRequest: T, completion: @escaping (Result<T.ResponseType, Error>) -> Void) {

          guard let urlRequest = try? networkRequest.makeURLRequest(with: self.baseURL) else {
              return
          }

          let task = self.urlSession.dataTask(with: urlRequest) { (data, urlresponse, error) in
              do {
                  let response = try networkRequest.makeResponse(with: data, urlresponse: urlresponse, error: error)
                  completion(.success(response))
              } catch {
                  print(error) // return failure result and propagate the error to the UI
                 completion(.failure(error))
              }
          }
          task.resume()
      }
}
class NetworkSession: NSObject, NetworksessionProtocol {

    lazy var urlSession: URLSession = {
        return URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()

    var baseURL = URL(string: "https://blindjunction.co.uk/testbm/iostest.php")!
}
extension NetworkSession: URLSessionDelegate {

}
