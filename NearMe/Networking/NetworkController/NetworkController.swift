//
//  NetworkController.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Combine
import Foundation

protocol NetworkController {
    typealias Headers = [String: Any]
 
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers
    ) -> ResultPublisher<T> where T: Decodable
}
