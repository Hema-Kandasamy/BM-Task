//
//  ContentRequestResource.swift
//  Task
//
//  Created by Hemalatha K on 22/04/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation


// Resources for Ntwork Request
struct ContentRequestResource: NetworkEndpoint {
    typealias ResponseType = Content

    var urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }
     var relativeURLString: String {
        return urlString
    }
}

// Response Model for above request
struct Content: Codable {
    let responseCode: String

    enum CondingKeys: String, CodingKey {
        case responseCode = "response_code"
    }
}
