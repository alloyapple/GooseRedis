import XCTest

import GooseRedisTests

var tests = [XCTestCaseEntry]()
tests += GooseRedisTests.allTests()
XCTMain(tests)
