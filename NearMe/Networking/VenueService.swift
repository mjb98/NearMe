//
//  VenueService.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Combine
import Foundation

typealias ResultPublisher<T: Decodable> = AnyPublisher<T, Error>

protocol VenueService: class {
    var networkController: NetworkController { get }
    
    func getNearVenuses(latitude: Double, longitude: Double) -> ResultPublisher<[Venue]>
    
}
