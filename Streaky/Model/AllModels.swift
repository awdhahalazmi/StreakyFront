//
//  AllModels.swift
//  Streaky
//
//  Created by Fatma Buyabes on 29/05/2024.
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
    var question2: String
    var correctAnswerQ2: String
    var wrongAnswerQ2_1: String
    var wrongAnswerQ2_2: String
    var locations: [Location] = []
    var streaks: [Streaks] = []
    var rewards: [Reward] = []
    var secretExperiences: [SecretExperience] = []
    var category: Category?
}

struct Location {
    var id: Int
    var name: String
    var url: String
    var radius: Double
    var latitude: Double
    var longitude: Double
}

struct Category {
    var id: Int
    var name: String
    var businesses: [Business] = []
}

struct Streaks {
    var id: Int
    var title: String
    var description: String
    var businessId: Int
    var startDate: Date
    var endDate: Date
    var businesses: [Business] = []
    var userStreaks: [UserStreak] = []
    var rewards: [Reward] = []
}

struct Reward {
    var id: Int
    var streakId: Int
    var streak: Streaks
    var description: String
    var pointsClaimed: Int
    var businessId: Int
    var business: Business
}

struct SecretExperience {
    var id: Int
    var startDate: Date
    var endDate: Date
    var title: String
    var description: String
    var streakClaimed: Int
    var businessId: Int
    var business: Business
}

struct UserStreak {
    var id: Int
    var userId: Int
    var streakId: Int
    var startDate: Date
    var endDate: Date
   // var user: UserAccount
    var streak: Streaks
}
