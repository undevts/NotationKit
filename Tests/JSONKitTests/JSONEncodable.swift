import XCTest
@testable import JSONKit

final class JSONEncodableTests: XCTestCase {
    func testEncodable() {
        let encoder = JSONEncoder()

        func test(_ input: String) {
            let json = try! JSON.parse(input).get()
            let data = try! encoder.encode(json)
            let result = String(data: data, encoding: .utf8)!
            XCTAssertEqual(input, result)
        }

        test("null")
        test("0")
        test("10000")
        test("148484847540000")
        test("1.5")
        test("true")
        test("false")
        test("\"10000\"")
        test("[true,false]")
        test("[100,200,\"11\"]")
        test("{\"100\":\"1223334444\"}")
    }

    func testJSONEncodable() {
        func test(_ input: String) {
            let json = try! JSON.parse(input).get()
            let data = json.encoded()
            let result = String(data: data, encoding: .utf8)!
            XCTAssertEqual(input, result)
        }

        test("null")
        test("0")
        test("10000")
        test("148484847540000")
        test("1.5")
        test("true")
        test("false")
        test("\"10000\"")
        test("[true,false]")
        test("[100,200,\"11\"]")
        test("{\"100\":\"1223334444\"}")
    }
}
