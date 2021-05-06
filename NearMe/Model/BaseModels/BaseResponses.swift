//
//  BaseResponses.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Foundation

struct NetworkResponse<T: Decodable>: Decodable {
    let meta: Meta
    let response: T
    
    struct Meta: Codable {
        let code: Int
    }
}


