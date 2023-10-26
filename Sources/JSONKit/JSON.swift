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
        String(cString: nk_json_error_message(code))
    }
}

// NOTE:
// Use `struct` will cause crash when compiling with SPM in Swift 5.5 and 5.6.
// Tested with:
// swift-driver version: 1.26.21 Apple Swift version 5.5.2 (swiftlang-1300.0.47.5 clang-1300.0.29.30)
// Target: x86_64-apple-macosx12.0
// swift-driver version: 1.45.2 Apple Swift version 5.6 (swiftlang-5.6.0.323.62 clang-1316.0.20.8)
// Target: x86_64-apple-macosx12.0
//
// UPDATE:
// Swift 5.9 test passes.
// swift-driver version: 1.87.1 Apple Swift version 5.9 (swiftlang-5.9.0.128.108 clang-1500.0.40.1)
// Target: arm64-apple-macosx14.0
#if SWIFT_PACKAGE && swift(<5.9)
/// An object representing a JSON value, array or object.
public final class JSON {
    /// A static property that represents JSON null value.
    public static let null = JSON(ref: nk_json_create_null())

    @usableFromInline
    let storage: JSONStorage
    let value: json_value

    @usableFromInline
    init(storage: JSONStorage) {
        self.storage = storage
        value = storage.root
    }

