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
            let r = redis.set(name: "goose", value: 30)
            let v = redis.get(name: "goose", default: 20)
            print("\(v)")
        } catch {

        }
    }

    static var allTests = [
        ("testExample", testExample),
        ("testSet", testSet),
    ]
}
