import Foundation

struct Friend : Codable {
    let name: String
    let profileImageUrl: String
    let lastStreakLocation: String
    let streakCount: Int
}
