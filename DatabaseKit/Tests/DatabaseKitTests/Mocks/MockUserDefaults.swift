//
//  File.swift
//  DatabaseKit
//
//  Created by Ahmed Elmansy on 01/02/2025.
//

import Foundation

class MockUserDefaults: UserDefaults {
    
    private var storage: [String: Any] = [:]

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }

    override func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }

    override func removeObject(forKey defaultName: String) {
        storage.removeValue(forKey: defaultName)
    }

    override func dictionaryRepresentation() -> [String: Any] {
        return storage
    }
    
    func clear() {
        storage.removeAll()
    }
}
