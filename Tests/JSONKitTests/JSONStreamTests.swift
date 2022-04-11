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

func write(_ method: (inout JSONStream) -> Void) -> String {
    var stream = JSONStream()
    method(&stream)
    let data = stream.finalize()
    return String(data: data, encoding: .utf8)!
}

final class JSONStreamTests: XCTestCase {
    func testSingleValue() {
        let string = write { stream in
            stream.write("Foobar")
        }
        XCTAssertEqual(string, "\"Foobar\"")
        let int = write { stream in
            stream.write(887 as Int)
        }
        XCTAssertEqual(int, "887")
        let int32 = write { stream in
            stream.write(-2147483648 as Int32) // Int32.min
        }
        XCTAssertEqual(int32, "-2147483648")
        let int64 = write { stream in
            stream.write(2147483648 as Int64) // Int32.max + 1
        }
        XCTAssertEqual(int64, "2147483648")
        let uint = write { stream in
            stream.write(44334 as UInt)
        }
        XCTAssertEqual(uint, "44334")
        let uint32 = write { stream in
            stream.write(UInt32.max)
        }
        XCTAssertEqual(uint32, "4294967295")
        let double = write { stream in
            stream.write(Double.pi)
        }
        XCTAssertEqual(double, "3.141592653589793")
        let float = write { stream in
            stream.write(Float.pi)
        }
        XCTAssertEqual(float, "3.1415925")
        let truly = write { stream in
            stream.write(true)
        }
        XCTAssertEqual(truly, "true")
        let falsely = write { stream in
            stream.write(false)
        }
        XCTAssertEqual(falsely, "false")
    }

    func testEmptyArray() {
        let json = write { stream in
            stream.beginArray()
            stream.endArray()
        }
        XCTAssertEqual(json, "[]")
    }

    func testArray() {
        let json = write { stream in
            stream.beginArray()
            stream.write(false)
            stream.endArray()
        }
        XCTAssertEqual(json, "[false]")
    }

    func testArray2() {
        let json = write { stream in
            stream.beginArray()
            stream.write(false)
            stream.write(true)
            stream.endArray()
        }
        XCTAssertEqual(json, "[false,true]")
    }

    func testArray3() {
        let json = write { stream in
            stream.beginArray()
            stream.write(false)
            stream.write(123458)
            stream.write("\"123458\"")
            stream.write("君の日本語は上手です")
            stream.endArray()
        }
        XCTAssertEqual(json, "[false,123458,\"\"123458\"\",\"君の日本語は上手です\"]")
    }

    func testEmptyArrayClosure() {
        let json = write { stream in
            stream.writeArray { _ in }
        }
        XCTAssertEqual(json, "[]")
    }

    func testArrayClosure() {
        let json = write { stream in
            stream.writeArray { target in
                target.write(false)
            }
        }
        XCTAssertEqual(json, "[false]")
    }

    func testArrayClosure2() {
        let json = write { stream in
            stream.writeArray { target in
                target.write(false)
                target.write(true)
            }
        }
        XCTAssertEqual(json, "[false,true]")
    }

    func testArrayClosure3() {
        let json = write { stream in
            stream.writeArray { target in
                target.write(false)
                target.write(123458)
                target.write("\"123458\"")
                target.write("君の日本語は上手です")
            }
        }
        XCTAssertEqual(json, "[false,123458,\"\"123458\"\",\"君の日本語は上手です\"]")
    }

    func testEmptyObject() {
        let json = write { stream in
            stream.beginObject()
            stream.endObject()
        }
        XCTAssertEqual(json, "{}")
    }

    func testObject() {
        let json = write { stream in
            stream.beginObject()
            stream.write(key: "bool", true)
            stream.endObject()
        }
        XCTAssertEqual(json, "{\"bool\":true}")
    }

    func testObject2() {
        let json = write { stream in
            stream.beginObject()
            // NOTE: JSONStream write keys as-is, no uniqueness check.
            stream.write(key: "bool", true)
            stream.write(key: "bool", false)
            stream.endObject()
        }
        XCTAssertEqual(json, "{\"bool\":true,\"bool\":false}")
    }

    func testObject3() {
        let json = write { stream in
            stream.beginObject()
            stream.write(key: "bool", true)
            stream.write(key: "foo", "bar")
            stream.write(key: "int", 9393)
            stream.write(key: "jp", "君の日本語は上手です")
            stream.endObject()
        }
        XCTAssertEqual(json,
            #"{"bool":true,"foo":"bar","int":9393,"jp":"君の日本語は上手です"}"#)
    }

    func testEmptyObjectClosure() {
        let json = write { stream in
            stream.writeObject { _ in }
        }
        XCTAssertEqual(json, "{}")
    }

    func testObjectClosure() {
        let json = write { stream in
            stream.writeObject { target in
                target.write(key: "bool", true)
            }
        }
        XCTAssertEqual(json, "{\"bool\":true}")
    }

    func testObjectClosure2() {
        let json = write { stream in
            stream.writeObject { target in
                // NOTE: JSONStream write keys as-is, no uniqueness check.
                target.write(key: "bool", true)
                target.write(key: "bool", false)
            }
        }
        XCTAssertEqual(json, "{\"bool\":true,\"bool\":false}")
    }

    func testObjectClosure3() {
        let json = write { stream in
            stream.writeObject { target in
                target.write(key: "bool", true)
                target.write(key: "foo", "bar")
                target.write(key: "int", 9393)
                target.write(key: "jp", "君の日本語は上手です")
            }
        }
        XCTAssertEqual(json,
            #"{"bool":true,"foo":"bar","int":9393,"jp":"君の日本語は上手です"}"#)
    }

    func testArrayInArray() {
        let json = write { stream in
            stream.beginArray()
            stream.write("array")
            stream.beginArray()
            stream.write(true)
            stream.write(false)
            stream.endArray()
            stream.write("array2")
            stream.endArray()
        }
        XCTAssertEqual(json, #"["array",[true,false],"array2"]"#)
    }

    func testArrayInObject() {
        let json = write { stream in
            stream.beginObject()
            stream.write(key: "array")
            stream.beginArray()
            stream.write(true)
            stream.write(false)
            stream.endArray()
            stream.endObject()
        }
        XCTAssertEqual(json, #"{"array":[true,false]}"#)
    }

    func testObjectInObject() {
        let json = write { stream in
            stream.beginObject()
            stream.write(key: "object")
            stream.beginObject()
            stream.write(key: "bool", true)
            stream.write(key: "int", 100)
            stream.endObject()
            stream.endObject()
        }
        XCTAssertEqual(json, #"{"object":{"bool":true,"int":100}}"#)
    }

    func testObjectInArray() {
        let json = write { stream in
            stream.beginArray()
            stream.write("object")
            stream.beginObject()
            stream.write(key: "bool", true)
            stream.write(key: "int", 100)
            stream.endObject()
            stream.endArray()
        }
        XCTAssertEqual(json, #"["object",{"bool":true,"int":100}]"#)
    }
}
