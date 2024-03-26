//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 26.03.24.
//

import Foundation

final class NetworkService {
    
    func request<T: Decodable>(target: Target) async -> T? {
        await withCheckedContinuation { continuation in
            let url = URL(string: target.baseURL + target.path)!
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = target.header
            request.httpBody = try? JSONSerialization.data(withJSONObject: target.body)
            request.httpMethod = target.method.rawValue
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("🔴" + " " + (error?.localizedDescription ?? "No data"))
                    continuation.resume(returning: nil)
                    return
                }
                
                let responseJSON = try? JSONDecoder().decode(T.self, from: data)
                continuation.resume(returning: responseJSON)
            }
            
            task.resume()
        }
    }
    
}
