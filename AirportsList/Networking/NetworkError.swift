//
//  NetworkError.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import Foundation

enum NetworkError: Error, Equatable {
    case noData
    case badData
    case badURL
    case unhandledCode(String)
    case other(Error)
    static public func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (noData, noData), (badData, badData), (badURL, badURL): return true
        case (unhandledCode(let code1), unhandledCode(let code2)): return code1 == code2
        case (other(let error1), other(let error2)): return error1.localizedDescription == error2.localizedDescription
        default:
          return false
        }
    }
}
