//
//  UserDefault+Extension.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import Foundation
import CoreLocation


extension UserDefaults {
    @UserDefault(key: "lastLocations", defaultValue: nil)
    static var lastKnownLocation: Coordinate?
    
}




