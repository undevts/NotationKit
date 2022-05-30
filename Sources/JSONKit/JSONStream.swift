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

public struct JSONFormatting: OptionSet {
    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public static let writeNull =  JSONFormatting(rawValue: 1 << 0)
}

#if DEBUG
private func writeLog(_ message: String) {
    print(message)
}

private func writeLog(_ message: String, condition: () -> Bool) {
    if condition() {
        print(message)
    }
}
#else
@_transparent
private func writeLog(_ message: String) {
    // Do nothing.
}

@_transparent
private func writeLog(_ message: String, condition: () -> Bool) {
    // Do nothing.
}
#endif

@frozen
@usableFromInline
enum Symbol: UInt8 {
    /// ,
    case comma = 0x2C
    /// :
    case colon = 0x3A
    /// {
    case leftBracket = 0x7B
    /// }
    case rightBracket = 0x7D
    /// [
    case leftSquare = 0x5B
    /// ]
    case rightSquare = 0x5D
    /// "
    case quotation = 0x22
}

public struct JSONStream {
    @usableFromInline
    var data: Data
    @usableFromInline
    var stack: [Level]
    @usableFromInline
    var hasRoot: Bool
    public let formatting: JSONFormatting

    public init(formatting: JSONFormatting = []) {
        data = Data()
        stack = []
        hasRoot = false
        self.formatting = formatting
    }

    @inlinable
    public func finalize() -> Data {
        data
    }

    @_transparent
    @usableFromInline
    var useNull: Bool {
        formatting.contains(.writeNull)
    }

    @usableFromInline
    var inObjectValue: Bool {
        let level = last
        return !level.inArray && (level.count % 2 == 1)
    }

    @_transparent
    var last: Level {
        stack.last ?? Level(count: 0, inArray: false)
    }

    @_transparent
    mutating func popLast() -> Level {
        stack.popLast() ?? Level(count: 0, inArray: false)
    }

//    @_transparent
//    @usableFromInline
//    mutating func put(byte value: UInt8) {
//        data.append(value)
//    }

    @_transparent
    @usableFromInline
    mutating func put(symbol: Symbol) {
        data.append(symbol.rawValue)
    }

    @_transparent
    @usableFromInline
    mutating func put(bytes value: [UInt8]) {
        data.append(contentsOf: value)
    }

    @_transparent
    @usableFromInline
    mutating func put(bytes value: UnsafePointer<UInt8>, count: Int) {
        if count < 1 {
            return
        }
        data.reserveCapacity(data.count + count)
        // TODO: append(_:count:) is an ObjC function?
        data.append(value, count: count)
    }

    @_transparent
    @usableFromInline
    mutating func put(bytes value: UnsafePointer<Int8>, count: Int) {
        put(bytes: UnsafeRawPointer(value).assumingMemoryBound(to: UInt8.self), count: count)
    }

    @inlinable
    @inline(__always)
    mutating func put(unsafe value: String) {
        let success = value.utf8.withContiguousStorageIfAvailable { (pointer: UnsafeBufferPointer<UInt8>) -> Bool in
            if pointer.count < 1 {
                return true
            }
            guard let base = pointer.baseAddress else {
                return false
            }
            put(bytes: base, count: pointer.count)
            return true
        }
        if _fastPath(success == true) {
            return
        }
        value.withCString { pointer in
            put(bytes: pointer, count: strlen(pointer))
        }
    }

    @usableFromInline
    mutating func prefix(type: JSONType) {
        if _fastPath(!stack.isEmpty) { // this value is not at root
            let last: Level = popLast()
            if last.count > 0 {
                if last.inArray {
                    // add comma if it is not the first element in array
                    put(symbol: .comma)
                } else {
                    // in object
                    put(symbol: (last.count % 2 == 0) ? .comma : .colon)
                }
            }
            if !last.inArray && (last.count % 2 == 0) {
                // if it's in object, then even number should be a name
                assert(type == .string)
            }
            stack.append(Level(count: last.count + 1, inArray: last.inArray))
        } else {
            assert(!hasRoot)
            hasRoot = true
        }
    }

    @usableFromInline
    mutating func suffix() {
        if _slowPath(stack.isEmpty) {

        }
    }

    @usableFromInline
    struct Level {
        let count: Int
        let inArray: Bool
    }
}

