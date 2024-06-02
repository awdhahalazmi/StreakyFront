//
//  AuthManager.swift
//  Streaky
//
//  Created by Fatma Buyabes on 30/05/2024.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "authToken")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "authToken")
        }
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
}
