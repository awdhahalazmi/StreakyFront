//
//  Streak.swift
//  Streaky
//
//  Created by Fatma Buyabes on 26/05/2024.
//

import Foundation

struct Streak : Codable {
        var id: Int
        var title: String
        var description: String
        var startDate: String
        var endDate: String
        var businesses: [Business]
}

