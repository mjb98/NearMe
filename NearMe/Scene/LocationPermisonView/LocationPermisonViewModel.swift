//
//  LocationPermisonViewModel.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import CoreLocation
import Foundation

class LocationPermsionViewModel: ObservableObject {
    @Published var currentLocation: Coordinate? = nil
    @Published var locationError: LocationError? = nil
    private var locationFethcer: LocationFetcher
  

    init(locationFethcer: LocationFetcher = .init()) {
        self.locationFethcer = locationFethcer
        configLocationFetcher()
    }
    
    func fetchUserLocation() {
        locationFethcer.start()
       
    }
    
    func retryFetchingLocation() {
        locationError = nil
        locationFethcer.retry()
    }
        
    func configLocationFetcher() {
     
        locationFethcer.userLocationUpdated = { [weak self] location  in
            self?.locationError = nil
            self?.currentLocation = location != nil ? Coordinate(location: location!) : nil
        }
        locationFethcer.errorOccuredWhenFetchingLocation = { [weak self] error  in
            self?.locationError = error
            
        }
    }
}

enum LocationError {
    case userDenied
    case error
}
