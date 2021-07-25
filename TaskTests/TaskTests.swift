//
//  TaskTests.swift
//  TaskTests
//
//  Created by Hemalatha K on 22/06/2021.
//  Copyright © 2021 HackerFactory. All rights reserved.
//

import XCTest
@testable import Task

class TaskTests: XCTestCase {

    let session = MockURLSession()
    var vm: HomeViewModel?
    var state: HomeViewState?
    override func setUpWithError() throws {
        vm = HomeViewModel(with: self.session)
       // let state = HomeViewState(title: "Message", customerTYype: ["Type1, Type2"], status: ["ordered", "decline"], appointments: [Appointment(name: "Event", users: [UsersType(name: "TestUser", id: "123")])])
       // self.state = state
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCount() {
        // Given
        let mockedData = MockRoot.responseData
        session.mockedResponsedata = mockedData
        let expectation = self.expectation(description: "count")
        // When
        vm?.data.bind { (response) in
            expectation.fulfill()
            guard let data = response else {
                XCTFail()
                return
            }
            self.state = data
        }
        vm?.fetchData()
        waitForExpectations(timeout: 5, handler:  nil)

        // Then
        XCTAssertNotNil(state)
        let title = state?.title
        XCTAssertTrue(title != nil)
        XCTAssert(title == "Appointment details")
        XCTAssert(state?.appointments != nil)
    }

    func testFetchInvalidData() {
        // Given
        let mockedData = MockInvalidData.responseData
        session.mockedResponsedata = mockedData
        let expectation = self.expectation(description: "invalidDataFailure")
        var errorDesc: String?
        // When
        vm?.error.bind({ (error) in
            errorDesc = error?.localizedDescription
            expectation.fulfill()
        })
        vm?.fetchData()
        waitForExpectations(timeout: 1, handler: nil)

        // Then
        XCTAssertNotNil(errorDesc)
    }

    func testEmptyData() {
        // Given
        // Not assigning mocked response
        session.mockedResponsedata = nil
        let expectation = self.expectation(description: "emptyDataFailure")
        var errorDesc: String?

        // When
        vm?.error.bind({ (error) in
            errorDesc = error?.localizedDescription
            expectation.fulfill()
        })
        vm?.fetchData()
        waitForExpectations(timeout: 1, handler: nil)

        // Then
        XCTAssertNotNil(errorDesc)
    }

    func testCorrectAPIUrl() {
        // Given
        let mockedSession = self.session

        // When
        let baseURL = URL(string:"http://localhost")!
        //Then
        XCTAssertEqual(mockedSession.baseURL, baseURL)

    }

    func testInvalidAPIurl() {
        // Given
        let mockeSession = self.session

        // When
        let baseURl = URL(string: "http://google.com")!

        // Then
        XCTAssertNotEqual(mockeSession.baseURL, baseURl)
    }

}
