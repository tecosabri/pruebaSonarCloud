//
//  UserDefaultsHelper.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 25/7/23.
//


import Foundation

final class UserDefaultsHelper {
    
    static let defaults = UserDefaultsHelper()
    private init() {}
    
    func save(user: String) {
        UserDefaults.standard.setValue(user, forKey: "user")
        UserDefaults.standard.synchronize()
    }
    
    func readUser() -> String? {
        return UserDefaults.standard.string(forKey: "user")
    }
}

