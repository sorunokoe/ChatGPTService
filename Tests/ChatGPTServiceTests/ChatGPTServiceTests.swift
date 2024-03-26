import XCTest
@testable import ChatGPTService

final class ChatGPTServiceTests: XCTestCase {
    func testExample() throws {
        let expectation = XCTestExpectation(description: "ChatGPT API Request")
        Task {
            let service = ChatGPTService(token: "")
            
            let prompt = "Could you create a training program for today that includes only 1 exercise for beginners? Format should be like this: '[exercise name]#[exercise condition like how many times or how long]#[short exsercise explanation]'"
            let result = await service.chat(promt: prompt)
            switch result {
            case .success(let content):
                print(content)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        wait(for: [expectation])
    }
}
