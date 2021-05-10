//
//  VenuesListViewModel.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//
import Combine
import CoreLocation
import Foundation

class VenuesListViewModel: ObservableObject {
    @Published var venues: [Venue] = []
    @Published var isMoreDataAvaialbe: Bool = true
    @Published var isLoading = false
    @Published var error: Error?
    private let service: VenueService
    private var subscriptions = Set<AnyCancellable>()
    private var userCurrentLocation: CLLocationCoordinate2D

    
    init(userLocation: CLLocationCoordinate2D, service: VenueService = VenueServiceImpl(), locationFethcer: LocationFetcher = LocationFetcher()) {
        self.service = service
        self.userCurrentLocation = userLocation
        
        prepateLocationFethcer()
    }
    
    private func prepateLocationFethcer() {
       
        
    }
    
    func getVenues() {
        if !isLoading {
            error = nil
            isLoading = true
            service.getNearVenuses(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude, page: self.venues.count)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [self] (completion) in
                    switch completion {
                    case let .failure(error):
                        self.error = error
                        self.isLoading = false
                    case .finished:
                        isLoading = false
                    }
                }) { venues in
                    
                    if let result = venues.response {
                        let newVenues = result.groups
                            .map(\.items).joined().map(\.venue)
                        self.venues.append(contentsOf: newVenues)
                        self.isMoreDataAvaialbe = venues.response?.totalResults ?? .max > self.venues.count
                    } else {
                        self.error = NetworkError.badRequest(description: venues.meta.errorDetail ?? "cannot fetch data")
                    }
                    
                }
                .store(in: &subscriptions)
        }
    }
    
    
}

