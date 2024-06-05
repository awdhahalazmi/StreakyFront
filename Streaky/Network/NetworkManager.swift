import Foundation
import UIKit
import Alamofire

class NetworkManager {
    
    private let baseUrl = "https://streakyapi20240528084142.azurewebsites.net/"
    
    static let shared = NetworkManager()
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "auth/signup"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                print("Signup response: \(value)") // Debug print
                completion(.success(value))
            case .failure(let afError):
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw error response: \(str)")
                }
                completion(.failure(afError))
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
    
    
    func updatesPoints(points: UpdatePoints, token: String, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        let url = baseUrl + "Auth/updatePoints"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .post, parameters: points, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let data = response.data, let str = String(data: data, encoding: .utf8) {
                print("Raw response: \(str)")
            }
            
            print("Response status code: \(response.response?.statusCode ?? 0)")
            print("Response headers: \(response.response?.allHeaderFields ?? [:])")
            
            switch response.result {
                
            case .success(let data):
                print("yaaaaay")
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(MessageResponse.self, from: data!)
                    completion(.success(decodedResponse))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw error response: \(str)")
                }
                completion(.failure(error))
            }
        }
    }
        
    func fetchUserDetails(token: String, completion: @escaping (Result<UserAccount, Error>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(baseUrl + "Auth/profile", headers: headers).responseDecodable(of: UserAccount.self) { response in
            switch response.result {
            case .success(let profile):
                completion(.success(profile))
                profile.name
                profile.email
                profile.points
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
        
        
        func getAllRewards(token: String, completion: @escaping (Result<[Reward], Error>) -> Void) {
            let headers: HTTPHeaders = [.authorization(bearerToken: token)]
            
            let url = baseUrl + "Rewards/getAllRewards"
            AF.request(url, method: .get, headers: headers).responseDecodable(of: [Reward].self) { response in
                switch response.result {
                case .success(let rewards):
                    print("123kdd \(response)")
                    completion(.success(rewards))
                case .failure(let error):
                    print("123kdd \(response)")
                    completion(.failure(error))
                }
            }
        }
        
        
        
        func getAllSecretExperiences(token: String, completion: @escaping (Result<[SecretExperience], Error>) -> Void) {
            let headers: HTTPHeaders = [.authorization(bearerToken: token)]
            let url = baseUrl + "SecretExperience"
            AF.request(url, method: .get,headers: headers).responseDecodable(of: [SecretExperience].self) { response in
                switch response.result {
                case .success(let secretExperiences):
                    print("success in : getAllSecretExperiences")
                    completion(.success(secretExperiences))
                case .failure(let error):
                    print("error in getAllSecretExperiences:")
                    completion(.failure(error))
                }
            }
        }
        
    func getUserStreaks(token: String, completion: @escaping (Result<UserStreak, Error>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let url = baseUrl + "Streak/getUserStreaks"
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: UserStreak.self) { response in
            switch response.result {
            case .success(let streaks):
                completion(.success(streaks))
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                    //ISSUE HERE!x
                    print("Server Response: \(jsonString)")
                }
                completion(.failure(error))
            }
        }
    }
            
            
            
    func getStreaks(token: String, completion: @escaping (Result<[Streak], Error>) -> Void) {
                let headers: HTTPHeaders = [.authorization(bearerToken: token)]
                let url = baseUrl + "Streak/getallstreaks"
                
                AF.request(url, method: .get, headers: headers).responseDecodable(of: [Streak].self) { response in
                    switch response.result {
                    case .success(let streaks):
                        completion(.success(streaks))
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                            //ISSUE HERE!x
                            print("error in getStreaks   :: \(jsonString)")
                            
                        }
                        completion(.failure(error))
                    }
                }
                
            }
                
//                func editAccount(token: String, profile: EditAccount, image: UIImage?, completion: @escaping (Result<UserAccount, Error>) -> Void) {
//                    let headers: HTTPHeaders = [.authorization(bearerToken: token)]
//                    let url = baseUrl + "auth/profile"
//                    
//                    AF.upload(multipartFormData: { formData in
//                        formData.append(Data(profile.name.utf8), withName: "name")
//                        formData.append(Data(profile.email.utf8), withName: "email")
//                        formData.append(Data(profile.genderName.utf8), withName: "genderName")
//                        if let image = image, let imageData = image.jpegData(compressionQuality: 0.8) {
//                            formData.append(imageData, withName: "image", fileName: "profile.jpg", mimeType: "image/jpeg")
//                        }
//                    }, to: url, headers: headers).responseDecodable(of: UserAccount.self) { response in
//                        switch response.result {
//                        case .success(let updatedProfile):
//                            completion(.success(updatedProfile))
//                        case .failure(let error):
//                            completion(.failure(error))
//                        }
//                    }
//                }
                
                
            }
            
        
    

