//
//  AirportsListTests.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import XCTest
@testable import AirportsList

class AirportsListTests: XCTestCase {
    
    var sut: NetworkClient!
    var mockSession: MockURLSession!

    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }

    func test_NetworkClient_successResult() {

        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "successResult", andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)
        
        sut.fetchAirports(url: URL(string: "TestUrl")!) { (results) in
            guard case let .success(airports) = results else {
                XCTFail("case is not success")
                return
            }
            XCTAssertNotNil(airports)
            XCTAssertEqual(airports.count , 2)
            let airport = airports.first!
            XCTAssertEqual(airport.airportName , "Anaa")
        }
    }
    
    func test_NetworkClient_badData() {

        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "badData", andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (results) in
            guard case let .failure(error) = results else {
                XCTFail("case is not failure")
                return
            }
            XCTAssertEqual(error, NetworkError.badData)
        }
    }
    
    func test_NetworkClient_AnotherStatusCode() {

        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "successResult", andStatusCode: 401, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (results) in
            guard case let .failure(error) = results else {
                XCTFail("case is not failure")
                return
            }
            XCTAssertEqual(error, NetworkError.unhandledCode("statusCode: 401"))
        }
    }

    func test_NetworkClient_404Result() {

        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "successResult", andStatusCode: 404, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (results) in
            guard case let .failure(error) = results else {
                XCTFail("case is not failure")
                return
            }
            XCTAssertEqual(error, NetworkError.badURL)
        }
    }

    func test_NetworkClient_NoData() {

        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "NoData", andStatusCode: 500, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (results) in
            guard case let .failure(error) = results else {
                XCTFail("case is not failure")
                return
            }
            XCTAssertEqual(error, NetworkError.noData)
        }
    }

}
