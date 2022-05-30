import XCTest
@testable import JSONKit

func write(null: Bool = false, _ method: (inout JSONStream) -> Void) -> String {
    var stream = JSONStream(formatting: null ? .writeNull : [])
    method(&stream)
    let data = stream.finalize()
    return String(data: data, encoding: .utf8)!
}

func check(expected: String, null: Bool = false, file: StaticString = #filePath, line: UInt = #line,
    _ method: (inout JSONStream) -> Void) {
    let value = write(null: null, method)
    XCTAssertEqual(value, expected, file: file, line: line)
}

func check(expected: String, null: Bool = false, file: StaticString = #filePath, line: UInt = #line,
    _ method: (inout JSONStream) -> Void, encodable: (inout JSONStream) -> Void) {
    let value = write(null: null, method)
    XCTAssertEqual(value, expected, file: file, line: line)

    let value2 = write(null: null, encodable)
    XCTAssertEqual(value2, expected, file: file, line: line)
}

final class JSONStreamTests: XCTestCase {
    func testString() {
        let v1 = write { stream in
            stream.value("")
        }
        XCTAssertEqual(v1, "\"\"")
        let v2 = write { stream in
            stream.value(" ")
        }
        XCTAssertEqual(v2, "\" \"")
        let v3 = write { stream in
            stream.value("Foobar")
        }
        XCTAssertEqual(v3, "\"Foobar\"")
        let v4 = write { stream in
            stream.value("\n\t")
        }
        XCTAssertEqual(v4, "\"\\n\\t\"")
    }

    func testSpecialDoubleValue() {
        check(expected: "nan") { stream in
            stream.value(Double.nan)
        }
        check(expected: "inf") { stream in
            stream.value(Double.infinity)
        }
        check(expected: "-inf") { stream in
            var infinity = Double.infinity
            infinity.negate()
            stream.value(infinity)
        }
        check(expected: "-0.0") { stream in
            var zero = Double.zero
            zero.negate()
            stream.value(zero)
        }
    }

