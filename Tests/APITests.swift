import XCTest
@testable import swiftGPT

final class APITests: XCTestCase {
    // TODO: API Token must be prepared.
    func testPostRequestSuccess() async throws {
        let input = "テストメッセージ"
        do {
            let result = try await APIClient().postRequest(input)
            XCTAssertNotNil(result)
        } catch {
            XCTFail("Request should not fail: \(error)")
        }
    }
}
