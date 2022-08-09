import Foundation

#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct _UnkeyedDecodingContainer: UnkeyedDecodingContainer, JSONContainer {
    private var context: _Decoder.Context
    private var _count: Int
    private var _index: Int = 0
    private let ref: json_array
    private var current: json_array_iterator
    private(set) var codingPath: [CodingKey]
    private(set) var value: json_value

    init(_ context: _Decoder.Context, _ value: json_value) {
        var array = json_array()
        var current = json_array_iterator()
        var v = json_value()
        let count = _decodeArray(value, array: &array)
        nk_json_array_get_begin_iterator(&array, &current)
        if count > 0 {
            nk_json_array_iterator_get_value(&current, &v)
        }

        self.context = context
        _count = count
        codingPath = context.codingPath
        ref = array
        self.current = current
        self.value = v
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
        nk_json_array_iterator_move_next(&current)
        nk_json_array_iterator_get_value(&current, &value)
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
private func _decodeArray(_ value: json_value, array: inout json_array) -> Int {
    var size = 0
    with(value) { ref in
        _ = nk_json_get_array(ref, &array)
        size = nk_json_array_get_count(&array)
    }
    return size
}

@_transparent
func with<Result>(_ value: json_array_iterator, _ method: (JSONArrayIteratorRef) throws -> Result) rethrows -> Result {
    try withUnsafePointer(to: value) { (pointer: UnsafePointer<json_array_iterator>) -> Result in
        try method(UnsafeMutablePointer(mutating: pointer))
    }
}
