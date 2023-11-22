//
//  CompanyTaskTests.swift
//  CompanyTaskTests
//
//  Created by Apple on 22/11/23.
//

import XCTest
@testable import CompanyTask

final class CompanyTaskTests: XCTestCase {

    func testNetworkSuccess() {
        let networkExpectation = expectation(description: "Network Success")

        let requestData = """
        {
            "appKey": "GMMS",
            "tokenId": "ASD45FG67HJ89KL",
            "userName": "singhkhusbl",
            "projectid": "E.0010402.1"
        }
        """.data(using: .utf8)!
        Network.shared.makePostRequest(requestData: requestData) { data, isSuccess, message in
            XCTAssertTrue(isSuccess)
            XCTAssertNil(message)
            XCTAssertNotNil(data)
            networkExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testNetworkFailure() {
        let networkExpectation = expectation(description: "Network Failure")

        let invalidRequestData = "InvalidData".data(using: .utf8)!
        Network.shared.makePostRequest(requestData: invalidRequestData) { data, isSuccess, message in
            XCTAssertFalse(isSuccess)
            XCTAssertNotNil(message)
            XCTAssertNil(data)
            networkExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // MARK: - ViewModel Tests

    func testViewModelFetchSuccess() {
        let viewModel = DashboardViewModel()

        let viewModelExpectation = expectation(description: "ViewModel Fetch Success")

        viewModel.fetchEmployeeData(userName: "testUser") { success, error in
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssertNotNil(viewModel.employeeData)
            viewModelExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testViewModelFetchFailure() {
        let viewModel = DashboardViewModel()

        let viewModelExpectation = expectation(description: "ViewModel Fetch Failure")

        // Use an invalid user name to simulate a failure
        viewModel.fetchEmployeeData(userName: "invalidUser") { success, error in
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            XCTAssertNil(viewModel.employeeData)
            viewModelExpectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testIsConnectedToNetwork() {
        XCTAssertTrue(Network.shared.isConnectedToNetwork())
    }


}
