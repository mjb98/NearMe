//
//  StorageController.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import Foundation

protocol StorageController {
    func saveVenues(venues: [Venue])
    func fetchVenues() -> [Venue]
}

class FileStroageController: StorageController {
    private let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    private var venuesFileURL: URL {
        return documentsDirectoryURL
            .appendingPathComponent("Venues")
            .appendingPathExtension("json")
             
    }
    
    func saveVenues(venues: [Venue]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(venues) else { return }
        try? data.write(to: venuesFileURL)
         
         
        
    }
    
    func fetchVenues() -> [Venue] {
        guard let data = try? Data(contentsOf: venuesFileURL) else { return [] }
        let decoder = JSONDecoder()
        let venues = try? decoder.decode([Venue].self, from: data)
        return venues ?? []
    }
    
    
}
