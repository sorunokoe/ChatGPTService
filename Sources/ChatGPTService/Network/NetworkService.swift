//
//  File.swift
//
//
//  Created by SALGARA, YESKENDIR on 26.03.24.
//

import Foundation

final class NetworkService {
    private let session: URLSession

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        self.session = URLSession(configuration: configuration)
    }

    func request<T: Decodable>(target: Target) async -> T? {
        let url = URL(string: target.baseURL + target.path)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = target.header
        request.httpBody = try? JSONSerialization.data(withJSONObject: target.body)
        request.httpMethod = target.method.rawValue

        do {
            let (data, _) = try await session.data(for: request)
            #if DEBUG
            print(String(data: data, encoding: .utf8))
            #endif
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch {
                print("🔴 Decoding failed: \(error)")
            }
        } catch {
            #if DEBUG
            print(String(describing: error))
            #endif
            return nil
        }
        return nil
    }
}
