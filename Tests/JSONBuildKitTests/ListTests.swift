import XCTest
@testable import JSONBuildKit

final class ListTests: XCTestCase {
    func testIntList() {
        check(expected: "[1,2,3]") {
            List([1, 2, 3])
        }
    }

    func testStringList() {
        check(expected: #"["1","2","3"]"#) {
            List(["1", "2", "3"])
        }
    }
}
