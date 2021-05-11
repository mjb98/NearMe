//
//  CLLocationCoordinate2D+distanceFrom.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import Foundation
import CoreLocation

extension Coordinate {
    func distanceFrom(_ location: Coordinate) -> CLLocationDistance {
        let firstLocation = CLLocation(latitude: latitude, longitude: longitude)
        let secondLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        return firstLocation.distance(from: secondLocation)
    }
}
