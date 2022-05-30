import XCTest
@testable import JSONKit

func parse(_ value: String) -> JSON {
    try! JSON.parse(value).get()
}

final class JSONTests: XCTestCase {
    func testParseFixedWidthInteger() {
        func test<Value>(_ value: Value) where Value: FixedWidthInteger {
            let input = "\(value)"
            let json = parse(input)
            XCTAssertEqual(json.int, Int(exactly: value) ?? 0, input)
            XCTAssertEqual(json.intValue, Int(exactly: value) ?? 0, input)
            XCTAssertEqual(json.int32, Int32(exactly: value) ?? 0, input)
            XCTAssertEqual(json.int32Value, Int32(exactly: value) ?? 0, input)
            XCTAssertEqual(json.int64, Int64(exactly: value) ?? 0, input)
            XCTAssertEqual(json.int64Value, Int64(exactly: value) ?? 0, input)
            XCTAssertEqual(json.uint, UInt(exactly: value) ?? 0, input)
            XCTAssertEqual(json.uintValue, UInt(exactly: value) ?? 0, input)
            XCTAssertEqual(json.uint32, UInt32(exactly: value) ?? 0, input)
            XCTAssertEqual(json.uint32Value, UInt32(exactly: value) ?? 0, input)
            XCTAssertEqual(json.uint64, UInt64(exactly: value) ?? 0, input)
            XCTAssertEqual(json.uint64Value, UInt64(exactly: value) ?? 0, input)
            XCTAssertEqual(json.float, Float(value), accuracy: Float.ulpOfOne, input)
            XCTAssertEqual(json.floatValue!, Float(value), accuracy: Float.ulpOfOne, input)
            XCTAssertEqual(json.double, Double(value), accuracy: Double.ulpOfOne, input)
            XCTAssertEqual(json.doubleValue!, Double(value), accuracy: Double.ulpOfOne, input)

            XCTAssertEqual(json.bool, false, input)
            XCTAssertNil(json.boolValue, input)
            XCTAssertEqual(json.string, "", input)
            XCTAssertNil(json.stringValue, input)
        }

        test(0)
        test(Int32.min)
        test(Int32.max)
        test(UInt32.min)
        test(UInt32.max)
        test(Int64.min)
        test(Int64.max)
        test(UInt64.min)
        test(UInt64.max)

        for _ in 0..<1000 {
            test(Int64.random(in: Int64.min...Int64.max))
            test(UInt64.random(in: UInt64.min...UInt64.max))
        }
    }

    func testParseString() {
        func test(_ value: String, expected: String? = nil) {
            let json = parse("\"\(value)\"")
            XCTAssertEqual(json.string, expected ?? value)
            XCTAssertEqual(json.stringValue, expected ?? value)

            XCTAssertEqual(json.int, 0)
            XCTAssertEqual(json.int32, 0)
            XCTAssertEqual(json.int64, 0)
            XCTAssertEqual(json.uint, 0)
            XCTAssertEqual(json.uint32, 0)
            XCTAssertEqual(json.uint64, 0)
            XCTAssertEqual(json.float, 0)
            XCTAssertEqual(json.double, 0)
            XCTAssertEqual(json.bool, false)

            XCTAssertNil(json.intValue)
            XCTAssertNil(json.int32Value)
            XCTAssertNil(json.int64Value)
            XCTAssertNil(json.uintValue)
            XCTAssertNil(json.uint32Value)
            XCTAssertNil(json.uint64Value)
            XCTAssertNil(json.floatValue)
            XCTAssertNil(json.doubleValue)
            XCTAssertNil(json.boolValue)
        }

        test("")
        test("100")
        test("null")
        test("true")
        test("false")
        test(#"\n━((*′д｀)爻(′д｀*))━!!!!😁"#, expected: "\n━((*′д｀)爻(′д｀*))━!!!!😁")
        test(#"\n"#, expected: "\n")
    }

    func testParseHomogeneousArray() { // 同构
        let array = parse("[1, 3, 5]")
        XCTAssertEqual(array.array.map(\.int), [1, 3, 5])
        XCTAssertEqual(array.array.compactMap(\.intValue), [1, 3, 5])
        XCTAssertEqual(array.item(at: 0).int, 1)
        XCTAssertEqual(array.item(at: 1).int, 3)
        XCTAssertEqual(array.item(at: 2).int, 5)

        let array2 = parse("[true, false]")
        XCTAssertEqual(array2.array.map(\.bool), [true, false])
        XCTAssertEqual(array2.array.compactMap(\.boolValue), [true, false])
        XCTAssertEqual(array2.item(at: 0).bool, true)
        XCTAssertEqual(array2.item(at: 1).bool, false)

        let array3 = parse("[\"foobar\", \"xyz\"]")
        XCTAssertEqual(array3.array.map(\.string), ["foobar", "xyz"])
        XCTAssertEqual(array3.array.compactMap(\.stringValue), ["foobar", "xyz"])
        XCTAssertEqual(array3.item(at: 0).string, "foobar")
        XCTAssertEqual(array3.item(at: 1).string, "xyz")
    }

    func testParseHeterogeneousArray() { // 异构
        let json = parse("[1, \"foobar\", true, 0.258]")
        let array = json.array
        XCTAssertEqual(array[0].int, 1)
        XCTAssertEqual(array[1].string, "foobar")
        XCTAssertEqual(array[2].bool, true)
        XCTAssertEqual(array[3].double, 0.258, accuracy: Double.ulpOfOne)
        XCTAssertEqual(json.item(at: 0).int, 1)
        XCTAssertEqual(json.item(at: 1).string, "foobar")
        XCTAssertEqual(json.item(at: 2).bool, true)
        XCTAssertEqual(json.item(at: 3).double, 0.258, accuracy: Double.ulpOfOne)
    }
}
