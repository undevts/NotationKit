// MIT License
//
// Copyright (c) 2022 Notation Kit Project Authors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
