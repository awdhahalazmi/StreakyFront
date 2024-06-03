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
                completion(.failure(error))
            }
        }
    }

}




