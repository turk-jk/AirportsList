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

        mockSession = createMockSession(fromJsonFile: "badData", andStatusCode: 200, andError: nil)
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

        mockSession = createMockSession(fromJsonFile: "successResult", andStatusCode: 401, andError: nil)
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

        mockSession = createMockSession(fromJsonFile: "successResult", andStatusCode: 404, andError: nil)
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

        mockSession = createMockSession(fromJsonFile: "NoData", andStatusCode: 500, andError: nil)
        sut = NetworkClient(withSession: mockSession)

        sut.fetchAirports(url: URL(string: "TestUrl")!) { (results) in
            guard case let .failure(error) = results else {
                XCTFail("case is not failure")
                return
            }
            XCTAssertEqual(error, NetworkError.noData)
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
    
    func test_loadJson_NoData() {
        let data = loadJson(file: "NoData")
        XCTAssertNil(data)
    }
    
    func test_loadJson_withData() {
        let data = loadJson(file: "successResult")
        XCTAssertNotNil(data)
    }

    private func createMockSession(fromJsonFile file: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {

        let data = loadJson(file: file)
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }
}
