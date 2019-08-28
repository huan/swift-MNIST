import XCTest

import MNISTTests

var tests = [XCTestCaseEntry]()
tests += MNISTTests.allTests()
XCTMain(tests)
