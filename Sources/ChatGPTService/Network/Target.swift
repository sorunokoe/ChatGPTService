//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 26.03.24.
//

import Foundation

enum Method: String {
    case POST, GET
}

protocol TargetProtocol {
    var baseURL: String { get }
    var path: String { get }
    var header: [String: String] { get }
    var body: [String: Any] { get }
    var method: Method { get }
}

enum Target: TargetProtocol {
    case chat(promt: String)
    
    var baseURL: String {
        "https://api.openai.com/v1"
    }
    
    var path: String {
        "/chat/completions"
    }
    
    var header: [String: String] {
        if let credentials = credentials {
            return ["Authorization": "Bearer \(credentials.token)",
                    "Content-Type": "application/json"]
        }
        return [:]
    }
    
    var body: [String: Any] {
        switch self {
        case let .chat(promt):
            [
                "model": "gpt-3.5-turbo",
                "messages": [["role": "user", "content": promt]],
                "temperature": 0.7
            ]
        }
    }
    
    var method: Method {
        .POST
    }
}
