//
//  NetworkControllerImpl.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Combine
import Foundation

final class NetworkControllerImpl: NetworkController {
    func get<T: Decodable>(type: T.Type,
                           url: URL,
                           headers: Headers
    ) -> ResultPublisher<T> {
        
        var urlRequest = URLRequest(url: url)
        dump(urlRequest)
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .timeout(2, scheduler: RunLoop.main, options: nil, customError: {
                return URLError(.timedOut)
            })
            .map(\.data)
            .decode(type: NetworkResponse<T>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

