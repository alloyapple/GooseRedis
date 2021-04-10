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

    func testSet() {
        do {
            let redis = try Redis(host: "localhost", port: 8379)
            redis.set(name: "goose", value: 20)
        } catch {

        }
    }

    static var allTests = [
        ("testExample", testExample),
        ("testSet", testSet),
    ]
}
