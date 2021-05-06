//
//  Venue.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Foundation

struct Venue: Decodable, Identifiable {
    let id: String
    let name: String
    let location: Location?
    
}

extension Venue {
    struct ExploreResponse: Decodable {
        let groups: [Group]
        
        struct Group: Decodable {
            let items: [GroupItem]
            
            struct GroupItem: Decodable {
                let venue: Venue
            }
        }
        
    }
    
}
