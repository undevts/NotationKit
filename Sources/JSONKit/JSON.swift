import Foundation

#if SWIFT_PACKAGE
@_exported import NotationCore
@_exported import JSONCore
@_implementationOnly import JSONSimd
#endif

public struct JSONParseError: Error, LocalizedError {
    public let code: JSONParseErrorCode

    public init(code: JSONParseErrorCode) {
        self.code = code
    }

    public var errorDescription: String? {
        String(cString: json_error_message(code))
    }
}

// NOTE:
// Use `struct` will cause crash when compiling with SPM in Swift 5.5 and 5.6.
// Tested with:
// swift-driver version: 1.26.21 Apple Swift version 5.5.2 (swiftlang-1300.0.47.5 clang-1300.0.29.30)
// Target: x86_64-apple-macosx12.0
// swift-driver version: 1.45.2 Apple Swift version 5.6 (swiftlang-5.6.0.323.62 clang-1316.0.20.8)
// Target: x86_64-apple-macosx12.0
#if SWIFT_PACKAGE
/// An object representing a JSON value, array or object.
public final class JSON {
    public static let null = JSON(ref: json_create_null())

    let storage: JSONStorage
    let value: JSONValue

    @usableFromInline
    init(storage: JSONStorage) {
        self.storage = storage
        value = storage.root
    }

    init(storage: JSONStorage, value: JSONValue?) {
        self.storage = storage
        self.value = value ?? storage.root
    }

    init(ref: JSONRef) {
        storage = JSONStorage(ref: ref)
        value = storage.root
    }
}
#else
/// A JSON value, array or object.
public struct JSON {
    public static let null = JSON(ref: json_create_null())

    let storage: JSONStorage
    let value: JSONValue

    @usableFromInline
    init(storage: JSONStorage) {
        self.storage = storage
        value = storage.root
    }

    init(storage: JSONStorage, value: JSONValue?) {
        self.storage = storage
        self.value = value ?? storage.root
    }

    init(ref: JSONRef) {
        storage = JSONStorage(ref: ref)
        value = storage.root
    }
}
#endif

extension JSON {
    public var type: JSONType {
        with(value, json_get_type)
    }

    public var isNull: Bool {
        with(value, json_is_null)
    }

    @usableFromInline
    var isNumber: Bool {
        with(value, json_is_number)
    }

    @inline(__always)
    private var arrayRoot: JSONArray? {
        with(value) { ref in
            var root = JSONArray()
            if json_get_array(ref, &root) == JSONParseErrorCode.success {
                return root
            }
            return nil
        }
    }

    @inline(__always)
    private var objectRoot: JSONObject? {
        with(value) { ref in
            var root = JSONObject()
            if json_get_object(ref, &root) == JSONParseErrorCode.success {
                return root
            }
            return nil
        }
    }

    @inlinable
    public func item(keys: String...) -> JSON {
        var result = self
        for key in keys {
            result = result.item(key: key)
        }
        return result
    }

    @inlinable
    public func item<Key>(key: Key) -> JSON where Key: CodingKey {
        if let index = key.intValue {
            return item(at: index)
        } else {
            return item(key: key.stringValue)
        }
    }

    @inlinable
    public func item<Key>(keys: Key...) -> JSON where Key: CodingKey {
        var result = self
        for key in keys {
            result = result.item(key: key)
        }
        return result
    }

    @inline(__always)
    func count(of array: inout JSONArray) -> Int {
        json_array_get_count(&array)
    }

    @inline(__always)
    func count(of object: inout JSONObject) -> Int {
        json_object_get_count(&object)
    }

    @inline(__always)
    func forEach(in array: inout JSONArray, _ method: (JSONValue) -> Void) {
        let n = json_array_get_count(&array)
        var value = JSONValue()
        for i in 0..<n {
            _ = json_array_get(&array, i, &value)
            method(value)
        }
    }

    @inline(__always)
    func forEach(in object: inout JSONObject, _ method: (String, JSONValue) -> Void) {
        let keys = json_object_get_all_keys(&object)
        var value = JSONValue()
        for key in keys {
            _ = json_object_get(&object, key, &value)
            method(key, value)
        }
    }

    @inline(__always)
    func forEach(inArray method: (JSONValue) -> Void) {
        guard var root = arrayRoot else {
            return
        }
        forEach(in: &root, method)
    }

    @inline(__always)
    func forEach(inObject method: (String, JSONValue) -> Void) {
        guard var root = objectRoot else {
            return
        }
        forEach(in: &root, method)
    }

