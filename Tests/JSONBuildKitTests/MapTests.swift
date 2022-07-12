import XCTest
@testable import JSONBuildKit

final class MapTests: XCTestCase {
    func testStringKeyed() {
        check(expected: #"{"v":1}"#) {
            Map(["v": 1]) { value in
                value
            }
        }
        check(expected: #"{"v":1}"#) {
            Map(["v": 1]) { (key, value) in
                Keyed(key) {
                    value
                }
            }
        }
        check(expected: #"{"v":"1"}"#) {
            Map(["v": "1"]) { value in
                value
            }
        }
        check(expected: #"{"v":"1"}"#) {
            Map(["v": "1"]) { (key, value) in
                Keyed(key, value: value)
            }
        }
    }
}
