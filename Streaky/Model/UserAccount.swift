//
//  UserAccount.swift
//  Streaky
//
//  Created by Fatma Buyabes on 01/06/2024.
//

import Foundation

struct UserAccount: Codable {
    let id: Int
    let name: String
    let email: String
    let genderId: Int
    let imagePath: String
}
