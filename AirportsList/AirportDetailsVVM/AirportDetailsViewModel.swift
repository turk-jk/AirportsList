//
//  AirportDetailsViewModel.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import Foundation

class AirportDetailsViewModel {
    private let airport: Airport
    init(airport: Airport) {
        self.airport = airport
    }
    func numberOfRows() -> Int{
        return 5
    }
    func details(forRowAt: Int) -> (String,String) {
        switch forRowAt {
        case 0:
            return ("Airport:", "\(airport.airportName)")
        case 1:
            return ("Country:", airport.country.countryName)
        case 2:
            return ("timeZoneName:", airport.city.timeZoneName)
        case 3:
            return ("longitude:", "\(airport.location.longitude)")
        case 4:
            return ("latitude:", "\(airport.location.latitude)")
        default:
            return ("","")
        }
    }
}
