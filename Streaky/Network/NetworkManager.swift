<<<<<<< HEAD
////
////  NetworkManager.swift
////  Streaky
////
////  Created by faten aldosari on 30/05/2024.
////
//





































































import Foundation
import Alamofire

class NetworkManager {

    
    
    
    private let baseUrl = "https://streakyapi20240528084142.azurewebsites.net/"
   

    static let shared = NetworkManager()

    func fetchAllFriends(token: String, completion: @escaping (Result<[Friend], Error>) -> Void) {
        
        var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJLZmguRW1haWwiOiJNYWhhQGdtYWlsLmNvbSIsIktmaC5Vc2VySWQiOiI3IiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoidXNlciIsImV4cCI6MjY2NDA4NjAxMywiaXNzIjoiaHR0cDovL3d3dy5teXNpdGUuY29tIiwiYXVkIjoiaHR0cDovL3d3dy5teXNpdGUuY29tIn0.8bAXdBN6gw3rVCM0vBBYc5Vq9qvj_o5Vd5Buzob2f1o"
        
        let url = baseUrl + "Auth/friends"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: [Friend].self) { response in
            switch response.result {
            case .success(let friends):
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Success: fetchAllFriends response: \(str)")
                }
                completion(.success(friends))
            case .failure(let error):
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Error: fetchAllFriends response: \(str)")}
                print(error.localizedDescription)
=======
import Foundation
import UIKit
import Alamofire

class NetworkManager {
    
    private let baseUrl = "https://streakyapi20240528084142.azurewebsites.net/"
    
    static let shared = NetworkManager()
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "auth/signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Signup response: \(value)") // Debug print
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: [])
                    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    completion(.success(tokenResponse))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    func login(user: UserLogin, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "Auth/login"
        print(user.email)
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    
    func fetchUserDetails(token: String, completion: @escaping (Result<UserDetails, Error>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]

        AF.request(baseUrl + "auth/profile", headers: headers).responseDecodable(of: UserDetails.self) { response in
            switch response.result {
            case .success(let userDetails):
                completion(.success(userDetails))
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    print("Server Response: \(jsonString)")
                }
>>>>>>> main
                completion(.failure(error))
            }
        }
    }

<<<<<<< HEAD
}




=======
    
    func getAllRewards(completion: @escaping (Result<[Reward], Error>) -> Void) {
        let url = baseUrl + "Rewards/getAllRewards"
        
        AF.request(url, method: .get).responseDecodable(of: [Reward].self) { response in
            switch response.result {
            case .success(let rewards):
                completion(.success(rewards))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllSecretExperiences(completion: @escaping (Result<[SecretExperience], Error>) -> Void) {
            let url = baseUrl + "SecretExperience/getAllSecretExperiences"
            
            AF.request(url, method: .get).responseDecodable(of: [SecretExperience].self) { response in
                switch response.result {
                case .success(let secretExperiences):
                    completion(.success(secretExperiences))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
    func getAllStreaks(completion: @escaping (Result<[Streak], Error>) -> Void) {
           let url = baseUrl + "Streak/getAllStreaks"
           
           AF.request(url, method: .get).responseDecodable(of: [Streak].self) { response in
               switch response.result {
               case .success(let streaks):
                   completion(.success(streaks))
               case .failure(let error):
                   print("Error: \(error.localizedDescription)")
                   if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                       print("Server Response: \(jsonString)")
                   }
                   completion(.failure(error))
               }
           }
       }
    
    
    func getUserAccount(completion: @escaping (Result<UserAccount, Error>) -> Void) {
            let url = baseUrl + "auth/profile"
            
            AF.request(url, method: .get).responseDecodable(of: UserAccount.self) { response in
                switch response.result {
                case .success(let profile):
                    completion(.success(profile))
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Server Response: \(jsonString)")
                    }
                    completion(.failure(error))
                }
            }
        }
    
    func editAccount(token: String, profile: EditAccount, image: UIImage?, completion: @escaping (Result<UserAccount, Error>) -> Void) {
            let headers: HTTPHeaders = [.authorization(bearerToken: token)]
            let url = baseUrl + "auth/profile"
            
            AF.upload(multipartFormData: { formData in
                formData.append(Data(profile.name.utf8), withName: "name")
                formData.append(Data(profile.email.utf8), withName: "email")
                formData.append(Data(profile.genderName.utf8), withName: "genderName")
                if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
                    formData.append(imageData, withName: "image", fileName: "profile.jpg", mimeType: "image/jpeg")
                }
            }, to: url, headers: headers).responseDecodable(of: UserAccount.self) { response in
                switch response.result {
                case .success(let updatedProfile):
                    completion(.success(updatedProfile))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    

}

>>>>>>> main
