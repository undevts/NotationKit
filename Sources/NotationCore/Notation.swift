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

/// A container that can hold a value, an array or a dictionary.
public protocol Notation {
    /// Returns `true` if the container has some value.
    var isExists: Bool { get }

    /// Receive a `Bool` value from the container. If the value can not express as a `Bool` value,
    /// or the value is not exists, it will return `nil`.
    var boolValue: Bool? { get }

    /// Receive a `Bool` value from the container. If the value can not express as a `Bool` value,
    /// or the value is not exists, it will return `false`.
    var bool: Bool { get }

    /// Receive a `String` value from the container. If the value can not express as a `String` value,
    /// or the value is not exists, it will return `nil`.
    var stringValue: String? { get }

    /// Receive a `String` value from the container. If the value can not express as a `String` value,
    /// or the value is not exists, it will return `""` (Empty string).
    var string: String { get }

    /// Receive a `Double` value from the container. If the value can not express as a `Double` value,
    /// or the value is not exists, it will return `nil`.
    var doubleValue: Double? { get }

    /// Receive a `Double` value from the container. If the value can not express as a `Double` value,
    /// or the value is not exists, it will return `0`.
    var double: Double { get }

    /// Receive a `Float` value from the container. If the value can not express as a `Float` value,
    /// or the value is not exists, it will return `nil`.
    var floatValue: Float? { get }

    /// Receive a `Float` value from the container. If the value can not express as a `Float` value,
    /// or the value is not exists, it will return `0`.
    var float: Float { get }

    /// Receive an `Int` value from the container. If the value can not express as an `Int` value,
    /// or the value is not exists, it will return `nil`.
    var intValue: Int? { get }

    /// Receive an `Int` value from the container. If the value can not express as an `Int` value,
    /// or the value is not exists, it will return `0`.
    var int: Int { get }

    /// Receive an `Int32` value from the container. If the value can not express as an `Int32` value,
    /// or the value is not exists, it will return `nil`.
    var int32Value: Int32? { get }

    /// Receive an `Int32` value from the container. If the value can not express as an `Int32` value,
    /// or the value is not exists, it will return `0`.
    var int32: Int32 { get }

    /// Receive an `Int64` value from the container. If the value can not express as an `Int64` value,
    /// or the value is not exists, it will return `nil`.
    var int64Value: Int64? { get }

    /// Receive an `Int64` value from the container. If the value can not express as an `Int64` value,
    /// or the value is not exists, it will return `0`.
    var int64: Int64 { get }

    /// Receive an `UInt` value from the container. If the value can not express as an `UInt` value,
    /// or the value is not exists, it will return `nil`.
    var uintValue: UInt? { get }

    /// Receive an `UInt` value from the container. If the value can not express as an `UInt` value,
    /// or the value is not exists, it will return `0`.
    var uint: UInt { get }

    /// Receive an `UInt32` value from the container. If the value can not express as an `UInt32` value,
    /// or the value is not exists, it will return `nil`.
    var uint32Value: UInt32? { get }

    /// Receive an `UInt32` value from the container. If the value can not express as an `UInt32` value,
    /// or the value is not exists, it will return `0`.
    var uint32: UInt32 { get }

    /// Receive an `UInt64` value from the container. If the value can not express as an `UInt64` value,
    /// or the value is not exists, it will return `nil`.
    var uint64Value: UInt64? { get }

    /// Receive an `UInt64` value from the container. If the value can not express as an `UInt64` value,
    /// or the value is not exists, it will return `0`.
    var uint64: UInt64 { get }

    /// Receive an array from the container. If the value can not express as an array.
    /// or the value is not exists, it will return `nil`.
    var listValue: [Notation]? { get }

    /// Receive an array from the container. If the value can not express as an array.
    /// or the value is not exists, it will return `[]` (Empty array).
    var list: [Notation] { get }

    /// Receive a dictionary from the container. If the value can not express as a dictionary,
    /// or the value is not exists, it will return `nil`.
    var mapValue: [String: Notation]? { get }

    /// Receive a dictionary from the container. If the value can not express as a dictionary,
    /// or the value is not exists, it will return `[:]` (Empty dictionary).
    var map: [String: Notation] { get }

    /// Accesses the value at the specified position.
    ///
    /// - SeeAlso: ``subscript(untyped:)-8ssoz``
    /// - Parameter index: The position of the element to access.
    /// - Returns: A value on the `index` or a not exists value if the `index` is out of bounds.
    func item(untyped index: Int) -> Notation

    /// Accesses the value associated with the given key.
    ///
    /// - SeeAlso: ``subscript(untyped:)-7r2x8``
    /// - Parameter key: The key to find in the container.
    /// - Returns: A associated with `key` if `key` is in the container,
    /// or a not exists value if the container has no such key.
    func item(untyped key: String) -> Notation

    /// Accesses the element at the specified position.
    /// Same as `item(untyped: index)`.
    ///
    /// - SeeAlso: ``item(untyped:)-9j7hm``
    /// - Parameter index: The position of the element to access.
    /// - Returns: A value on the `index` or a not exists value if the `index` is out of bounds.
    subscript(untyped index: Int) -> Notation { get }
    
    /// Accesses the value associated with the given key.
    /// Same as `item(untyped: key)`.
    ///
    /// - SeeAlso: ``item(untyped:)-3ikn9``
    /// - Parameter key: The key to find in the container.
    /// - Returns: A associated with `key` if `key` is in the container,
    /// or a not exists value if the container has no such key.
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
