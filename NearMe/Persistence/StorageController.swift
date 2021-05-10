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
        .first
    
    func saveVenues(venues: [Venue]) {
        
    }
    
    func fetchVenues() -> [Venue] {
        []
    }
    
    
}
