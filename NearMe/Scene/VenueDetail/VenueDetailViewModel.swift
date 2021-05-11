//
//  VenueDetailViewModel.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/22/1400 AP.
//

import Combine
import Foundation

class VenueDetailViewModel: ObservableObject {
    private var subscriptions = Set<AnyCancellable>()
    private var service: VenueService
    private var venue: Venue
    @Published var isLoading = false
    @Published var error: Error?
    
     init(service: VenueService = NetworkVenueService(), venue: Venue) {
        self.service = service
        self.venue = venue
    }
    
    func getVenueDetail() {
        isLoading = true
        service
            .getVenuesDetail(id: venue.id)
            .receive(on: DispatchQueue.main)
            .sinkToResult { result in
                self.isLoading = false
                switch result {
                case .success(let data):
                    guard let venue = data.response else {
                        self.error = NetworkError.badRequest(description: data.meta.errorDetail ?? "SomeThing went wrong")
                        return
                    }
                    self.venue = venue
                case .failure(let error):
                    self.error = error
                    
                }
            }.store(in: &subscriptions)
    }
}
