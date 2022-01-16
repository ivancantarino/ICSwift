//
//  UserDefaults.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import Foundation

public extension UserDefaults {    
    /// Checks if the given key exists within `UserDefaults`
    /// - Parameter key: The `key` to check
    /// - Returns: Returns `true` if the key is present
    func isKeyPresent(key: String) -> Bool {
        return object(forKey: key) != nil
    }
}
