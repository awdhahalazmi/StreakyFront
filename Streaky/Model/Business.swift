//
//  Business.swift
//  Streaky
//
//  Created by Fatma Buyabes on 26/05/2024.
//

import Foundation
struct Business {
    var id: Int
    var name: String
    var categoryId: Int
    var image: String
    var question: String
    var correctAnswer: String
    var wrongAnswer1: String
    var wrongAnswer2: String
    var locations: [Location]
    var streaks: [Streak]
    var rewards: [Reward]
    var category: Category
}
