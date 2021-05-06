//
//  NetworkError.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/16/1400 AP.
//

import Foundation

enum NetworkError: LocalizedError {
    case badRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .badRequest(let description):
            return description
        }
    }
}
