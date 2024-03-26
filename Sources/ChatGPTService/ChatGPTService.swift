import Foundation

var credentials: SecurityCredentials?

struct SecurityCredentials {
    var token: String
}

public final class ChatGPTService {
    
    private let networkService: NetworkService
    
    public init(token: String) {
        credentials = SecurityCredentials(token: token)
        networkService = NetworkService()
    }
    
    public func chat(promt: String) async -> Result<String, Error> {
        guard let response: GptTurboResponse = await networkService.request(target: .chat(promt: promt)) else {
            return .failure(ChatGPTServiceError.noResponse)
        }
        guard let content = response.choices.first?.message.content else {
            return .failure(ChatGPTServiceError.decodingError)
        }
        return .success(content)
    }
    
}

enum ChatGPTServiceError: Error {
    case noResponse
    case decodingError
}
