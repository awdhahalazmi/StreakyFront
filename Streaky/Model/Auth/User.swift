//
//  User.swift
//  Streaky
//
//  Created by Fatma Buyabes on 20/05/2024.
//

import Foundation
struct User : Codable{
    let name: String
    let email: String
    let password : String
    let genderId : Int  //change to Gender then
}