    init(storage: JSONStorage, value: json_value?) {
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
@frozen
public struct JSON {
    /// A static property that represents JSON null value.
    public static let null = JSON(ref: nk_json_create_null())

    @usableFromInline
    let storage: JSONStorage
    let value: json_value

    @usableFromInline
    init(storage: JSONStorage) {
        self.storage = storage
        value = storage.root
    }

    init(storage: JSONStorage, value: json_value?) {
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
    /// The type of current root JSON value.
    public var type: JSONType {
        with(value, nk_json_get_type)
    }

    /// A bool value indicating whether current value is null.
    public var isNull: Bool {
        with(value, nk_json_is_null)
    }

    @usableFromInline
    var isNumber: Bool {
        with(value, nk_json_is_number)
    }

    @inline(__always)
    var arrayRoot: json_array? {
        with(value) { ref in
            var root = json_array()
            if nk_json_get_array(ref, &root) == JSONParseErrorCode.success {
                return root
            }
            return nil
        }
    }

    @inline(__always)
    @usableFromInline
    var objectRoot: json_object? {
        with(value) { ref in
            var root = json_object()
            if nk_json_get_object(ref, &root) == JSONParseErrorCode.success {
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
    
#if swift(>=5.9)
    @inline(__always)
    @usableFromInline
    static func item<Key>(key: Key, _ json: inout JSON) where Key: CodingKey {
        json = json.item(key: key)
    }
    
    @inlinable
    public func item<each Key: CodingKey>(keys: repeat each Key) -> JSON {
        var result = self
        repeat JSON.item(key: each keys, &result)
        return result
    }
#endif

    @inline(__always)
    func count(of array: inout json_array) -> Int {
        nk_json_array_get_count(&array)
    }

    @inline(__always)
    func count(of object: inout json_object) -> Int {
        nk_json_object_get_count(&object)
    }

    @inline(__always)
    func forEach(in array: inout json_array, _ method: (json_value) -> Void) {
        var current = json_array_iterator()
        var end = json_array_iterator()
        nk_json_array_get_begin_iterator(&array, &current)
        nk_json_array_get_end_iterator(&array, &end)
        if nk_json_array_iterator_is_equal(&current, &end) {
            return
        }
        var value = json_value()
        while !nk_json_array_iterator_is_equal(&current, &end) {
            _ = nk_json_array_iterator_get_value(&current, &value)
            method(value)
            nk_json_array_iterator_move_next(&current)
        }
    }

    @inline(__always)
    func forEach(in object: inout json_object, _ method: (String, json_value) -> Void) {
        var current = json_object_iterator()
        var end = json_object_iterator()
        nk_json_object_get_begin_iterator(&object, &current)
        nk_json_object_get_end_iterator(&object, &end)
        if nk_json_object_iterator_is_equal(&current, &end) {
            return
        }
        var size = 0
        var value = json_value()
        while !nk_json_object_iterator_is_equal(&current, &end) {
            let raw = nk_json_object_iterator_get_key(&current, &size)
            _ = nk_json_object_iterator_get_value(&current, &value)
            // TODO: use size
            if let raw = raw, size > 0 {
                method(String(cString: raw), value)
            } else {
                method("", value)
            }
            nk_json_object_iterator_move_next(&current)
        }
    }

    @inline(__always)
    func forEach(inArray method: (json_value) -> Void) {
        guard var root = arrayRoot else {
            return
        }
        forEach(in: &root, method)
    }

    @inline(__always)
    func forEach(inObject method: (String, json_value) -> Void) {
        guard var root = objectRoot else {
            return
        }
        forEach(in: &root, method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public subscript<Key>(key: Key) -> JSON where Key: CodingKey {
        item(key: key)
    }
    
    @inline(__always)
    @usableFromInline
    static func _parse(_ value: String) -> Result<JSON, JSONParseError> {
        JSONStorage.parse(value).map(JSON.init(storage:))
    }
    
    @inline(__always)
    @usableFromInline
    static func _parse(_ data: Data) -> Result<JSON, JSONParseError> {
        JSONStorage.parse(data).map(JSON.init(storage:))
    }

    /// Parses a JSON string, converting it to an in-memory representation.
    ///
    /// - Parameter value: The JSON string to decode.
    /// - Returns: A result indicating success or failure.
    @inlinable
    public static func parse(_ value: String) -> Result<JSON, JSONParseError> {
        _parse(value)
    }

    /// Parses a JSON data, converting it to an in-memory representation.
    ///
    /// - Parameter data: The JSON data to decode.
    /// - Returns: A result indicating success or failure.
    @inlinable
    public static func parse(_ data: Data) -> Result<JSON, JSONParseError> {
        _parse(data)
    }
}

extension JSON {
    @inlinable
    public func root<T>(decoder: JSONSimdDecoder? = nil) throws -> T where T: Decodable {
        let decoder = decoder ?? JSONSimdDecoder()
        return try decoder.decode(T.self, storage: storage)
    }

    @inlinable
    public func root<T>(as type: T.Type, decoder: JSONSimdDecoder? = nil) throws -> T where T: Decodable {
        let decoder = decoder ?? JSONSimdDecoder()
        return try decoder.decode(type, storage: storage)
    }

    /// Decode current value as an array and calls the transform method on each JSON value in it.
    ///
    /// Same as `json.array.map(method)` but more efficient.
    ///
    /// - Parameter method: A mapping closure.
    /// - Returns: The mapped result, if current value is not a JSON array, an empty array will return.
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

    /// Decode current value as an array and calls the transform method on each JSON value in it.
    ///
    /// Same as `json.array.map(method)` but more efficient.
    ///
    /// - Parameter method: A mapping closure.
    /// - Returns: The mapped result, if current value is not a JSON array, an empty array will return.
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
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T, Key>(key: Key, map method: (JSON) -> T) -> [T] where Key: CodingKey {
        item(key: key).decoded(map: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
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
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<S, T>(key: String, in list: S, map method: (JSON) -> T) -> S
        where S: RangeReplaceableCollection, S.Element == T {
        item(key: key).decoded(in: list, map: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<S, T>(key: String, in list: S, compactMap method: (JSON) -> T?) -> S?
        where S: RangeReplaceableCollection, S.Element == T {
        item(key: key).decoded(in: list, compactMap: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<S, T, Key>(key: Key, in list: S, map method: (JSON) -> T) -> S
        where S: RangeReplaceableCollection, S.Element == T, Key: CodingKey {
        item(key: key).decoded(in: list, map: method)
    }

    /// Decode current value as a dictionary and calls the transform method on each JSON value in it.
    ///
    /// Same as `json.dictionary.map(method)` but more efficient.
    ///
    /// - Parameter method: A mapping closure.
    /// - Returns: The mapped result, if current value is not a JSON object, an empty dictionary will return.
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

    /// Decode current value as a dictionary and calls the transform method on each JSON value in it.
    ///
    /// Same as `json.dictionary.map(method)` but more efficient.
    ///
    /// - Parameter method: A mapping closure.
    /// - Returns: The mapped result, if current value is not a JSON object, an empty dictionary will return.
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
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, map method: (JSON) -> T) -> [String: T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [String: T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T, Key>(key: Key, map method: (JSON) -> T) -> [String: T] where Key: CodingKey {
        item(key: key).decoded(map: method)
    }

    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
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
            nk_json_get_bool(ref, nil)
        }
    }

    public var string: String {
        with(value) { ref in
            var size = 0
            let out = nk_json_get_string(ref, &size, nil)
            if let out = out, size > 0 {
                // TODO: use size
                return String(cString: out)
            }
            return ""
        }
    }

    public var double: Double {
        with(value) { ref in
            nk_json_get_double(ref, nil)
        }
    }

    public var float: Float {
        with(value) { ref -> Float in
            let result = nk_json_get_double(ref, nil)
            return Float(result)
        }
    }

    public var int: Int {
        with(value) { ref in
            nk_json_get_int(ref, nil)
        }
    }

    public var int32: Int32 {
        with(value) { ref in
            nk_json_get_int32(ref, nil)
        }
    }

    public var int64: Int64 {
        with(value) { ref in
            nk_json_get_int64(ref, nil)
        }
    }

    public var uint: UInt {
        with(value) { ref in
            nk_json_get_uint(ref, nil)
        }
    }

    public var uint32: UInt32 {
        with(value) { ref in
            nk_json_get_uint32(ref, nil)
        }
    }

    public var uint64: UInt64 {
        with(value) { ref in
            nk_json_get_uint64(ref, nil)
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
            if !nk_json_is_array(ref) {
                return JSON.null
            }
            var array = json_array()
            _ = nk_json_get_array(ref, &array)
            if index >= 0 && index <= nk_json_array_get_count(&array) {
                var value = json_value()
                _ = nk_json_array_get(&array, index, &value)
                return JSON(storage: storage, value: value)
            } else {
                return JSON.null
            }
        }
    }

    public func item(key: String) -> JSON {
        with(value) { ref in
            if !nk_json_is_object(ref) {
                return JSON.null
            }
            var object = json_object()
            var value = json_value()
            _ = nk_json_get_object(ref, &object)
            if nk_json_object_get(&object, key, &value) == JSONParseErrorCode.success {
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
    /// - Warning: Unstable
    @inlinable
    public var rawString: String {
        String(data: encoded(), encoding: .utf8) ?? ""
    }

    @inlinable
    public var description: String {
        rawString
    }
}