    @inlinable
    public subscript<Key>(key: Key) -> JSON where Key: CodingKey {
        item(key: key)
    }

    @inlinable
    public static func parse(_ value: String) -> Result<JSON, JSONParseError> {
        JSONStorage.parse(value).map(JSON.init(storage:))
    }

    @inlinable
    public static func parse(_ data: Data) -> Result<JSON, JSONParseError> {
        JSONStorage.parse(data).map(JSON.init(storage:))
    }
}

extension JSON {
    public func root<T>(decoder: JSONSimdDecoder? = nil) throws -> T where T: Decodable {
        let decoder = decoder ?? JSONSimdDecoder()
        return try decoder.decode(T.self, storage: storage)
    }

    public func root<T>(as type: T.Type, decoder: JSONSimdDecoder? = nil) throws -> T where T: Decodable {
        let decoder = decoder ?? JSONSimdDecoder()
        return try decoder.decode(type, storage: storage)
    }

    public func decoded<T>(map method: (JSON) -> T) -> [T] {
        guard var root = arrayRoot else {
            return []
        }
        var result: [T] = []
        result.reserveCapacity(count(of: &root))
        forEach(in: &root) { value in
            let json = JSON(storage: storage, value: value)
            result.append(method(json))
        }
        return result
    }

    public func decoded<T>(compactMap method: (JSON) -> T?) -> [T] {
        guard var root = arrayRoot else {
            return []
        }
        var result: [T] = []
        result.reserveCapacity(count(of: &root))
        forEach(in: &root) { value in
            let json = JSON(storage: storage, value: value)
            if let next = method(json) {
                result.append(next)
            }
        }
        return result
    }

