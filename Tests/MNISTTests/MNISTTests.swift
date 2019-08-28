import XCTest
@testable import MNIST

final class MNISTTests: XCTestCase {
    func testExample() {
        XCTAssertGreaterThan(MNIST().labels!.shape[0], 1, "Should load MNIST")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
