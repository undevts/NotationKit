// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
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