    func testSpecialFloatValue() {
        check(expected: "nan") { stream in
            stream.value(Float.nan)
        }
        check(expected: "inf") { stream in
            stream.value(Float.infinity)
        }
        check(expected: "-inf") { stream in
            var infinity = Float.infinity
            infinity.negate()
            stream.value(infinity)
        }
        check(expected: "-0.0") { stream in
            var zero = Float.zero
            zero.negate()
            stream.value(zero)
        }
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
            stream.value(false)
            stream.endArray()
        }
        XCTAssertEqual(json, "[false]")
    }

    func testArray2() {
        let json = write { stream in
            stream.beginArray()
            stream.value(false)
            stream.value(true)
            stream.endArray()
        }
        XCTAssertEqual(json, "[false,true]")
    }

    func testArray3() {
        let json = write { stream in
            stream.beginArray()
            stream.value(false)
            stream.value(123458)
            stream.value("\"123458\"")
            stream.value("君の日本語は上手です")
            stream.endArray()
        }
        XCTAssertEqual(json, #"[false,123458,"\"123458\"","君の日本語は上手です"]"#)
    }

    func testEmptyArrayClosure() {
        let json = write { stream in
            stream.array { _ in }
        }
        XCTAssertEqual(json, "[]")
    }

    func testArrayClosure() {
        let json = write { stream in
            stream.array { target in
                target.value(false)
            }
        }
        XCTAssertEqual(json, "[false]")
    }

    func testArrayClosure2() {
        let json = write { stream in
            stream.array { target in
                target.value(false)
                target.value(true)
            }
        }
        XCTAssertEqual(json, "[false,true]")
    }

    func testArrayClosure3() {
        let json = write { stream in
            stream.array { target in
                target.value(false)
                target.value(123458)
                target.value("\"123458\"")
                target.value("君の日本語は上手です")
            }
        }
//        XCTAssertEqual(json, "[false,123458,\"\\\"123458\\\"\",\"君の日本語は上手です\"]")
        XCTAssertEqual(json, #"[false,123458,"\"123458\"","君の日本語は上手です"]"#)
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
            stream.keyed("bool", value: true)
            stream.endObject()
        }
        XCTAssertEqual(json, "{\"bool\":true}")
    }

    func testObject2() {
        let json = write { stream in
            stream.beginObject()
            // NOTE: JSONStream write keys as-is, no uniqueness check.
            stream.keyed("bool", value: true)
            stream.keyed("bool", value: false)
            stream.endObject()
        }
        XCTAssertEqual(json, "{\"bool\":true,\"bool\":false}")
    }

    func testObject3() {
        let json = write { stream in
            stream.beginObject()
            stream.keyed("bool", value: true)
            stream.keyed("foo", value: "bar")
            stream.keyed("int", value: 9393)
            stream.keyed("jp", value: "君の日本語は上手です")
            stream.endObject()
        }
        XCTAssertEqual(json,
            #"{"bool":true,"foo":"bar","int":9393,"jp":"君の日本語は上手です"}"#)
    }

    func testEmptyObjectClosure() {
        let json = write { stream in
            stream.object { _ in }
        }
        XCTAssertEqual(json, "{}")
    }

    func testObjectClosure() {
        let json = write { stream in
            stream.object { target in
                target.keyed("bool", value: true)
            }
        }
        XCTAssertEqual(json, "{\"bool\":true}")
    }

    func testObjectClosure2() {
        let json = write { stream in
            stream.object { target in
                // NOTE: JSONStream write keys as-is, no uniqueness check.
                target.keyed("bool", value: true)
                target.keyed("bool", value: false)
            }
        }
        XCTAssertEqual(json, "{\"bool\":true,\"bool\":false}")
    }

    func testObjectClosure3() {
        let json = write { stream in
            stream.object { target in
                target.keyed("bool", value: true)
                target.keyed("foo", value: "bar")
                target.keyed("int", value: 9393)
                target.keyed("jp", value: "君の日本語は上手です")
            }
        }
        XCTAssertEqual(json,
            #"{"bool":true,"foo":"bar","int":9393,"jp":"君の日本語は上手です"}"#)
    }

    func testArrayInArray() {
        let json = write { stream in
            stream.beginArray()
            stream.value("array")
            stream.beginArray()
            stream.value(true)
            stream.value(false)
            stream.endArray()
            stream.value("array2")
            stream.endArray()
        }
        XCTAssertEqual(json, #"["array",[true,false],"array2"]"#)
    }

    func testArrayInObject() {
        let json = write { stream in
            stream.beginObject()
            stream.key("array")
            stream.beginArray()
            stream.value(true)
            stream.value(false)
            stream.endArray()
            stream.endObject()
        }
        XCTAssertEqual(json, #"{"array":[true,false]}"#)
    }

    func testArraysInObject() {
        let json = write { stream in
            stream.beginObject()
            stream.key("array")
            stream.beginArray()
            stream.value(true)
            stream.value(false)
            stream.endArray()

            stream.key("array2")
            stream.beginArray()
            stream.endArray()

            stream.keyed("100", value: 200)
            stream.endObject()
        }
        XCTAssertEqual(json, #"{"array":[true,false],"array2":[],"100":200}"#)
    }

    func testObjectInObject() {
        let json = write { stream in
            stream.beginObject()
            stream.key("object")
            stream.beginObject()
            stream.keyed("bool", value: true)
            stream.keyed("int", value: 100)
            stream.endObject()
            stream.endObject()
        }
        XCTAssertEqual(json, #"{"object":{"bool":true,"int":100}}"#)
    }

    func testObjectInArray() {
        let json = write { stream in
            stream.beginArray()
            stream.beginObject()
            stream.keyed("bool", value: true)
            stream.keyed("int", value: 100)
            stream.endObject()
            stream.endArray()
        }
        XCTAssertEqual(json, #"[{"bool":true,"int":100}]"#)
    }

    func testObjectsInArray() {
        let json = write { stream in
            stream.beginArray()
            stream.beginObject()
            stream.keyed("bool", value: true)
            stream.keyed("int", value: 100)
            stream.endObject()

            stream.beginObject()
            stream.keyed("bool", value: false)
            stream.keyed("int", value: 200)
            stream.endObject()

            stream.beginObject()
            stream.endObject()

            stream.value(999)
            stream.endArray()
        }
        XCTAssertEqual(json, #"[{"bool":true,"int":100},{"bool":false,"int":200},{},999]"#)
    }

    func testEncodableSingleValue() {
        let string = write { stream in
            _ = stream.encodable("Foobar")
        }
        XCTAssertEqual(string, "\"Foobar\"")
        let int = write { stream in
            _ = stream.encodable(887 as Int)
        }
        XCTAssertEqual(int, "887")
        let int32 = write { stream in
            _ = stream.encodable(-2147483648 as Int32) // Int32.min
        }
        XCTAssertEqual(int32, "-2147483648")
        let int64 = write { stream in
            _ = stream.encodable(2147483648 as Int64) // Int32.max + 1
        }
        XCTAssertEqual(int64, "2147483648")
        let uint = write { stream in
            _ = stream.encodable(44334 as UInt)
        }
        XCTAssertEqual(uint, "44334")
        let uint32 = write { stream in
            _ = stream.encodable(UInt32.max)
        }
        XCTAssertEqual(uint32, "4294967295")
        // FIXME: Unstable double encoding
        // let double = write { stream in
        //     _ = stream.encodable(Double.pi)
        // }
        // XCTAssertEqual(double, "3.141592653589793")
        // FIXME: Unstable float encoding
        // let float = write { stream in
        //      _ = stream.encodable(Float.pi)
        // }
        // XCTAssertEqual(float, "3.1415925")
        let truly = write { stream in
            _ = stream.encodable(true)
        }
        XCTAssertEqual(truly, "true")
        let falsely = write { stream in
            _ = stream.encodable(false)
        }
        XCTAssertEqual(falsely, "false")
    }

    func testEncodableEmptyArray() {
        let json = write { stream in
            _ = stream.encodable([] as [String])
        }
        XCTAssertEqual(json, "[]")
    }

    func testEncodableArray() {
        let json = write { stream in
            _ = stream.encodable([false])
        }
        XCTAssertEqual(json, "[false]")
    }

    func testEncodableArray2() {
        let json = write { stream in
            _ = stream.encodable([false, true])
        }
        XCTAssertEqual(json, "[false,true]")
    }

    func testEncodableArray3() {
        let json = write { stream in
            _ = stream.encodable([
                "false",
                "123458.",
                "\"123458\"",
                "君の日本語は上手です"
            ])
        }
        XCTAssertEqual(json, #"["false","123458.","\"123458\"","君の日本語は上手です"]"#)
    }
}
