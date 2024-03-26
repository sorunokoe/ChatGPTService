//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 26.03.24.
//

import Foundation

struct GptTurboResponse: Decodable {
    let usage: GptTurboUsage
    let choices: [GptTurboChoices]
}

struct GptTurboUsage: Decodable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

struct GptTurboChoices: Decodable {
    let message: GptTurboMessage
}

struct GptTurboMessage: Decodable {
    let content: String
}
