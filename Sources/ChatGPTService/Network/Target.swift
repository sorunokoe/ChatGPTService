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
    case image(promt: String)
    
    var baseURL: String {
        "https://api.openai.com/v1"
    }
    
    var path: String {
        switch self {
        case .chat:
            return "/chat/completions"
        case .image:
            return "/images/generations"
        }
        
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
                "model": "gpt-4o",
                "messages": [["role": "user", "content": promt]],
                "temperature": 0.9
            ]
        case let .image(promt):
            [
                "model": "dall-e-3",
                "prompt": promt,
                "n": 1,
                "size": "512x512"
            ]
        }
    }
    
    var method: Method {
        .POST
    }
}
