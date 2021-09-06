//
//  AirportTableViewModel.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import UIKit

class AirportTableViewModel {
    var didTryFetchAirpots = false
    weak var delegate: AirportTableDelegate?
    private var airports: [Airport] = .init()
    private var session: URLSessionProtocol

    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func viewDidAppear() {
        if !didTryFetchAirpots{
            delegate?.showLoading()
            tryFetchAirpots()
        }

    }
    func airport(forRowAt indexPath: Int) -> Airport{
        return airports[indexPath]
    }
    
    func numberOfAirports() -> Int{
        return airports.count
    }
    
    
    func tryFetchAirpots() {
        didTryFetchAirpots = true
        fetchAirports { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let airports):
                    self.airports = airports.sorted(by: { $0.airportName < $1.airportName })
                    self.delegate?.reload()
                case .failure(let error):
                    switch error {
                    case .badData:
                        self.delegate?.showError(title: "Something Went Wrong!", message: "Please try again a little later")
                    case .other( let sessionError):
                        self.delegate?.showError(title: "Something Went Wrong!", message: sessionError.localizedDescription)
                    case .noData:
                        self.delegate?.showError(title: "Something Went Wrong!", message: "No Data!\nPlease try again a little later")
                    case .badURL:
                        self.delegate?.showError(title: "Something Went Wrong!", message: "Bad URL!\nPlease try again a little later")
                    case .unhandledCode(let errorMessage):
                        self.delegate?.showError(title: "Something Went Wrong!", message: "\(errorMessage)!\nPlease try again a little later")
                    }
                    break
                }
            }
        }
    }
    
    private func fetchAirports(completionHandler: @escaping (Result<[Airport], NetworkError>) -> Void) {
        didTryFetchAirpots = true
        let url = URL(string: "https://api.qantas.com/flight/refData/airport")!
        
        NetworkClient(withSession: session).fetchAirports(url: url, completion: completionHandler)
    }
}
