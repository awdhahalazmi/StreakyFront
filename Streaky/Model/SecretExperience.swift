//
//  SecretExperience.swift
//  Streaky
//
//  Created by faten aldosari on 28/05/2024.
//

import Foundation
struct SecretExperience : Codable  {
        var id: Int
        var startDate: Date
        var endDate: Date
        var title: String
        var description: String
        var streakClaimed: Int
        var businessName: String
        var businessImage: String
}


