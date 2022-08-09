#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct _KeyedDecodingContainer<Key>: KeyedDecodingContainerProtocol where Key: CodingKey {
    private var context: _Decoder.Context
    private(set) var codingPath: [CodingKey]
    let ref: json_object

    init(_ context: _Decoder.Context, _ value: json_value) {
        self.context = context
        ref = _decodeObject(value)
        codingPath = context.codingPath
    }

    var storage: JSONStorage {
        context.storage
    }

    var allKeys: [Key] {
#if canImport(ObjectiveC)
        return with(ref) { r in
            nk_json_object_get_all_keys(r).compactMap(Key.init(stringValue:))
        }
#else
        return with(ref, decodeAllKeys).compactMap(Key.init(stringValue:))
#endif
    }

    func contains(_ key: Key) -> Bool {
        with(ref) { r in
            nk_json_object_contains(r, key.stringValue)
        }
    }

    @_transparent
    func value(of key: Key) throws -> SimdDecoder {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            throw keyNotFound(key, codingPath,
                "No value associated with key \(key) (\"\(key.stringValue)\").")
        }
        return SimdDecoder(storage: storage, value: value)
    }

    @_transparent
    func optionalValue(of key: Key) throws -> SimdDecoder? {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            return nil
        }
        return SimdDecoder(storage: storage, value: value)
    }

    func decodeNil(forKey key: Key) throws -> Bool {
        try value(of: key).isNull
    }

    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try value(of: key).decodeBool(codingPath)
    }

    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try value(of: key).decodeString(codingPath)
    }

    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try value(of: key).decodeDouble(codingPath)
    }

    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try value(of: key).decodeFloat(codingPath)
    }

    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try value(of: key).decodeInt(codingPath)
    }

    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        try value(of: key).decodeInt8(codingPath)
    }

    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        try value(of: key).decodeInt16(codingPath)
    }

    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        try value(of: key).decodeInt32(codingPath)
    }

    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        try value(of: key).decodeInt64(codingPath)
    }

    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        try value(of: key).decodeUInt(codingPath)
    }

    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        try value(of: key).decodeUInt8(codingPath)
    }

    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        try value(of: key).decodeUInt16(codingPath)
    }

    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        try value(of: key).decodeUInt32(codingPath)
    }

    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        try value(of: key).decodeUInt64(codingPath)
    }

    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            throw keyNotFound(key, codingPath,
                "No value associated with key \(key) (\"\(key.stringValue)\").")
        }
        return try context.makeDecoder(value).decode(type)
    }

    func decodeIfPresent(_ type: Bool.Type, forKey key: Key) throws -> Bool? {
        try optionalValue(of: key)?.decodeOptionalBool(codingPath)
    }

    func decodeIfPresent(_ type: String.Type, forKey key: Key) throws -> String? {
        try optionalValue(of: key)?.decodeOptionalString(codingPath)
    }

    func decodeIfPresent(_ type: Double.Type, forKey key: Key) throws -> Double? {
        try optionalValue(of: key)?.decodeOptionalDouble(codingPath)
    }

    func decodeIfPresent(_ type: Float.Type, forKey key: Key) throws -> Float? {
        try optionalValue(of: key)?.decodeOptionalFloat(codingPath)
    }

    func decodeIfPresent(_ type: Int.Type, forKey key: Key) throws -> Int? {
        try optionalValue(of: key)?.decodeOptionalInt(codingPath)
    }

    func decodeIfPresent(_ type: Int8.Type, forKey key: Key) throws -> Int8? {
        try optionalValue(of: key)?.decodeOptionalInt8(codingPath)
    }

    func decodeIfPresent(_ type: Int16.Type, forKey key: Key) throws -> Int16? {
        try optionalValue(of: key)?.decodeOptionalInt16(codingPath)
    }

    func decodeIfPresent(_ type: Int32.Type, forKey key: Key) throws -> Int32? {
        try optionalValue(of: key)?.decodeOptionalInt32(codingPath)
    }

    func decodeIfPresent(_ type: Int64.Type, forKey key: Key) throws -> Int64? {
        try optionalValue(of: key)?.decodeOptionalInt64(codingPath)
    }

    func decodeIfPresent(_ type: UInt.Type, forKey key: Key) throws -> UInt? {
        try optionalValue(of: key)?.decodeOptionalUInt(codingPath)
    }

    func decodeIfPresent(_ type: UInt8.Type, forKey key: Key) throws -> UInt8? {
        try optionalValue(of: key)?.decodeOptionalUInt8(codingPath)
    }

    func decodeIfPresent(_ type: UInt16.Type, forKey key: Key) throws -> UInt16? {
        try optionalValue(of: key)?.decodeOptionalUInt16(codingPath)
    }

    func decodeIfPresent(_ type: UInt32.Type, forKey key: Key) throws -> UInt32? {
        try optionalValue(of: key)?.decodeOptionalUInt32(codingPath)
    }

    func decodeIfPresent(_ type: UInt64.Type, forKey key: Key) throws -> UInt64? {
        try optionalValue(of: key)?.decodeOptionalUInt64(codingPath)
    }

    func decodeIfPresent<T>(_ type: T.Type, forKey key: Key) throws -> T? where T: Decodable {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            return nil
        }
        return try context.makeDecoder(value).decode(type)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws ->
        KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            throw keyNotFound(key, codingPath,
                "No value associated with key \(key) (\"\(key.stringValue)\").")
        }
        let container = try context.makeDecoder(value).container(keyedBy: type)
        return KeyedDecodingContainer(container)
    }

    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            throw keyNotFound(key, codingPath,
                "No value associated with key \(key) (\"\(key.stringValue)\").")
        }
        return try context.makeDecoder(value).unkeyedContainer()
    }

    /// Returns a `Decoder` instance for decoding super from the container associated with the default `super` key.
    ///
    /// Equivalent to calling `superDecoder(forKey:)` with `Key(stringValue: "super", intValue: 0)`.
    ///
    /// - Returns: A new `Decoder` to pass to `super.init(from:)`.
    /// - Throws: A `DecodingError` error.
    func superDecoder() throws -> Decoder {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, "super", &value)
        }
        if code == .noSuchField {
            throw keyNotFound("super" as AnyCodingKey, codingPath,
                "No value associated with key \"super\".")
        }
        return context.makeDecoder(value)
    }

    func superDecoder(forKey key: Key) throws -> Decoder {
        var value = json_value()
        let code = with(ref) { r in
            nk_json_object_get(r, key.stringValue, &value)
        }
        if code == .noSuchField {
            throw keyNotFound(key, codingPath,
                "No value associated with key \(key) (\"\(key.stringValue)\").")
        }
        return context.makeDecoder(value)
    }
}

@inline(__always)
private func _decodeObject(_ value: json_value) -> json_object {
    with(value) { ref in
        var object = json_object()
        // TODO: Error check.
        _ = nk_json_get_object(ref, &object)
        return object
    }
}

#if !canImport(ObjectiveC)
@_transparent
private func decodeAllKeys(_ root: JSONObjectRef) -> [String] {
    let count = json_object_get_count(root)
    guard count > 0 else {
        return []
    }
    var result: [String] = []
    var index = 0
    while index < count {
        // TODO: Error check.
        json_object_get_key(ref, index, &key, &value)
        if let key = json_object_get_key(ref, index) {
            result.append(String(cString: key))
        }
        index += 1
    }
    return result
}
#endif
