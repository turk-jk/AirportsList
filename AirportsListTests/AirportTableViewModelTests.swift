//
//  AirportTableViewModelTests.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import XCTest
@testable import AirportsList

class AirportTableViewModelTests: XCTestCase {
    private var viewModel: AirportTableViewModel!
    private var mockSession: MockURLSession!
    private var mockAirportView: MockAirportTable!
    override func setUp() {
        mockAirportView = MockAirportTable()
    }
    
    override func tearDown() {
        viewModel = nil
        mockSession = nil
        super.tearDown()
    }

    func test_success_didTryFetchAirpots() {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "successResult", andStatusCode: 200, andError: nil)
        viewModel = AirportTableViewModel(withSession: mockSession)
        viewModel.delegate = mockAirportView
        viewModel.viewDidAppear()
        XCTAssertTrue(viewModel.didTryFetchAirpots)
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 0.5 seconds")], timeout: 0.5)
        XCTAssertEqual(viewModel.numberOfAirports(), 2)
        XCTAssertEqual(viewModel.airport(forRowAt: 0).airportName, "Anaa")
        XCTAssertEqual(mockAirportView.didReload_count, 1)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 1)
        XCTAssertNil(mockAirportView.errorTitle)
        XCTAssertNil(mockAirportView.errormessage)
    }
    
    func test_badData_didTryFetchAirpots() {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "badData", andStatusCode: 200, andError: nil)
        viewModel = AirportTableViewModel(withSession: mockSession)
        viewModel.delegate = mockAirportView
        viewModel.viewDidAppear()
        XCTAssertTrue(viewModel.didTryFetchAirpots)
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 0.5 seconds")], timeout: 0.5)
        XCTAssertEqual(viewModel.numberOfAirports(), 0)
        XCTAssertEqual(mockAirportView.didReload_count, 0)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 1)
        XCTAssertEqual(mockAirportView.errorTitle, "Something Went Wrong!")
        XCTAssertEqual(mockAirportView.errormessage, "Please try again a little later")
    }
    
    func test_unhandledCode_didTryFetchAirpots() {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "successResult", andStatusCode: 401, andError: nil)
        viewModel = AirportTableViewModel(withSession: mockSession)
        viewModel.delegate = mockAirportView
        viewModel.viewDidAppear()
        XCTAssertTrue(viewModel.didTryFetchAirpots)
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 0.5 seconds")], timeout: 0.5)
        XCTAssertEqual(viewModel.numberOfAirports(), 0)
        XCTAssertEqual(mockAirportView.didReload_count, 0)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 1)
        XCTAssertEqual(mockAirportView.errorTitle, "Something Went Wrong!")
        XCTAssertEqual(mockAirportView.errormessage, "statusCode: 401!\nPlease try again a little later")
    }
    
    
    func test_badURL_didTryFetchAirpots() {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "successResult", andStatusCode: 404, andError: nil)
        viewModel = AirportTableViewModel(withSession: mockSession)
        viewModel.delegate = mockAirportView
        viewModel.viewDidAppear()
        XCTAssertTrue(viewModel.didTryFetchAirpots)
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 0.5 seconds")], timeout: 0.5)
        XCTAssertEqual(viewModel.numberOfAirports(), 0)
        XCTAssertEqual(mockAirportView.didReload_count, 0)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 1)
        XCTAssertEqual(mockAirportView.errorTitle, "Something Went Wrong!")
        XCTAssertEqual(mockAirportView.errormessage, "Bad URL!\nPlease try again a little later")
    }
    
    
    func test_noData_didTryFetchAirpots() {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "NoData", andStatusCode: 500, andError: nil)
        viewModel = AirportTableViewModel(withSession: mockSession)
        viewModel.delegate = mockAirportView
        viewModel.viewDidAppear()
        XCTAssertTrue(viewModel.didTryFetchAirpots)
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 0.5 seconds")], timeout: 0.5)
        XCTAssertEqual(viewModel.numberOfAirports(), 0)
        XCTAssertEqual(mockAirportView.didReload_count, 0)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 1)
        XCTAssertEqual(mockAirportView.errorTitle, "Something Went Wrong!")
        XCTAssertEqual(mockAirportView.errormessage, "No Data!\nPlease try again a little later")
    }
    
    func test_noNetwork_didTryFetchAirpots() {
        mockSession = XCTestFunctions.createMockSession(fromJsonFile: "NoData", andStatusCode: 500, andError: nil)
        viewModel = AirportTableViewModel(withSession: mockSession)
        viewModel.delegate = mockAirportView
        viewModel.viewDidAppear()
        XCTAssertTrue(viewModel.didTryFetchAirpots)
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 0.5 seconds")], timeout: 0.5)
        XCTAssertEqual(viewModel.numberOfAirports(), 0)
        XCTAssertEqual(mockAirportView.didReload_count, 0)
        XCTAssertEqual(mockAirportView.didShowLoading_count, 1)
        XCTAssertEqual(mockAirportView.errorTitle, "Something Went Wrong!")
        XCTAssertEqual(mockAirportView.errormessage, "No Data!\nPlease try again a little later")
    }
    

}
