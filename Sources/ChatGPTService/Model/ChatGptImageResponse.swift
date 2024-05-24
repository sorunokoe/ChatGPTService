//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 24.05.24.
//

import Foundation

struct ChatGptImageResponse: Decodable {
    let data: [ImageURL]
}

public struct ImageURL: Decodable {
    public let url: String
    
    public init(url: String) {
        self.url = url
    }
}
