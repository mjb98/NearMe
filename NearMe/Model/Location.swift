//
//  Location.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//

import Foundation

struct Location: Codable {
    let address: String?
    let latitude, longitude: Double
    let distance: Int
    let postalCode: String?
    let country, state, city: String?
    let formattedAddress: [String]
    let crossStreet, neighborhood: String?
    
    enum CodingKeys: String,CodingKey {
        case address, distance, postalCode, country, state, city, formattedAddress, crossStreet, neighborhood
        case latitude = "lat"
        case longitude = "lng"
    }
}

