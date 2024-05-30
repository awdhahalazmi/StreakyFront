
import Foundation
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
}
