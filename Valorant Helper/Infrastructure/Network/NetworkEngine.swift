//
//  NetworkEngine.swift
//  GoodNetworkLayer
//
//  Created by Zura Kobakhidze on 02.02.22.
//

import Foundation

class NetworkEngine {
    
    static let shared = NetworkEngine()
    
    private init() {}
    
    func request<T: Codable>(endPoint: Endpoint, completion: @escaping ((Result<T, Error>) -> Void)) {
        
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.baseURL
        components.path = endPoint.path
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}
