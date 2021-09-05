//
//  Airport.swift
//  AirportsList
//
//  Created by Yacob Kazal on 6/9/21.
//

import Foundation

struct Airport: Codable {
    var airportCode: String
    var internationalAirport: Bool
    var regionalAirport: Bool
    var onlineIndicator: Bool
    var eticketableAirport: Bool
    var airportName: String
    var location: location
    var city: city
    var country: country
    var region: region

    struct location: Codable {
        var aboveSeaLevel: Int?
        var latitude: Double
        var latitudeRadius: Double
        var longitude: Double
        var longitudeRadius: Double
        var latitudeDirection: String?
        var longitudeDirection: String?
    }
    struct city: Codable {
        var cityCode: String
        var cityName: String?
        var timeZoneName: String
    }
    struct country: Codable {
        var countryCode: String
        var countryName: String
    }
    struct region: Codable {
        var regionCode: String
        var regionName: String
    }
}