    @inlinable
    public func decoded<T>(key: String, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    public func decoded<T, Key>(key: Key, map method: (JSON) -> T) -> [T] where Key: CodingKey {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public func decoded<T, Key>(key: Key, compactMap method: (JSON) -> T?) -> [T] where Key: CodingKey {
        item(key: key).decoded(compactMap: method)
    }

    public func decoded<S, T>(in list: S, map method: (JSON) -> T) -> S
        where S: RangeReplaceableCollection, S.Element == T {
        guard var root = arrayRoot else {
            return list
        }
        var list = list
        list.reserveCapacity(list.count + count(of: &root))
        forEach(in: &root) { value in
            let json = JSON(storage: storage, value: value)
            list.append(method(json))
        }
        return list
    }

    public func decoded<S, T>(in list: S, compactMap method: (JSON) -> T?) -> S
        where S: RangeReplaceableCollection, S.Element == T {
        guard var root = arrayRoot else {
            return list
        }
        var list = list
        list.reserveCapacity(list.count + count(of: &root))
        forEach(in: &root) { value in
            let json = JSON(storage: storage, value: value)
            if let next = method(json) {
                list.append(next)
            }
        }
        return list
    }

    @inlinable
    public func decoded<S, T>(key: String, in list: S, map method: (JSON) -> T) -> S
        where S: RangeReplaceableCollection, S.Element == T {
        item(key: key).decoded(in: list, map: method)
    }

    @inlinable
    public func decoded<S, T>(key: String, in list: S, compactMap method: (JSON) -> T?) -> S?
        where S: RangeReplaceableCollection, S.Element == T {
        item(key: key).decoded(in: list, compactMap: method)
    }

    @inlinable
    public func decoded<S, T, Key>(key: Key, in list: S, map method: (JSON) -> T) -> S
        where S: RangeReplaceableCollection, S.Element == T, Key: CodingKey {
        item(key: key).decoded(in: list, map: method)
    }

    public func decoded<T>(map method: (JSON) -> T) -> [String: T] {
        guard var root = objectRoot else {
            return [:]
        }
        var result: [String: T] = [:]
        result.reserveCapacity(count(of: &root))
        forEach(in: &root) { (key, value) in
            let json = JSON(storage: storage, value: value)
            result[key] = method(json)
        }
        return result
    }

    public func decoded<T>(compactMap method: (JSON) -> T?) -> [String: T] {
        guard var root = objectRoot else {
            return [:]
        }
        var result: [String: T] = [:]
        result.reserveCapacity(count(of: &root))
        forEach(in: &root) { (key, value) in
            let json = JSON(storage: storage, value: value)
            result[key] = method(json)
        }
        return result
    }

    @inlinable
    public func decoded<T>(key: String, map method: (JSON) -> T) -> [String: T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [String: T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    public func decoded<T, Key>(key: Key, map method: (JSON) -> T) -> [String: T] where Key: CodingKey {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public func decoded<T, Key>(key: Key, compactMap method: (JSON) -> T?) -> [String: T] where Key: CodingKey {
        item(key: key).decoded(compactMap: method)
    }
}

extension JSON: TypeNotation {
    public typealias Typed = JSON

    @inlinable
    public var isExists: Bool {
        !isNull
    }

    public var bool: Bool {
        with(value) { ref in
            json_get_bool(ref, nil)
        }
    }

    public var string: String {
        with(value) { ref in
            var size = 0
            let out = json_get_string(ref, &size, nil)
            if let out = out, size > 0 {
                return String(cString: out)
            }
            return ""
        }
    }

    public var double: Double {
        with(value) { ref in
            json_get_double(ref, nil)
        }
    }

    public var float: Float {
        with(value) { ref -> Float in
            let result = json_get_double(ref, nil)
            return Float(result)
        }
    }

    public var int: Int {
        with(value) { ref in
            json_get_int(ref, nil)
        }
    }

    public var int32: Int32 {
        with(value) { ref in
            json_get_int32(ref, nil)
        }
    }

    public var int64: Int64 {
        with(value) { ref in
            json_get_int64(ref, nil)
        }
    }

    public var uint: UInt {
        with(value) { ref in
            json_get_uint(ref, nil)
        }
    }

    public var uint32: UInt32 {
        with(value) { ref in
            json_get_uint32(ref, nil)
        }
    }

    public var uint64: UInt64 {
        with(value) { ref in
            json_get_uint64(ref, nil)
        }
    }

    public var array: [JSON] {
        guard var root = arrayRoot else {
            return []
        }
        var result: [JSON] = []
        result.reserveCapacity(count(of: &root))
        forEach(in: &root) { value in
            result.append(JSON(storage: storage, value: value))
        }
        return result
    }

    public var dictionary: [String: JSON] {
        guard var root = objectRoot else {
            return [:]
        }
        var result: [String: JSON] = [:]
        result.reserveCapacity(count(of: &root))
        forEach(in: &root) { key, value in
            result[key] = JSON(storage: storage, value: value)
        }
        return result
    }

    public func item(at index: Int) -> JSON {
        with(value) { ref in
            if !json_is_array(ref) {
                return JSON.null
            }
            var array = JSONArray()
            _ = json_get_array(ref, &array)
            if index >= 0 && index <= json_array_get_count(&array) {
                var value = JSONValue()
                _ = json_array_get(&array, index, &value)
                return JSON(storage: storage, value: value)
            } else {
                return JSON.null
            }
        }
    }

    public func item(key: String) -> JSON {
        with(value) { ref in
            if !json_is_object(ref) {
                return JSON.null
            }
            var object = JSONObject()
            var value = JSONValue()
            _ = json_get_object(ref, &object)
            if json_object_get(&object, key, &value) == JSONParseErrorCode.success {
                return JSON(storage: storage, value: value)
            } else {
                return JSON.null
            }
        }
    }

    @inlinable
    public subscript(index: Int) -> JSON {
        item(at: index)
    }

    @inlinable
    public subscript(key: String) -> JSON {
        item(key: key)
    }
}

extension JSON {
    @inlinable
    public var boolValue: Bool? {
       type == JSONType.bool ? bool : nil
    }

    @inlinable
    public var stringValue: String? {
        type == JSONType.string ? string : nil
    }

    @inlinable
    public var doubleValue: Double? {
        isNumber ? double : nil
    }

    @inlinable
    public var floatValue: Float? {
        isNumber ? float : nil
    }

    @inlinable
    public var intValue: Int? {
        isNumber ? int : nil
    }

    @inlinable
    public var int32Value: Int32? {
        isNumber ? int32 : nil
    }

    @inlinable
    public var int64Value: Int64? {
        isNumber ? int64 : nil
    }

    @inlinable
    public var uintValue: UInt? {
        isNumber ? uint : nil
    }

    @inlinable
    public var uint32Value: UInt32? {
        isNumber ? uint32 : nil
    }

    @inlinable
    public var uint64Value: UInt64? {
        isNumber ? uint64 : nil
    }

    @inlinable
    public var listValue: [Notation]? {
        type == JSONType.array ? list : nil
    }

    @inlinable
    public var mapValue: [String: Notation]? {
        type == JSONType.object ? map : nil
    }
}

extension JSON: CustomStringConvertible {
    @inlinable
    public var rawString: String {
        String(data: encoded(), encoding: .utf8) ?? ""
    }

    @inlinable
    public var description: String {
        rawString
    }
}
