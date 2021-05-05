//
//  Endpoint+URL.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/15/1400 AP.
//

import Foundation

extension Endpoint {
    private var clientKeys: [URLQueryItem] {
        
        guard let clientID =  Bundle.main.infoDictionary?["CLIENT_ID"] as? String,let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String else {
            return []
        }
        return [URLQueryItem(name: "client_id", value: clientID), URLQueryItem(name: "client_secret", value: clientSecret)]
    }
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.foursquare.com"
        components.path = "/v2/venues" + path
        components.queryItems = queryItems + clientKeys
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    var headers: [String: Any] {
        [:]
    }
}

extension Endpoint {
    static func nearVenus(latitude: Double, longitude: Double) -> Self {
        let queryParam = URLQueryItem(name: "ll", value: "\(latitude),\(longitude)")
        return Endpoint(path: "/search", queryItems: [queryParam])
    }
}
