//
//  JSONParser.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation

final class JSONParser<T: Decodable> {
    // MARK: Decoding
    static func objectWithoutKey(from data: Data) throws -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
           // print(error)
            throw error
        }
    }
}
