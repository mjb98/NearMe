//
//  LocationFetcher.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//

import CoreLocation
import Foundation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var userdeniedLocationPermision: (() -> Void)?
    var userLocationUpdated: ((CLLocationCoordinate2D?) -> Void)?
    var errorOccuredWhenFetchingLocation: ((LocationError) -> Void)?
   

    override init() {
        super.init()
        manager.delegate = self

    }

    func start() {
        manager.requestWhenInUseAuthorization()
    }
    
    func retry() {
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocationUpdated?(locations.first?.coordinate)
        manager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            errorOccuredWhenFetchingLocation?(.userDenied)
            return
        }
        manager.startUpdatingLocation()
        return
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (manager.authorizationStatus != .denied  || manager.authorizationStatus != .notDetermined) && manager.location == nil {
            if manager.location != nil {
                errorOccuredWhenFetchingLocation?(.error)
            }
            manager.stopUpdatingLocation()
            
        }
      
    }

}
