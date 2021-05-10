//
//  Venue.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Foundation

struct Venue: Codable, Identifiable {
    let id: String
    let name: String
    let location: Location?
    
}

extension Venue {
    struct ExploreResponse: Codable {
        let groups: [Group]
        let totalResults: Int
        
        struct Group: Codable {
            let items: [GroupItem]
            
            struct GroupItem: Codable {
                let venue: Venue
            }
        }
        
    }
    
}