extension JSONStream {
    @inlinable
    @inline(__always)
    mutating func _writeNull() {
        data.reserveCapacity(4)
        put(bytes: [0x6e, 0x75, 0x6c, 0x6c]) // n u l l
    }

    @inlinable
    @inline(__always)
    mutating func _writeBool(_ value: Bool) {
        if value {
            data.reserveCapacity(4)
            put(bytes: [0x74, 0x72, 0x75, 0x65]) // t r u e
        } else {
            data.reserveCapacity(5)
            put(bytes: [0x66, 0x61, 0x6c, 0x73, 0x65]) // f a l s e
        }
    }

    @inlinable
    @inline(__always)
    mutating func _writeInt32(_ value: Int32) {
        var buffer = json_number_32()
        let size = json_write_int32(&buffer, value)
        buffer.write(to: &data, size: size)
    }

    @inlinable
    @inline(__always)
    mutating func _writeUInt32(_ value: UInt32) {
        var buffer = json_number_32()
        let size = json_write_uint32(&buffer, value)
        buffer.write(to: &data, size: size)
    }

    @inlinable
    @inline(__always)
    mutating func _writeInt64(_ value: Int64) {
        var buffer = json_number_64()
        let size = json_write_int64(&buffer, value)
        buffer.write(to: &data, size: size)
    }

    @inlinable
    @inline(__always)
    mutating func _writeUInt64(_ value: UInt64) {
        var buffer = json_number_64()
        let size = json_write_uint64(&buffer, value)
        buffer.write(to: &data, size: size)
    }

    @inlinable
    @inline(__always)
    mutating func _writeDouble(_ value: Double) {
        put(unsafe: String(value))
    }

    @inlinable
    @inline(__always)
    mutating func _writeFloat(_ value: Float) {
        put(unsafe: String(value))
    }

    @inlinable
    @inline(__always)
    mutating func _writeString(_ value: String) {
        if value.isEmpty {
            put(symbol: .quotation)
            put(symbol: .quotation)
            return
        }
        let success = value.utf8.withContiguousStorageIfAvailable { (pointer: UnsafeBufferPointer<UInt8>) -> Bool in
            guard let base = pointer.baseAddress else {
                return false
            }
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 2 + value.utf8.count * 6) // "\uxxxx...")
            let size = json_write_string(buffer, base, pointer.count)
            put(bytes: buffer, count: size)
            buffer.deallocate()
            return true
        }
        if _fastPath(success == true) {
            return
        }
        value.withCString { pointer in
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 2 + value.utf8.count * 6) // "\uxxxx...")
            let size = json_write_string(buffer, pointer, strlen(pointer))
            put(bytes: buffer, count: size)
            buffer.deallocate()
        }
    }
    
    @inline(__always)
    mutating func _beginObject() {
        put(symbol: .leftBracket)
    }
    
    @inline(__always)
    mutating func _endObject() {
        put(symbol: .rightBracket)
    }
    
    @inline(__always)
    mutating func _beginArray() {
        put(symbol: .leftSquare)
    }
    
    @inline(__always)
    mutating func _endArray() {
        put(symbol: .rightSquare)
    }
}

extension JSONStream {
    @inlinable
    public mutating func null() {
        prefix(type: .null)
        _writeNull()
        suffix()
    }

