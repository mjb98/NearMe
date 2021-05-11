//
//  Coordinate.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import CoreLocation
import Foundation

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
    
    init(location: CLLocationCoordinate2D) {
        latitude = location.latitude
        longitude = location.longitude
    }
}
