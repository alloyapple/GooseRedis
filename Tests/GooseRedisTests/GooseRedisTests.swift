import XCTest
@testable import GooseRedis

final class GooseRedisTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GooseRedis().text, "Hello, World!")

        let str = "\r\n"
        let buf: [UInt8] = Array("\r\n".utf8)
        print("a: \(buf)")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
