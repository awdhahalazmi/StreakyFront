//
//  Category.swift
//  Streaky
//
//  Created by Fatma Buyabes on 01/06/2024.
//

import Foundation
struct Category : Codable {
    var categoryId: Int
    var streakId: Int
    var streakTitle: String
    var description: String
    var pointsClaimed: Int
    var businessId: Int
    var businessName: String
    var businessImage: String
}
