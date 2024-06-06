//
//  UserDetails.swift
//  Streaky
//
//  Created by Fatma Buyabes on 30/05/2024.
//

import Foundation
struct UserDetails : Codable{
    let name: String
    let email: String
    let password : String
    let genderName : String  //change to Gender then
    var id: Int64

}
