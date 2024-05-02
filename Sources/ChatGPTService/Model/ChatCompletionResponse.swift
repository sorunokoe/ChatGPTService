//
//  File.swift
//  
//
//  Created by SALGARA, YESKENDIR on 26.03.24.
//

import Foundation

struct ChatCompletionResponse: Decodable {
    let error: ChatCompletionError?
    let usage: GptTurboUsage?
    let choices: [GptTurboChoices]
}

struct ChatCompletionError: Decodable {
    let message: String
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
