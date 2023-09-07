//
//  UserDefault.swift
//  ToDoList
//
//  Created by Jarae on 6/9/23.
//

import Foundation

final class UserdefaultStorage {
    
    enum Keys: String {
        case tasks
    }
    
    static let shared = UserdefaultStorage()
    
    private init() { }
    
    func saveWithKey<T: Any>(_ item: T, forKey key: Keys) {
        UserDefaults.standard.set(item, forKey: key.rawValue)
    }
    
    func getDataWithKey(forKey key: Keys) -> Data {
        UserDefaults.standard.data(forKey: key.rawValue) ?? Data()
    }
    
    func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func get(forKey key: String) -> Bool? {
        UserDefaults.standard.bool(forKey: key)
    }
    
    func save<T: Any>(_ item: T, forKey key: String) {
        UserDefaults.standard.set(item, forKey: key)
    }
}
