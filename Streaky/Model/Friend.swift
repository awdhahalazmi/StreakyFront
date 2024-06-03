import Foundation
//
//struct Friend : Codable {
//    let name: String
//    let profileImageUrl: String
//    let lastStreakLocation: String
//    let streakCount: Int
//}
struct Friend: Codable {
    let id: Int
    let name: String
    let email: String
    let userStreaksCount: Int
}


