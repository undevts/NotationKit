import XCTest
@testable import AnyNotationKit

final class AnyNotationTests: XCTestCase {
    func testString() {
        let container = AnyNotation("foobar")
        XCTAssertEqual(container.string, "foobar")
        XCTAssertEqual(container.stringValue!, "foobar")
        XCTAssertEqual(container.to(String.self)!, "foobar")
    }

    func testInt() {
        let value = 8939 as Int
        let container = AnyNotation(value)
        XCTAssertEqual(container.int, value)
        XCTAssertEqual(container.intValue!, value)
        XCTAssertEqual(container.int32, Int32(value))
        XCTAssertEqual(container.int32Value!, Int32(value))
        XCTAssertEqual(container.uint, UInt(value))
        XCTAssertEqual(container.uintValue!, UInt(value))
    }

    func testNumber() {
        let value = 4294967296 as Int64
        let number = NSNumber(value: value)
        let container = AnyNotation(number)
        XCTAssertEqual(container.int64, value)
        XCTAssertEqual(container.int64Value!, value)
        XCTAssertEqual(container.to(NSNumber.self)!, number)
    }

    func testArray() {
        let array: [Any] = [3993, "997"]
        let container = AnyNotation(array)
        XCTAssertEqual(container[0].int, 3993)
        XCTAssertEqual(container[1].string, "997")
        XCTAssertFalse(container[-1].isExists)
        XCTAssertFalse(container[2].isExists)
    }

    func testDictionary() {
        let dictionary: [String: Any] = ["abc": 12934, "xyz": "ppt"]
        let container = AnyNotation(dictionary)
        XCTAssertEqual(container["abc"].int, 12934)
        XCTAssertEqual(container["xyz"].string, "ppt")
        XCTAssertFalse(container["nan"].isExists)
    }
}
