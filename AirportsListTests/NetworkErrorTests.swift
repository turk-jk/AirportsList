//
//  NetworkErrorTests.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import XCTest
@testable import AirportsList

class NetworkErrorTests: XCTestCase {

    func testNetworkErrorcases() {
        XCTAssertEqual(NetworkError.noData, NetworkError.noData)
        XCTAssertEqual(NetworkError.badData, NetworkError.badData)
        XCTAssertEqual(NetworkError.badURL, NetworkError.badURL)
        XCTAssertEqual(NetworkError.unhandledCode("404"), NetworkError.unhandledCode("404"))
        
        XCTAssertNotEqual(NetworkError.noData, NetworkError.badData)
    }

}
