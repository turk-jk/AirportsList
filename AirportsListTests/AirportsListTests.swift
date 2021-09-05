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

        mockSession = createMockSession(fromJsonFile: "successResult", andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (airports, errorMessage) in

            XCTAssertNotNil(airports)
            XCTAssertNil(errorMessage)

            XCTAssertEqual(airports!.count , 2)

            let airport = airports!.first!
            XCTAssertEqual(airport.airportName , "Anaa")
        }
    }
    
    func test_NetworkClient_badData() {

        mockSession = createMockSession(fromJsonFile: "badData", andStatusCode: 200, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (airports, errorMessage) in

            XCTAssertNotNil(errorMessage)
            XCTAssertNil(airports)
            XCTAssertEqual(errorMessage , "Bad data")
        }
    }
    
    func test_NetworkClient_AnotherStatusCode() {

        mockSession = createMockSession(fromJsonFile: "successResult", andStatusCode: 401, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (airports, errorMessage) in

            XCTAssertNotNil(errorMessage)
            XCTAssertNil(airports)
            XCTAssertEqual(errorMessage , "statusCode: 401")
        }
    }

    func test_NetworkClient_404Result() {

        mockSession = createMockSession(fromJsonFile: "successResult", andStatusCode: 404, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (airports, errorMessage) in

            XCTAssertNotNil(errorMessage)
            XCTAssertNil(airports)
            XCTAssertEqual(errorMessage , "Bad Url")
        }
    }

    func test_NetworkClient_NoData() {

        mockSession = createMockSession(fromJsonFile: "NoData", andStatusCode: 500, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (airports, errorMessage) in

            XCTAssertNotNil(errorMessage)
            XCTAssertNil(airports)
            XCTAssertEqual(errorMessage, "No Data")
        }
    }

    private func loadJson(file: String) -> Data? {

        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }

    private func createMockSession(fromJsonFile file: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {

        let data = loadJson(file: file)
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
