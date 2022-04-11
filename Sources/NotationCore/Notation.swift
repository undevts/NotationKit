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

public protocol Notation {
    var isExists: Bool { get }

    var boolValue: Bool? { get }
    var bool: Bool { get }
    var stringValue: String? { get }
    var string: String { get }
    var doubleValue: Double? { get }
    var double: Double { get }
    var floatValue: Float? { get }
    var float: Float { get }
    var intValue: Int? { get }
    var int: Int { get }
    var int32Value: Int32? { get }
    var int32: Int32 { get }
    var int64Value: Int64? { get }
    var int64: Int64 { get }
    var uintValue: UInt? { get }
    var uint: UInt { get }
    var uint32Value: UInt32? { get }
    var uint32: UInt32 { get }
    var uint64Value: UInt64? { get }
    var uint64: UInt64 { get }

    var listValue: [Notation]? { get }
    var list: [Notation] { get }
    var mapValue: [String: Notation]? { get }
    var map: [String: Notation] { get }

    func item(untyped index: Int) -> Notation
    func item(untyped key: String) -> Notation

    subscript(untyped index: Int) -> Notation { get }
    subscript(untyped key: String) -> Notation { get }
}

public protocol TypeNotation: Notation {
    associatedtype Typed: Notation = Self

    var arrayValue: [Typed]? { get }
    var array: [Typed] { get }
    var dictionaryValue: [String: Typed]? { get }
    var dictionary: [String: Typed] { get }

    func item(at index: Int) -> Typed
    func item(key: String) -> Typed

    subscript(index: Int) -> Typed { get }
    subscript(key: String) -> Typed { get }
}

extension Notation {
    @inlinable
    public var boolValue: Bool? {
        isExists ? bool : nil
    }

    @inlinable
    public var stringValue: String? {
        isExists ? string : nil
    }

    @inlinable
    public var doubleValue: Double? {
        isExists ? double : nil
    }

    @inlinable
    public var floatValue: Float? {
        isExists ? float : nil
    }

    @inlinable
    public var intValue: Int? {
        isExists ? int : nil
    }

    @inlinable
    public var int32Value: Int32? {
        isExists ? int32 : nil
    }

    @inlinable
    public var int64Value: Int64? {
        isExists ? int64 : nil
    }

    @inlinable
    public var uintValue: UInt? {
        isExists ? uint : nil
    }

    @inlinable
    public var uint32Value: UInt32? {
        isExists ? uint32 : nil
    }

    @inlinable
    public var uint64Value: UInt64? {
        isExists ? uint64 : nil
    }

    @inlinable
    public var listValue: [Notation]? {
        isExists ? list : nil
    }

    @inlinable
    public var mapValue: [String: Notation]? {
        isExists ? map : nil
    }
}

extension TypeNotation {
    @inlinable
    public var arrayValue: [Typed]? {
        isExists ? array : nil
    }

    @inlinable
    public var dictionaryValue: [String: Typed]? {
        isExists ? dictionary : nil
    }

    @inlinable
    public var list: [Notation] {
        array
    }

    @inlinable
    public var map: [String: Notation] {
        dictionary
    }

    @inlinable
    public func item(untyped index: Int) -> Notation {
        item(at: index)
    }

    @inlinable
    public func item(untyped key: String) -> Notation {
        item(key: key)
    }

    @inlinable
    public subscript(untyped index: Int) -> Notation {
        self[index]
    }

    @inlinable
    public subscript(untyped key: String) -> Notation {
        self[key]
    }
}
