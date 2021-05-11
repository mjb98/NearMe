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
    private let storageController: StorageController
    private var subscriptions = Set<AnyCancellable>()
    private var userCurrentLocation: Coordinate

    
    init(userLocation: Coordinate, service: VenueService = VenueServiceImpl(), storageController: StorageController = FileStroageController(), locationFethcer: LocationFetcher = LocationFetcher()) {
        self.service = service
        self.storageController = storageController
        self.userCurrentLocation = userLocation
        handleOnlineFirst()
       
    }
    
    private func handleOnlineFirst() {
        guard let lastLocation = UserDefaults.lastKnownLocation else { return }
        let distance = userCurrentLocation.distanceFrom(lastLocation)
        if distance <= 100 {
            self.venues = storageController.fetchVenues()
        } else {
            UserDefaults.lastKnownLocation = nil
            storageController.removeVenues()
        }
        
    }
    
    private func persistVenuesData() {
        UserDefaults.lastKnownLocation = userCurrentLocation
        self.storageController.saveVenues(venues: self.venues)
    }
  
    func getVenues() {
        if !isLoading {
            error = nil
            isLoading = true
            service.getNearVenuses(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude, page: self.venues.count)
                .receive(on: DispatchQueue.main)
                .sinkToResult { [weak self] result in
                    guard let self = self else { return}
                    self.isLoading = false
                    switch result {
                    case .success(let data):
                        if let result = data.response {
                            let newVenues = result.groups
                                .map(\.items).joined().map(\.venue)
                            self.venues.append(contentsOf: newVenues)
                            self.persistVenuesData()
                            self.isMoreDataAvaialbe = data.response?.totalResults ?? .max > self.venues.count
                        } else {
                            self.error = NetworkError.badRequest(description: data.meta.errorDetail ?? "cannot fetch data")
                        }
                    case .failure(let error):
                        self.error = error
                       
                    }
                }
                .store(in: &subscriptions)
        }
    }
    
    
}



