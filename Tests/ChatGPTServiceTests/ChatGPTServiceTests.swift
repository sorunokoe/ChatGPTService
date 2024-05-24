import XCTest
@testable import ChatGPTService

final class ChatGPTServiceTests: XCTestCase {
    
    var service: ChatGPTService!
    
    override func setUp() async throws {
        service = ChatGPTService(token: "sk-story-ai-vJgg9D9JZnTFQBXWt4KCT3BlbkFJx0edg4Kdc5h7nieLwcha")
    }
    
    func testChat() throws {
        let expectation = XCTestExpectation(description: "ChatGPT API Chat Request")
        Task {
            let prompt = "Could you create a training program for today that includes only 1 exercise for beginners? Format should be like this: '[exercise name]#[exercise condition like how many times or how long]#[short exsercise explanation]'"
            let result = await service.chat(promt: prompt)
            switch result {
            case .success(let content):
                print(content)
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTFail()
            }
        }
        wait(for: [expectation])
    }
    
    func testImage() throws {
        let expectation = XCTestExpectation(description: "ChatGPT API Image Request")
        Task {
            let prompt = "Could you create an image of pikachu pokemon?"
            let result = await service.image(promt: prompt)
            switch result {
            case .success(let content):
                print(content.url)
            case .failure(let failure):
                print(failure.localizedDescription)
                XCTFail()
            }
        }
        wait(for: [expectation])
    }
}
