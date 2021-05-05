//
//  VenueServiceImpl.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Foundation

final class VenueServiceImpl: VenueService {
    var networkController: NetworkController
    
    init(networkController: NetworkController = NetworkControllerImpl()) {
        self.networkController = networkController
    }
    
    func getNearVenuses(latitude: Double, longitude: Double) -> ResultPublisher<[Venue]> {
        let endpoint = Endpoint.nearVenus(latitude: latitude, longitude: longitude)
        return networkController.get(type: [Venue].self, url: endpoint.url, headers: [:])
        
    }
    
    
    
}
