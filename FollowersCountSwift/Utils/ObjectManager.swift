//
//  ObjectManager.swift
//  FollowersCountSwift
//
//  Created by Kevinho Morales on 10/2/25.
//

import Foundation

final class ObjectManager {
    
    static let shared: ObjectManager = {
        ObjectManager()
    }()
    
    private init() {}
    
    private let defaults: UserDefaults = UserDefaults.standard
    
    func saveObjt<T: Codable>(objt: T, key: String) {
        do {
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(objt)
            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
            
            defaults.set(json, forKey: key)
            defaults.synchronize()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getObjt<T: Codable>(key: String) -> T? {
        do {
            if (UserDefaults.standard.object(forKey: key) == nil) {
                return nil
            } else {
                let json = UserDefaults.standard.string(forKey: key) ?? "{}"
                
                let jsonDecoder = JSONDecoder()
                guard let jsonData = json.data(using: .utf8) else {
                    return nil
                }
                
                let user: T = try jsonDecoder.decode(T.self, from: jsonData)
                return user
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func removeObjt(key: String) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
