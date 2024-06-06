//
//  UserAccount.swift
//  Streaky
//
//  Created by Fatma Buyabes on 01/06/2024.
//

import Foundation

struct UserAccount: Codable {
    let id: Int
    var name: String
    var email: String
    var genderId: Int
    let imagePath: String
    let points: Double
    
}
