//
//  VenueServiceImpl.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Foundation

struct NetworkVenueService: VenueService {
    var networkController: NetworkController
    
    init(networkController: NetworkController = NetworkControllerImpl()) {
        self.networkController = networkController
    }
    
    func getNearVenuses(latitude: Double, longitude: Double, page: Int) -> ResultPublisher<Venue.ExploreResponse> {
        let endpoint = Endpoint.nearVenus(latitude: latitude, longitude: longitude, offset: page)
        return networkController.get(type: Venue.ExploreResponse.self, url: endpoint.url, headers: [:])
    }
    
    func getVenuesDetail(id: String) -> ResultPublisher<Venue.DetailResponse> {
        let endpoint = Endpoint.venueDetail(id: id)
        return networkController.get(type: Venue.DetailResponse.self, url: endpoint.url, headers: [:])
    }
    
    
    
    
}