    @inlinable
    public mutating func value(_ value: Bool) {
        prefix(type: .null)
        _writeBool(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: Int) {
#if arch(x86_64) || arch(arm64)
        self.value(Int64(value))
#else
        self.value(Int32(value))
#endif
    }

    @inlinable
    public mutating func value(_ value: UInt) {
#if arch(x86_64) || arch(arm64)
        self.value(UInt64(value))
#else
        self.value(UInt32(value))
#endif
    }

    @inlinable
    public mutating func value(_ value: Int32) {
        prefix(type: .null)
        _writeInt32(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: UInt32) {
        prefix(type: .null)
        _writeUInt32(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: Int64) {
        prefix(type: .null)
        _writeInt64(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: UInt64) {
        prefix(type: .null)
        _writeUInt64(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: Double) {
        prefix(type: .null)
        _writeDouble(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: Float) {
        prefix(type: .null)
        _writeFloat(value)
        suffix()
    }

    @inlinable
    public mutating func value(_ value: String) {
        prefix(type: .string)
        _writeString(value)
        suffix()
    }

    @inlinable
    public mutating func key(_ value: String) {
        // Same as `string`
        prefix(type: .string)
        _writeString(value)
        suffix()
    }

    @inlinable
    public mutating func key<K>(_ value: K) where K: CodingKey {
        // Same as `string`
        prefix(type: .string)
        _writeString(value.stringValue)
        suffix()
    }
}

// MARK: JSON x Encodable

extension JSONStream {
    @inlinable
    public mutating func encodable<T>(_ value: T, encoder: JSONEncoder? = nil) -> Result<Void, Error>
        where T: Encodable {
        let encoder = encoder ?? JSONEncoder()
        let data: Data
        do {
            data = try encoder.encode(value)
        } catch {
            return .failure(error)
        }
        switch data.first {
        case Symbol.leftSquare.rawValue:
            prefix(type: .array)
        case Symbol.leftBracket.rawValue:
            prefix(type: .object)
        case .none:
            fallthrough
        default:
            prefix(type: .null)
        }
        self.data.append(data)
        suffix()
        return .success(())
    }

    @inlinable
    public mutating func encodable<T>(_ value: T, key: String, encoder: JSONEncoder? = nil) -> Result<Void, Error>
        where T: Encodable {
        self.key(key)
        return encodable(value, encoder: encoder)
    }
}

extension JSONStream {
    public mutating func beginObject() {
        prefix(type: .object)
        stack.append(Level(count: 0, inArray: false))
        _beginObject()
    }

    public mutating func endObject() {
        assert(!stack.isEmpty)
        assert(!last.inArray, "Currently inside an Array, not Object.")
        assert((last.count % 2) == 0, "Object has a Key without a Value.")
        _ = popLast()
        _endObject()
        suffix()
    }

    public mutating func object(_ body: (inout JSONStream) -> Void) {
        beginObject()
        body(&self)
        endObject()
    }

    public mutating func beginArray() {
        prefix(type: .object)
        stack.append(Level(count: 0, inArray: true))
        _beginArray()
    }

    public mutating func endArray() {
        assert(!stack.isEmpty)
        assert(last.inArray, "Currently inside an Object, not Array.")
        _ = popLast()
        _endArray()
        suffix()
    }

    public mutating func array(_ body: (inout JSONStream) -> Void) {
        beginArray()
        body(&self)
        endArray()
    }
}

extension JSONStream {
    @inlinable
    @available(*, unavailable, renamed: "null(_:)")
    public mutating func writeNull() {
        null()
    }

    @inlinable
    @available(*, unavailable, renamed: "key(_:)")
    public mutating func write(key value: String) {
        self.key(value)
    }

    @available(*, unavailable, renamed: "object(_:)")
    public mutating func writeObject(_ body: (inout JSONStream) -> Void) {
        object(body)
    }

    @available(*, unavailable, renamed: "array(_:)")
    public mutating func writeArray(_ body: (inout JSONStream) -> Void) {
        array(body)
    }

    @inlinable
    @available(*, unavailable, message: "Please use encodable(_:encoder:)")
    public mutating func write<T>(encodable value: T, encoder: JSONEncoder? = nil) throws where T: Encodable {
        try encodable(value, encoder: encoder).get()
    }

    @inlinable
    @available(*, unavailable, message: "Please use encodable(_:key:encoder:)")
    public mutating func write<T>(encodable value: T, key: String, encoder: JSONEncoder? = nil) throws
        where T: Encodable {
        try encodable(value, key: key, encoder: encoder).get()
    }
}

extension json_number_32 {
    @inlinable
    @inline(__always)
    mutating func write(to data: inout Data, size: Int) {
        data.reserveCapacity(size)
        withUnsafePointer(to: &self) { (pointer: UnsafePointer<json_number_32>) -> Void in
            let p = UnsafeRawPointer(pointer).assumingMemoryBound(to: UInt8.self)
            data.append(p, count: size)
        }
    }
}

extension json_number_64 {
    @inlinable
    @inline(__always)
    mutating func write(to data: inout Data, size: Int) {
        data.reserveCapacity(size)
        withUnsafePointer(to: &self) { (pointer: UnsafePointer<json_number_64>) -> Void in
            let p = UnsafeRawPointer(pointer).assumingMemoryBound(to: UInt8.self)
            data.append(p, count: size)
        }
    }
}
