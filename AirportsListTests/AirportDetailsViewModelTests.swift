//
//  AirportDetailsViewModelTests.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import XCTest
@testable import AirportsList

class AirportDetailsViewModelTests: XCTestCase {
    func testAirportDetailsViewModel() {
        
        if let data = XCTestFunctions.loadJson(file: "successResult"),
           let airport = try? JSONDecoder().decode([Airport].self, from: data).first{
            let viewModel = AirportDetailsViewModel(airport: airport)
            XCTAssertEqual(viewModel.numberOfRows(), 5)

            XCTAssertEqual(viewModel.details(forRowAt: 0).0, "Airport:")
            XCTAssertEqual(viewModel.details(forRowAt: 0).1, "Anaa")
            
            XCTAssertEqual(viewModel.details(forRowAt: 1).0, "Country:")
            XCTAssertEqual(viewModel.details(forRowAt: 1).1, "French Polynesia")
            
            XCTAssertEqual(viewModel.details(forRowAt: 2).0, "timeZoneName:")
            XCTAssertEqual(viewModel.details(forRowAt: 2).1, "Pacific/Tahiti")
            
            XCTAssertEqual(viewModel.details(forRowAt: 3).0, "longitude:")
            XCTAssertEqual(viewModel.details(forRowAt: 3).1, "145.3")
            
            XCTAssertEqual(viewModel.details(forRowAt: 4).0, "latitude:")
            XCTAssertEqual(viewModel.details(forRowAt: 4).1, "17.25")
            
            XCTAssertEqual(viewModel.details(forRowAt: -1).0, "")
            XCTAssertEqual(viewModel.details(forRowAt: -1).1, "")
            
        }
    }
}
