//
//  UserDefault.swift
//  NearMe
//
//  Created by Mohammad Javad Bashtani on 2/21/1400 AP.
//

import Foundation

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            if let value = container.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let decodedValue = try? decoder.decode(Value.self, from: value) {
                   return decodedValue
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: key)
            }
        }
    }
}
