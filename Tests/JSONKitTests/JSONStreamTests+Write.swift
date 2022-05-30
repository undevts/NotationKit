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
@testable import JSONKit

extension JSONStreamTests {
    func testWriteInt() {
        check(expected: "\(Int.min)") { stream in
            stream.value(Int.min)
        } encodable: { stream in
            _ = stream.encodable(Int.min)
        }
        check(expected: "\(Int.max)") { stream in
            stream.value(Int.max)
        } encodable: { stream in
            _ = stream.encodable(Int.max)
        }
        check(expected: "") { stream in
            stream.optional(nil as Int?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as Int?)
        } encodable: { stream in
            _ = stream.encodable(nil as Int?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Int?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Int?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as Int?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Int?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Int?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as Int?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as Int?)
            stream.endObject()
        }
        check(expected: "[\(Int.min)]") { stream in
            stream.beginArray()
            stream.optional(Int.min)
            stream.endArray()
        }
        check(expected: "[\(Int.max)]") { stream in
            stream.beginArray()
            stream.optional(Int.max)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as Int?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as Int?)
            stream.endArray()
        }
    }

    func testWriteInt32() {
        check(expected: "\(Int32.min)") { stream in
            stream.value(Int32.min)
        } encodable: { stream in
            _ = stream.encodable(Int32.min)
        }
        check(expected: "\(Int32.max)") { stream in
            stream.value(Int32.max)
        } encodable: { stream in
            _ = stream.encodable(Int32.max)
        }
        check(expected: "") { stream in
            stream.optional(nil as Int32?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as Int32?)
        } encodable: { stream in
            _ = stream.encodable(nil as Int32?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Int32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Int32?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as Int32?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Int32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Int32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as Int32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as Int32?)
            stream.endObject()
        }
        check(expected: "[\(Int32.min)]") { stream in
            stream.beginArray()
            stream.optional(Int32.min)
            stream.endArray()
        }
        check(expected: "[\(Int32.max)]") { stream in
            stream.beginArray()
            stream.optional(Int32.max)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as Int32?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as Int32?)
            stream.endArray()
        }
    }

    func testWriteInt64() {
        check(expected: "\(Int64.min)") { stream in
            stream.value(Int64.min)
        } encodable: { stream in
            _ = stream.encodable(Int64.min)
        }
        check(expected: "\(Int64.max)") { stream in
            stream.value(Int64.max)
        } encodable: { stream in
            _ = stream.encodable(Int64.max)
        }
        check(expected: "") { stream in
            stream.optional(nil as Int64?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as Int64?)
        } encodable: { stream in
            _ = stream.encodable(nil as Int64?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Int64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Int64?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as Int64?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Int64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Int64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as Int64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as Int64?)
            stream.endObject()
        }
        check(expected: "[\(Int64.min)]") { stream in
            stream.beginArray()
            stream.optional(Int64.min)
            stream.endArray()
        }
        check(expected: "[\(Int64.max)]") { stream in
            stream.beginArray()
            stream.optional(Int64.max)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as Int64?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as Int64?)
            stream.endArray()
        }
    }

    func testWriteUInt() {
        check(expected: "\(UInt.min)") { stream in
            stream.value(UInt.min)
        } encodable: { stream in
            _ = stream.encodable(UInt.min)
        }
        check(expected: "\(UInt.max)") { stream in
            stream.value(UInt.max)
        } encodable: { stream in
            _ = stream.encodable(UInt.max)
        }
        check(expected: "") { stream in
            stream.optional(nil as UInt?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as UInt?)
        } encodable: { stream in
            _ = stream.encodable(nil as UInt?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as UInt?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as UInt?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as UInt?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as UInt?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as UInt?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as UInt?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as UInt?)
            stream.endObject()
        }
        check(expected: "[\(UInt.min)]") { stream in
            stream.beginArray()
            stream.optional(UInt.min)
            stream.endArray()
        }
        check(expected: "[\(UInt.max)]") { stream in
            stream.beginArray()
            stream.optional(UInt.max)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as UInt?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as UInt?)
            stream.endArray()
        }
    }

    func testWriteUInt32() {
        check(expected: "\(UInt32.min)") { stream in
            stream.value(UInt32.min)
        } encodable: { stream in
            _ = stream.encodable(UInt32.min)
        }
        check(expected: "\(UInt32.max)") { stream in
            stream.value(UInt32.max)
        } encodable: { stream in
            _ = stream.encodable(UInt32.max)
        }
        check(expected: "") { stream in
            stream.optional(nil as UInt32?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as UInt32?)
        } encodable: { stream in
            _ = stream.encodable(nil as UInt32?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as UInt32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as UInt32?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as UInt32?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as UInt32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as UInt32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as UInt32?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as UInt32?)
            stream.endObject()
        }
        check(expected: "[\(UInt32.min)]") { stream in
            stream.beginArray()
            stream.optional(UInt32.min)
            stream.endArray()
        }
        check(expected: "[\(UInt32.max)]") { stream in
            stream.beginArray()
            stream.optional(UInt32.max)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as UInt32?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as UInt32?)
            stream.endArray()
        }
    }

    func testWriteUInt64() {
        check(expected: "\(UInt64.min)") { stream in
            stream.value(UInt64.min)
        } encodable: { stream in
            _ = stream.encodable(UInt64.min)
        }
        check(expected: "\(UInt64.max)") { stream in
            stream.value(UInt64.max)
        } encodable: { stream in
            _ = stream.encodable(UInt64.max)
        }
        check(expected: "") { stream in
            stream.optional(nil as UInt64?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as UInt64?)
        } encodable: { stream in
            _ = stream.encodable(nil as UInt64?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as UInt64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as UInt64?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as UInt64?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as UInt64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as UInt64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as UInt64?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as UInt64?)
            stream.endObject()
        }
        check(expected: "[\(UInt64.min)]") { stream in
            stream.beginArray()
            stream.optional(UInt64.min)
            stream.endArray()
        }
        check(expected: "[\(UInt64.max)]") { stream in
            stream.beginArray()
            stream.optional(UInt64.max)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as UInt64?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as UInt64?)
            stream.endArray()
        }
    }

    func testWriteDouble() {
        check(expected: "\(Double.zero)") { stream in
            stream.value(Double.zero)
        }
        check(expected: "\(Double.pi)") { stream in
            stream.value(Double.pi)
        }
        check(expected: "") { stream in
            stream.optional(nil as Double?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as Double?)
        } encodable: { stream in
            _ = stream.encodable(nil as Double?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Double?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Double?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as Double?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Double?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Double?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as Double?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as Double?)
            stream.endObject()
        }
        check(expected: "[\(Double.zero)]") { stream in
            stream.beginArray()
            stream.value(Double.zero)
            stream.endArray()
        }
        check(expected: "[\(Double.pi)]") { stream in
            stream.beginArray()
            stream.value(Double.pi)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as Double?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as Double?)
            stream.endArray()
        }
    }

    func testWriteFloat() {
        check(expected: "\(Float.zero)") { stream in
            stream.value(Float.zero)
        }
        check(expected: "\(Float.pi)") { stream in
            stream.value(Float.pi)
        }
        check(expected: "") { stream in
            stream.optional(nil as Float?)
        }
        check(expected: "null", null: true) { stream in
            stream.optional(nil as Float?)
        } encodable: { stream in
            _ = stream.encodable(nil as Float?)
        }
        check(expected: #"{}"#) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Float?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed("v", optional: nil as Float?)
            stream.endObject()
        } encodable: { stream in
            stream.beginObject()
            _ = stream.encodable(nil as Float?, key: "v")
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Float?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.key("v")
            stream.optional(nil as Float?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#) { stream in
            stream.beginObject()
            stream.key(AnyCodingKey.keyed("v"))
            stream.optional(nil as Float?)
            stream.endObject()
        }
        check(expected: #"{"v":null}"#, null: true) { stream in
            stream.beginObject()
            stream.keyed(AnyCodingKey.keyed("v"), optional: nil as Float?)
            stream.endObject()
        }
        check(expected: "[\(Float.zero)]") { stream in
            stream.beginArray()
            stream.value(Float.zero)
            stream.endArray()
        }
        check(expected: "[\(Float.pi)]") { stream in
            stream.beginArray()
            stream.value(Float.pi)
            stream.endArray()
        }
        check(expected: "[]") { stream in
            stream.beginArray()
            stream.optional(nil as Float?)
            stream.endArray()
        }
        check(expected: "[null]", null: true) { stream in
            stream.beginArray()
            stream.optional(nil as Float?)
            stream.endArray()
        }
    }

}
