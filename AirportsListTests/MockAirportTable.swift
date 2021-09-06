//
//  MockAirportTable.swift
//  AirportsListTests
//
//  Created by Yacob Kazal on 6/9/21.
//

import Foundation
@testable import AirportsList

class MockAirportTable:AirportTableDelegate{
    var didReload_count = 0
    var didShowLoading_count = 0
    var errorTitle: String?
    var errormessage: String?
    func reload() {
        didReload_count += 1
    }
    
    func showLoading() {
        didShowLoading_count += 1
    }
    
    func showError(title: String, message: String) {
        errorTitle = title
        errormessage = message
    }
    func reset() {
        didReload_count = 0
        didShowLoading_count = 0
        errorTitle = nil
        errormessage = nil
    }
}
