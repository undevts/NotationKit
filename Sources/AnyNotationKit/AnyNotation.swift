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

#if canImport(CoreGraphics)
import CoreGraphics
#endif

#if SWIFT_PACKAGE
@_exported import NotationCore
#endif

public final class AnyNotation {
    private var _rawValue: Any?
    private var _rawArray: [Any]?
    private var _rawObject: [String: Any]?
    private var _rawDictionary: [AnyHashable: Any]?
    private var _rawString: String?
    private var _rawNumber: NSNumber?
    private var _mapArray: [AnyNotation]?
    private var _mapObject: [String: AnyNotation]?

    var kind: Kind

    public init() {
        kind = .null
    }

    public init(_ value: Any) {
        kind = Kind.opaque
        _rawValue = value
    }

    public init(_ value: Any?) {
        if let value = value {
            kind = Kind.opaque
            _rawValue = value
        } else {
            kind = .null
        }
    }

    public init(_ value: [Any]) {
        kind = .array
        _rawArray = value
    }

    public init(_ value: [String: Any]) {
        kind = .object
        _rawObject = value
    }

    public init(_ value: [AnyHashable: Any]) {
        kind = .object
        if let typed = value as? [String: Any] {
            _rawObject = typed
        } else {
            _rawDictionary = value
        }
    }

    private func resolve() {
        guard kind == .opaque else {
            return
        }
        resolve(object: _rawValue)
    }

    private func resolve(object: Any?) {
        switch object {
        case let number as NSNumber:
            _rawNumber = number
            kind = .number
        case let string as String:
            _rawString = string
            kind = .string
        case let array as [Any]:
            _rawArray = array
            kind = .array
        case let object as [String: Any]:
            _rawObject = object
            kind = .object
        case let dictionary as [AnyHashable: Any]:
            _rawDictionary = dictionary
            kind = .object
        case .none:
            kind = .null
        default:
            _rawValue = object
            kind = .unknown
        }
    }

    enum Kind {
        case opaque
        case null
        case number
        case string
        case array
        case object
        case unknown
    }
}

extension AnyNotation {
    private func fromNumber<T>(_ type: T.Type) -> T? {
        guard let temp = _rawNumber else {
            return nil
        }
        if type == NSNumber.self {
            return temp as! T?
        } else if type == String.self {
            return temp.stringValue as! T?
        } else if type == Int.self {
            return temp.intValue as! T?
        } else if type == UInt.self {
            return temp.uintValue as! T?
        } else if type == Double.self {
            return temp.doubleValue as! T?
        } else if type == Int32.self {
            return temp.int32Value as! T?
        } else if type == UInt32.self {
            return temp.uint32Value as! T?
        } else if type == Int64.self {
            return temp.int64Value as! T?
        } else if type == UInt64.self {
            return temp.uint64Value as! T?
        } else if type == Int16.self {
            return temp.int16Value as! T?
        } else if type == UInt16.self {
            return temp.uint16Value as! T?
        } else if type == Int8.self {
            return temp.int8Value as! T?
        } else if type == UInt8.self {
            return temp.uint8Value as! T?
        } else if type == Float.self {
            return temp.floatValue as! T?
        } else if type == Decimal.self {
            return temp.decimalValue as! T?
        }
#if canImport(CoreGraphics)
        if type == CGFloat.self {
            return CGFloat(temp.doubleValue) as! T?
        }
#endif
         return nil
    }

    public func to<T>(_ type: T.Type) -> T? {
        if let temp = _rawValue as? T {
            return temp
        }
        resolve()
        if type == String.self, let value = _rawString {
            return value as! T?
        }
        if let temp = fromNumber(type) {
            return temp
        }
        if let temp = _rawObject as? T {
            return temp
        }
        if let temp = _rawDictionary as? T {
            return temp
        }
        if let temp = _rawArray as? T {
            return temp
        }
        if let temp = _mapObject as? T {
            return temp
        }
        if let temp = _mapArray as? T {
            return temp
        }
        return nil
    }
}

extension AnyNotation {
    public var listValue: [Notation]? {
        arrayValue
    }

    public var list: [Notation] {
        array
    }

    public var mapValue: [String: Notation]? {
        dictionaryValue
    }

    public var map: [String: Notation] {
        dictionary
    }

    public func item(untyped index: Int) -> Notation {
        item(at: index)
    }

    public func item(untyped key: String) -> Notation {
        item(key: key)
    }

    public subscript(untyped index: Int) -> Notation {
        item(at: index)
    }

    public subscript(untyped key: String) -> Notation {
        item(key: key)
    }
}

extension AnyNotation: TypeNotation {
    public typealias Typed = AnyNotation

    public var isExists: Bool {
        resolve()
        return kind != .null
    }

    public var bool: Bool {
        resolve()
        if let number = _rawNumber {
            return number.boolValue
        }
        switch _rawString {
        case "1", "true", "yes", "TRUE", "YES":
            return true
        default:
            return false
        }
    }

    public var boolValue: Bool? {
        resolve()
        if let number = _rawNumber {
            return number.boolValue
        }
        if let string = _rawString {
            switch string {
            case "1", "true", "yes", "TRUE", "YES":
                return true
            case "", "0", "false", "no", "FALSE", "NO":
                return false
            default:
                return nil
            }
        }
        return nil
    }

