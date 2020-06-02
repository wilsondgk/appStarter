//
//  UserDefaultProvider.swift
//  ConcreteMovieApp
//
//  Created by Wilson Kim on 24/04/20.
//  Copyright © 2020 Wilson Kim. All rights reserved.
//

import Foundation

public protocol UserDefaultProviderProtocol {
    func setValue<T: Encodable>(_ value: T, forKey key: String)
    func getValue<T: Decodable>(forKey key: String) -> T?
    func deleteObject(forKey key: String)
}

public class UserDefaultProvider {
    
    public static let shared = UserDefaultProvider()
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    public func setValue<T: Encodable>(_ value: T, forKey key: String) {
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(value)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    public func getValue<T: Decodable>(forKey key: String) -> T? {
        
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        let resultDecoded = try? JSONDecoder().decode(T.self, from: data)
        return resultDecoded
    }
    
    public func deleteObject(forKey key: String) {
        userDefaults.set(nil, forKey: key)
    }
}
