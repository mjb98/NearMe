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
    @Published var userMustGrantLocationPermision: Bool = false
    private let service: VenueService
    private var subscriptions = Set<AnyCancellable>()
    private var userCurrentLocation: CLLocationCoordinate2D?
    private var locationFethcer: LocationFetcher
    
    init(service: VenueService = VenueServiceImpl(), locationFethcer: LocationFetcher = LocationFetcher()) {
        self.service = service
        self.locationFethcer = locationFethcer
        prepateLocationFethcer()
    }
    
    private func prepateLocationFethcer() {
        self.locationFethcer.userdeniedLocationPermision  = { [weak self] in
            self?.userMustGrantLocationPermision = true
        }
        self.locationFethcer.userLocationUpdated = { [weak self] in
            self?.isMoreDataAvaialbe = true
            self?.userCurrentLocation = self?.locationFethcer.lastKnownLocation
            self?.getVenues()
        }
        
    }
    
    func getVenues() {
        guard let userLocation = self.userCurrentLocation else {
            self.isMoreDataAvaialbe = false
            self.locationFethcer.start()
            return
        }
        if !isLoading {
            error = nil
            isLoading = true
            service.getNearVenuses(latitude: userLocation.latitude, longitude: userLocation.longitude, page: self.venues.count)
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

