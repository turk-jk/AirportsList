//
//  XCTestFunctions.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import XCTest

class XCTestFunctions: XCTestCase {

    
    static func loadJson(file: String) -> Data? {

        if let jsonFilePath = Bundle(for: XCTestFunctions.self).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }
    
    func test_loadJson_NoData() {
        let data = XCTestFunctions.loadJson(file: "NoData")
        XCTAssertNil(data)
    }
    
    func test_loadJson_withData() {
        let data = XCTestFunctions.loadJson(file: "successResult")
        XCTAssertNotNil(data)
    }

    static func createMockSession(fromJsonFile file: String,
                                   andStatusCode code: Int,
                                   andError error: Error?) -> MockURLSession? {

        let data = XCTestFunctions.loadJson(file: file)
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        return MockURLSession(completionHandler: (data, response, error))
    }

}
