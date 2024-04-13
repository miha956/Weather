//
//  GeocodingCity.swift
//  Weather
//
//  Created by Миша Вашкевич on 12.04.2024.
//

import Foundation

// MARK: - Welcome
struct GeocodingLocationsModel: Decodable {
    let locations: [Location]
    
    enum CodingKeys: String, CodingKey {
            case locations = "results"
        }
}

// MARK: - Result
struct Location: Decodable {
    let id: Int
    let name: String
    let latitude, longitude: Double
    let elevation: Int
    let countryCode: String
    let admin1ID: Int
    let admin2ID: Int?
    let timezone: String
    let population: Int?
    let countryID: Int
    let country, admin1: String
    let admin2: String?
    let admin3ID: Int?
    let postcodes: [String]?
    let admin3: String?

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation
        case countryCode = "country_code"
        case admin1ID = "admin1_id"
        case admin2ID = "admin2_id"
        case timezone, population
        case countryID = "country_id"
        case country, admin1, admin2
        case admin3ID = "admin3_id"
        case postcodes, admin3
    }
}

