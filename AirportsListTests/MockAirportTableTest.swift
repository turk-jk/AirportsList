//
//  MockAirportTableTest.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import XCTest
@testable import AirportsList

class MockAirportTableTest: XCTestCase {
    private var mockAirportView: MockAirportTable!
    override func setUp() {
        mockAirportView = MockAirportTable()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_didTryFetchAirpots() {
        mockAirportView.didReload_count = 1
        mockAirportView.didShowLoading_count = 1
        mockAirportView.errorTitle = "errorTitle test"
        mockAirportView.errormessage = "errormessage test"
        mockAirportView.reset()
        XCTAssertEqual(mockAirportView.didReload_count, 0)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 0)
        XCTAssertNil(mockAirportView.errorTitle)
        XCTAssertNil(mockAirportView.errormessage)
    }
}
