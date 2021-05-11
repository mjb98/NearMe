//
//  Location+Extension.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//

import CoreLocation
import Foundation

extension Location {
    var coordinate: Coordinate {
        return Coordinate(latitude: latitude, longitude: longitude)
    }
}
