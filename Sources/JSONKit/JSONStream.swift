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

public struct JSONStream {
    @usableFromInline
    enum State {
        case array, object, key, value
    }

    @usableFromInline
    private(set) var data = Data()
    private var states: [State] = []
    private var scope: State?
    public let formatting: JSONFormatting

    @_transparent
    var state: State? {
        states.last
    }

    @_transparent
    @usableFromInline
    var useNull: Bool {
        formatting.contains(.writeNull)
    }

    public init(formatting: JSONFormatting = []) {
        self.formatting = formatting
    }

    public func finalize() -> Data {
//        precondition(states.isEmpty || state == State.value,
//            "JSON value not closed.")
        return data
    }

    @_transparent
    private func valueCheck() {
    }

    @_transparent
    @usableFromInline
    mutating func write(byte value: UInt8) {
        data.append(value)
    }

    @_transparent
    @usableFromInline
    mutating func write(bytes value: [UInt8]) {
        data.append(contentsOf: value)
    }

    @_transparent
    @usableFromInline
    mutating func write(bytes value: UnsafePointer<UInt8>, count: Int) {
        if count < 1 {
            return
        }
        data.reserveCapacity(data.count + count)
        // TODO: append(_:count:) is an ObjC function?
        data.append(value, count: count)
    }

    @_transparent
    @usableFromInline
    mutating func write(bytes value: UnsafePointer<Int8>, count: Int) {
        write(bytes: UnsafeRawPointer(value).assumingMemoryBound(to: UInt8.self), count: count)
    }

    @inlinable
    @inline(__always)
    mutating func write(raw value: String) {
        let success = value.utf8.withContiguousStorageIfAvailable { (pointer: UnsafeBufferPointer<UInt8>) -> Bool in
            if pointer.count < 1 {
                return true
            }
            guard let base = pointer.baseAddress else {
                return false
            }
            write(bytes: base, count: pointer.count)
            return true
        }
        if success == true {
            return
        }
        value.withCString { pointer in
            write(bytes: pointer, count: strlen(pointer))
        }
    }

    @inline(__always)
    @usableFromInline
    mutating func writeComma() {
        write(byte: 0x2C) // ,
    }

    @inline(__always)
    @usableFromInline
    mutating func writeColon() {
        write(byte: 0x3A) //
    }

    @usableFromInline
    mutating func writeValue(_ value: String) {
        pushState(.value)
//        if let scope = scope {
//            switch scope {
//            case .array:
//                writeComma()
//            case .object:
//                // Commas should be written when writing keys.
//                break
//            case .value:
//#if DEBUG
//                print("Writing json values repeatedly could be problematic.")
//#else
//                break
//#endif
//            case .key:
//                fatalError("No such scope")
//            }
//        }
        write(raw: value)
    }

    @usableFromInline
    mutating func writeKey(_ value: String) {
        assert(scope == .object)
        if state == .value {
            writeComma()
        }
        write(byte: 0x22) // "
        write(raw: value)
        write(byte: 0x22) // "
    }
    

    @inline(__always)
    @usableFromInline
    mutating func pushState(_ state: State) {
        switch scope {
        case .array:
            if self.state == .value {
                writeComma()
            }
        case .object:
            if self.state == .key {
                _ = states.removeLast()
                writeColon()
            } else if state == .key && self.state != .object {
                writeComma()
            }
        case .key, .value, .none:
            break
        }
        switch state {
        case .array, .object:
            scope = state
        case .value:
            if self.state == .value {
                return
            } else if states.isEmpty {
                scope = .value // Root object is a single json value.
            }
        case .key:
            break
        }
        states.append(state)
    }

    @inline(__always)
    mutating func popState(_ state: State) {

    }

//    @inline(__always)
//    @usableFromInline
//    mutating func pushScope() {
//
//    }
//
//    @inline(__always)
//    @usableFromInline
//    mutating func popScope() {
//
//    }
}

extension JSONStream {
    // MARK: - JSON Value

    @inlinable
    public mutating func writeNull() {
        write(bytes: [0x6e, 0x75, 0x6c, 0x6c]) // n u l l
    }

    // MARK: - JSON Array

    public mutating func beginArray() {
        pushState(.array)
        write(byte: 0x5B) // [
    }

    public mutating func endArray() {
        write(byte: 0x5D) // ]
        popState(.array)
    }

    public mutating func writeArray(_ body: (inout JSONStream) -> Void) {
        beginArray()
        body(&self)
        endArray()
    }

    // MARK: - JSON Object

    @inlinable
    public mutating func write(key: String) {
        pushState(.key)
        writeKey(key)
    }

    public mutating func beginObject() {
        pushState(.object)
        write(byte: 0x7B) // {
    }

    public mutating func endObject() {
        write(byte: 0x7D) // }
        popState(.object)
    }

    public mutating func writeObject(_ body: (inout JSONStream) -> Void) {
        beginObject()
        body(&self)
        endObject()
    }

    // MARK: JSON x Encodable

    @inlinable
    public mutating func write<T>(encodable value: T, encoder: JSONEncoder? = nil) throws where T: Encodable {
        let encoder = encoder ?? JSONEncoder()
        let data = try encoder.encode(value)
        self.data.append(data)
    }

    public mutating func write<T>(encodable value: T, key: String, encoder: JSONEncoder? = nil) throws
        where T: Encodable {
        writeKey(key)
        writeComma()
        try write(encodable: value, encoder: encoder)
    }
}