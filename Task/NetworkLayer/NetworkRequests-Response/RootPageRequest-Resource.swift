//
//  RootRequestResource.swift
//  Task
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import Foundation

// Resources for Ntwork Request
struct RootRequestResource: NetworkEndpoint {

     typealias ResponseType = Root

     init() { }

     var relativeURLString: String {
        return "https://blindjunction.co.uk/testbm/iostest.php"
    }
    
    var body: Data? {
        let json: [String: String] = ["platform":"ios",
                                      "mode":"appointmentdetails",
                                      "type":"new",
                                      "company_name":"BMDEMO",
                                      "userid":"1"]
        let data = try? JSONEncoder().encode(json)
        return data
    }
    
    var method: String {
        return "POST"
    }
    
    
}

// Response Model for above request
struct Root: Codable {
    let message: String
    let orderStatus: [String]
    let customerTyoe: [String]
    let appointmentType: [AppointmentType]
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case orderStatus = "order_status"
        case customerTyoe = "customer_type"
        case appointmentType = "appointment_type_list"
    }
}

struct AppointmentType: Codable {
    let name: String
    let users: [UsersType]?
    enum CodingKeys: String, CodingKey {
        case name = "typename"
        case users = "type_users"
    }
}

struct UsersType: Codable {
    let name: String
    let id: String
    enum CodingKeys: String, CodingKey  {
        case name = "user_name"
        case id
    }
}
