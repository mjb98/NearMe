//
//  NetworkController.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Combine
import Foundation

protocol NetworkController: class {
    typealias Headers = [String: Any]
 
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers
    ) -> AnyPublisher<T, Error> where T: Decodable
}
