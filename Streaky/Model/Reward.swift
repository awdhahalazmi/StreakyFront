//
//  Reward.swift
//  Streaky
//
//  Created by Fatma Buyabes on 26/05/2024.
//

import Foundation
struct Reward : Codable {
    var id: Int
    var streakId: Int
    var streak: Streak
    var description: String
    var pointsClaimed: Int
    var businessId: Int
    var business: Business
}
