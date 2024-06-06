//
//  UserStreak.swift
//  Streaky
//
//  Created by Fatma Buyabes on 26/05/2024.
//

import Foundation
struct UserStreak : Codable  {
    var id: Int
    var userId: Int
    var streakId: Int
    var startDate: Date
    var endDate: Date
    var user: User
    var streak: Streak
}
