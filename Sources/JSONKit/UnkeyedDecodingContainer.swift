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

import Foundation

#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct _UnkeyedDecodingContainer: UnkeyedDecodingContainer, JSONContainer {
    private var context: _Decoder.Context
    private var _count: Int
    private var _index: Int = 0
    private(set) var codingPath: [CodingKey]
    let ref: JSONArray
    private(set) var value: JSONValue

    init(_ context: _Decoder.Context, _ value: JSONValue) {
        self.context = context
        codingPath = context.codingPath
        (ref, _count, self.value) = _decodeArray(value)
    }

    @inlinable
    var count: Int? {
        _count
    }

    @inlinable
    var isAtEnd: Bool {
        _index >= _count
    }

    @inlinable
    var currentIndex: Int {
        _index
    }

    @inlinable
    var storage: JSONStorage {
        context.storage
    }

    @inline(__always)
    private mutating func move() {
        _index += 1
        guard _index < _count else {
            return
        }
        with(ref) { r in
            _ = json_array_get(r, _index, &value)
        }
    }

    @_transparent
    private func checkIndex() throws {
        if _index >= _count {
            throw keyNotFound(AnyCodingKey.unkeyed(_index), codingPath, "Out of index")
        }
    }

    mutating func decodeNil() throws -> Bool {
        defer {
            move()
        }
        try checkIndex()
        return SimdDecoder(self).isNull
    }

    mutating func decode(_ type: Bool.Type) throws -> Bool {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeBool(codingPath)
    }

    mutating func decode(_ type: String.Type) throws -> String {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeString(codingPath)
    }

    mutating func decode(_ type: Double.Type) throws -> Double {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeDouble(codingPath)
    }

    mutating func decode(_ type: Float.Type) throws -> Float {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeFloat(codingPath)
    }

    mutating func decode(_ type: Int.Type) throws -> Int {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeInt(codingPath)
    }

    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeInt8(codingPath)
    }

    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeInt16(codingPath)
    }

    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeInt32(codingPath)
    }

    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeInt64(codingPath)
    }

    mutating func decode(_ type: UInt.Type) throws -> UInt {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeUInt(codingPath)
    }

    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeUInt8(codingPath)
    }

    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeUInt16(codingPath)
    }

    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeUInt32(codingPath)
    }

    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeUInt64(codingPath)
    }

    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        defer {
            move()
        }
        try checkIndex()
        return try context.makeDecoder(value).decode(type)
    }

    mutating func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalBool(codingPath)
    }

    mutating func decodeIfPresent(_ type: String.Type) throws -> String? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalString(codingPath)
    }

    mutating func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalDouble(codingPath)
    }

    mutating func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalFloat(codingPath)
    }

    mutating func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalInt(codingPath)
    }

    mutating func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalInt8(codingPath)
    }

    mutating func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalInt16(codingPath)
    }

    mutating func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalInt32(codingPath)
    }

    mutating func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalInt64(codingPath)
    }

    mutating func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalUInt(codingPath)
    }

    mutating func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalUInt8(codingPath)
    }

    mutating func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalUInt16(codingPath)
    }

    mutating func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalUInt32(codingPath)
    }

    mutating func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        defer {
            move()
        }
        try checkIndex()
        return try SimdDecoder(self).decodeOptionalUInt64(codingPath)
    }

    mutating func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T: Decodable {
        defer {
            move()
        }
        try checkIndex()
        if SimdDecoder(self).isNull {
            return nil
        }
        return try context.makeDecoder(value).decode(type)
    }

    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws ->
        KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        defer {
            move()
        }
        try checkIndex()
        let container = try context.makeDecoder(value).container(keyedBy: type)
        return KeyedDecodingContainer(container)
    }

    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        defer {
            move()
        }
        try checkIndex()
        return try context.makeDecoder(value).unkeyedContainer()
    }

    mutating func superDecoder() throws -> Decoder {
        defer {
            move()
        }
        try checkIndex()
        return context.makeDecoder(value)
    }
}

// array, size, first
@_transparent
private func _decodeArray(_ value: JSONValue) -> (JSONArray, Int, JSONValue) {
    var array = JSONArray()
    var root = JSONValue()
    var size = 0
    with(value) { ref in
        _ = json_get_array(ref, &array)
        size = json_array_get_count(&array)
        if size > 0 {
            _ = json_array_get(&array, 0, &root)
        }
    }
    return (array, size, root)
}
