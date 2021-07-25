//
//  LineLevelUsageMocks.swift
//  TelenetTests
//
//  Created by Deepak Shukla on 01/04/2020.
//  Copyright © 2020 Telenet. All rights reserved.
//

import Foundation
@testable import Task

struct MockRoot {
    
    static let responseData = """
    {
        "status": "success",
        "message": "Appointment details",
        "default_order_status": "on",
        "order_status": ["Quote", "Lead", "Agent Order", "In Production", "Order", "Rework", "Payment", "Invoiced", "Completed", "deposit taken"],
        "customer_type": ["Domestic", "Contract", "Trade"],
        "source_list": ["Exhibition", "Google", "New New", "New Source", "New Test", "Permission", "Radio", "Shop", "Source Updated", "Telegraph", "Telephone", "Test 1", "Thomsons", "Van", "Web", "Word Of Mouth", "Yell.com"],
        "prioritydrop": ["High", "Medium", "Low", "Critical", "R &amp; D"],
        "appointment_type_list": [{
            "typename": "Google Events",
            "typeid": "0",
            "type_users": [{
                "id": "149",
                "user_name": "Priya"
            }, {
                "id": "150",
                "user_name": "Latha"
            }, {
                "id": "155",
                "user_name": "David"
            }]
        }, {
            "typename": "Measure",
            "typeid": "58",
            "type_users": [{
                "id": "83",
                "user_name": "Matt"
            }, {
                "id": "133",
                "user_name": "Selva"
            }]
        }]
    }
    """.data(using: .utf8)

}

struct MockContent {

    static let responseData = """
    {
        "response_code": "9e49d810-3fd1-4b5e-abc6-0952532a966b"
    }
    """.data(using: .utf8)

}

struct MockInvalidData {
    static let responseData = """
    {
        "key": "9e49d810-3fd1-4b5e-abc6-0952532a966b"
    }
    """.data(using: .utf8)
}