    public var string: String {
        resolve()
        if let number = _rawNumber {
            return number.stringValue
        }
        return _rawString ?? ""
    }

    public var stringValue: String? {
        resolve()
        if let number = _rawNumber {
            return number.stringValue
        }
        return _rawString
    }

    public var double: Double {
        resolve()
        if let number = _rawNumber {
            return number.doubleValue
        }
        if let string = _rawString {
            return Double(string) ?? 0.0
        }
        return 0
    }

    public var doubleValue: Double? {
        resolve()
        if let number = _rawNumber {
            return number.doubleValue
        }
        if let string = _rawString {
            return Double(string)
        }
        return nil
    }

    public var float: Float {
        resolve()
        if let number = _rawNumber {
            return number.floatValue
        }
        if let string = _rawString {
            return Float(string) ?? 0.0
        }
        return 0.0
    }

    public var floatValue: Float? {
        resolve()
        if let number = _rawNumber {
            return number.floatValue
        }
        if let string = _rawString {
            return Float(string)
        }
        return nil
    }

    public var int: Int {
        resolve()
        if let number = _rawNumber {
            return number.intValue
        }
        if let string = _rawString {
            return Int(string) ?? 0
        }
        return 0
    }

    public var intValue: Int? {
        resolve()
        if let number = _rawNumber {
            return number.intValue
        }
        if let string = _rawString {
            return Int(string)
        }
        return nil
    }

    public var int32: Int32 {
        resolve()
        if let number = _rawNumber {
            return number.int32Value
        }
        if let string = _rawString {
            return Int32(string) ?? 0
        }
        return 0
    }

    public var int32Value: Int32? {
        resolve()
        if let number = _rawNumber {
            return number.int32Value
        }
        if let string = _rawString {
            return Int32(string)
        }
        return nil
    }

    public var int64: Int64 {
        resolve()
        if let number = _rawNumber {
            return number.int64Value
        }
        if let string = _rawString {
            return Int64(string) ?? 0
        }
        return 0
    }

    public var int64Value: Int64? {
        resolve()
        if let number = _rawNumber {
            return number.int64Value
        }
        if let string = _rawString {
            return Int64(string)
        }
        return nil
    }

    public var uint: UInt {
        resolve()
        if let number = _rawNumber {
            return number.uintValue
        }
        if let string = _rawString {
            return UInt(string) ?? 0
        }
        return 0
    }

    public var uintValue: UInt? {
        resolve()
        if let number = _rawNumber {
            return number.uintValue
        }
        if let string = _rawString {
            return UInt(string)
        }
        return nil
    }

    public var uint32: UInt32 {
        resolve()
        if let number = _rawNumber {
            return number.uint32Value
        }
        if let string = _rawString {
            return UInt32(string) ?? 0
        }
        return 0
    }

    public var uint32Value: UInt32? {
        resolve()
        if let number = _rawNumber {
            return number.uint32Value
        }
        if let string = _rawString {
            return UInt32(string)
        }
        return nil
    }

    public var uint64: UInt64 {
        resolve()
        if let number = _rawNumber {
            return number.uint64Value
        }
        if let string = _rawString {
            return UInt64(string) ?? 0
        }
        return 0
    }

    public var uint64Value: UInt64? {
        resolve()
        if let number = _rawNumber {
            return number.uint64Value
        }
        if let string = _rawString {
            return UInt64(string)
        }
        return nil
    }

    public var array: [AnyNotation] {
        resolve()
        if let resolved = _mapArray {
            return resolved
        }
        if let array = _rawArray {
            let temp = array.map(AnyNotation.init)
            _mapArray = temp
            _rawArray = nil
            return temp
        }
        return []
    }

    public var arrayValue: [AnyNotation]? {
        resolve()
        if let resolved = _mapArray {
            return resolved
        }
        if let array = _rawArray {
            _mapArray = array.map(AnyNotation.init)
            _rawArray = nil
            return _mapArray
        }
        return nil
    }

    public var dictionary: [String: AnyNotation] {
        resolve()
        if let resolved = _mapObject {
            return resolved
        }
        if let raw = _rawObject {
            let temp = raw.mapValues(AnyNotation.init)
            _mapObject = temp
            _rawObject = nil
            return temp
        }
        return [:]
    }

    public var dictionaryValue: [String: AnyNotation]? {
        resolve()
        if let resolved = _mapObject {
            return resolved
        }
        if let raw = _rawObject {
            _mapObject = raw.mapValues(AnyNotation.init)
            _rawObject = nil
            return _mapObject
        }
        return nil
    }

    public func item(at index: Int) -> AnyNotation {
        resolve()
        if let array = _mapArray {
            if index >= array.startIndex && index < array.endIndex {
                return array[index]
            }
        }
        if let array = _rawArray {
            if index >= array.startIndex && index < array.endIndex {
                return AnyNotation(array[index])
            }
        }
        return AnyNotation()
    }

    public func item(key: String) -> AnyNotation {
        resolve()
        if let value = _mapObject?[key] {
            return value
        }
        if let value = _rawObject?[key] {
            return AnyNotation(value)
        }
        if let value = _rawDictionary?[key] {
            return AnyNotation(value)
        }
        return AnyNotation()
    }

    public subscript(index: Int) -> AnyNotation {
        item(at: index)
    }

    public subscript(key: String) -> AnyNotation {
        item(key: key)
    }
}
