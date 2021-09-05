//
//  NetworkClient.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import Foundation

// MARK: - DataTask

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}

// MARK: - URLSession

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class NetworkClient {

    private var session: URLSessionProtocol

    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchAirports(url: URL, completion: @escaping  (_ Airports: [Airport]?, _ errorMessage: String?) -> Void) {

        let dataTask = session.dataTask(with: url) { (data, response, error) in

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return
            }

            guard let data = data else {
                completion(nil, "No Data")
                return
            }

            switch statusCode {
            case 200:
                if let airports = try? JSONDecoder().decode([Airport].self, from: data){
                    completion(airports, nil)
                }else{
                    completion(nil, "Bad data")                    
                }
            case 404:
                completion(nil, "Bad Url")
            default:
                completion(nil, "statusCode: \(statusCode)")
            }
        }

        dataTask.resume()
    }
}
