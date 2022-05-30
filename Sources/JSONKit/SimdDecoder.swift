import Foundation

#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct SimdDecoder: JSONContainer {
    let storage: JSONStorage
    let value: JSONValue

    @_transparent
    init(storage: JSONStorage, value: JSONValue) {
        self.storage = storage
        self.value = value
    }

    @_transparent
    init<Container>(_ container: Container) where Container: JSONContainer {
        storage = container.storage
        value = container.value
    }

    @_transparent
    var isNull: Bool {
        with(json_is_null)
    }

    @_transparent
    var kind: JSONType {
        with(json_get_type)
    }

    @inline(__always)
    private func with<Result>(_ method: (JSONValueRef) -> Result) -> Result {
        withUnsafePointer(to: value) { (pointer: UnsafePointer<JSONValue>) -> Result in
            method(UnsafeMutablePointer(mutating: pointer))
        }
    }

    @inline(__always)
    private func with<Result>(_ method: (JSONValueRef, UnsafeMutablePointer<JSONParseErrorCode>?) -> Result)
        -> (Result, JSONParseErrorCode) {
        withUnsafePointer(to: value) { (pointer: UnsafePointer<JSONValue>) -> (Result, JSONParseErrorCode) in
            var code = JSONParseErrorCode.success
            let result = method(UnsafeMutablePointer(mutating: pointer), &code)
            return (result, code)
        }
    }

    @_transparent
    func decodeBool(_ codingPath: [CodingKey]) throws -> Bool {
        switch kind {
        case .null:
            throw valueNotFound(Bool.self, codingPath,
                "Expected Bool but found JSONType.null instead.")
        case .bool:
            let (result, code) = with(json_get_bool)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Bool.self, codingPath,
                "Expected to decode Bool but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeString(_ codingPath: [CodingKey]) throws -> String {
        switch kind {
        case .null:
            throw valueNotFound(String.self, codingPath,
                "Expected String but found JSONType.null instead.")
        case .string:
            var code = JSONParseErrorCode.success
            var size: Int = 0
            let result = with { ref in
                json_get_string(ref, &size, &code)
            }
            if code == .success, let result = result.map(UnsafeMutablePointer.init(mutating:)) {
                let data = Data(bytesNoCopy: result, count: size, deallocator: .none)
                return String(data: data, encoding: .utf8) ?? ""
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(String.self, codingPath,
                "Expected to decode String but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeDouble(_ codingPath: [CodingKey]) throws -> Double {
        switch kind {
        case .null:
            throw valueNotFound(Double.self, codingPath,
                "Expected Double but found JSONType.null instead.")
        case .double, .uint64, .int64:
            let (result, code) = with(json_get_double)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Double.self, codingPath,
                "Expected to decode Double but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeFloat(_ codingPath: [CodingKey]) throws -> Float {
        switch kind {
        case .null:
            throw valueNotFound(Bool.self, codingPath,
                "Expected Float but found JSONType.null instead.")
        case .double, .uint64, .int64:
            let (result, code) = with(json_get_double)
            if code == .success {
                return Float(result)
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Float.self, codingPath,
                "Expected to decode Float but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeInt(_ codingPath: [CodingKey]) throws -> Int {
        switch kind {
        case .null:
            throw valueNotFound(Int.self, codingPath,
                "Expected Int but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int.self, codingPath,
                "Expected to decode Int but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeInt8(_ codingPath: [CodingKey]) throws -> Int8 {
        switch kind {
        case .null:
            throw valueNotFound(Int8.self, codingPath,
                "Expected Int8 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int8(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int8.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int8")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int8.self, codingPath,
                "Expected to decode Int8 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeInt16(_ codingPath: [CodingKey]) throws -> Int16 {
        switch kind {
        case .null:
            throw valueNotFound(Int16.self, codingPath,
                "Expected Int16 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int16(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int16.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int16")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int16.self, codingPath,
                "Expected to decode Int16 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeInt32(_ codingPath: [CodingKey]) throws -> Int32 {
        switch kind {
        case .null:
            throw valueNotFound(Int32.self, codingPath,
                "Expected Int32 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int32(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int32.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int32")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int32.self, codingPath,
                "Expected to decode Int32 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeInt64(_ codingPath: [CodingKey]) throws -> Int64 {
        switch kind {
        case .null:
            throw valueNotFound(Int64.self, codingPath,
                "Expected Int64 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int64.self, codingPath,
                "Expected to decode Int64 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeUInt(_ codingPath: [CodingKey]) throws -> UInt {
        switch kind {
        case .null:
            throw valueNotFound(UInt.self, codingPath,
                "Expected UInt but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt.self, codingPath,
                "Expected to decode UInt but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeUInt8(_ codingPath: [CodingKey]) throws -> UInt8 {
        switch kind {
        case .null:
            throw valueNotFound(UInt8.self, codingPath,
                "Expected UInt8 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt8(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt8.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt8")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt8.self, codingPath,
                "Expected to decode UInt8 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeUInt16(_ codingPath: [CodingKey]) throws -> UInt16 {
        switch kind {
        case .null:
            throw valueNotFound(UInt16.self, codingPath,
                "Expected UInt16 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt16(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt16.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt16")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt16.self, codingPath,
                "Expected to decode UInt16 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeUInt32(_ codingPath: [CodingKey]) throws -> UInt32 {
        switch kind {
        case .null:
            throw valueNotFound(UInt32.self, codingPath,
                "Expected UInt32 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt32(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt32.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt32")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt32.self, codingPath,
                "Expected to decode UInt32 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeUInt64(_ codingPath: [CodingKey]) throws -> UInt64 {
        switch kind {
        case .null:
            throw valueNotFound(UInt64.self, codingPath,
                "Expected UInt64 but found JSONType.null instead.")
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt64.self, codingPath,
                "Expected to decode UInt64 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalBool(_ codingPath: [CodingKey]) throws -> Bool? {
        switch kind {
        case .null:
            return nil
        case .bool:
            let (result, code) = with(json_get_bool)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Bool.self, codingPath,
                "Expected to decode Bool but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalString(_ codingPath: [CodingKey]) throws -> String? {
        switch kind {
        case .null:
            return nil
        case .string:
            var code = JSONParseErrorCode.success
            var size: Int = 0
            let result = with { ref in
                json_get_string(ref, &size, &code)
            }
            if code == .success, let result = result.map(UnsafeMutablePointer.init(mutating:)) {
                let data = Data(bytesNoCopy: result, count: size, deallocator: .none)
                return String(data: data, encoding: .utf8) ?? ""
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(String.self, codingPath,
                "Expected to decode String but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalDouble(_ codingPath: [CodingKey]) throws -> Double? {
        switch kind {
        case .null:
            return nil
        case .double, .uint64, .int64:
            let (result, code) = with(json_get_double)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Double.self, codingPath,
                "Expected to decode Double but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalFloat(_ codingPath: [CodingKey]) throws -> Float? {
        switch kind {
        case .null:
            return nil
        case .double, .uint64, .int64:
            let (result, code) = with(json_get_double)
            if code == .success {
                return Float(result)
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Float.self, codingPath,
                "Expected to decode Float but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalInt(_ codingPath: [CodingKey]) throws -> Int? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int.self, codingPath,
                "Expected to decode Int but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalInt8(_ codingPath: [CodingKey]) throws -> Int8? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int8(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int8.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int8")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int8.self, codingPath,
                "Expected to decode Int8 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalInt16(_ codingPath: [CodingKey]) throws -> Int16? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int16(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int16.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int16")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int16.self, codingPath,
                "Expected to decode Int16 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalInt32(_ codingPath: [CodingKey]) throws -> Int32? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                if let result = Int32(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(Int32.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in Int32")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int32.self, codingPath,
                "Expected to decode Int32 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalInt64(_ codingPath: [CodingKey]) throws -> Int64? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_int64)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(Int64.self, codingPath,
                "Expected to decode Int64 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalUInt(_ codingPath: [CodingKey]) throws -> UInt? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt.self, codingPath,
                "Expected to decode UInt but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalUInt8(_ codingPath: [CodingKey]) throws -> UInt8? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt8(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt8.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt8")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt8.self, codingPath,
                "Expected to decode UInt8 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalUInt16(_ codingPath: [CodingKey]) throws -> UInt16? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt16(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt16.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt16")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt16.self, codingPath,
                "Expected to decode UInt16 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalUInt32(_ codingPath: [CodingKey]) throws -> UInt32? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                if let result = UInt32(exactly: result) {
                    return result
                } else {
                    throw typeMismatch(UInt32.self, codingPath,
                        "Parsed JSON number <\(result)> does not fit in UInt32")
                }
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt32.self, codingPath,
                "Expected to decode UInt32 but found \(description(of: value)) instead.")
        }
    }

    @_transparent
    func decodeOptionalUInt64(_ codingPath: [CodingKey]) throws -> UInt64? {
        switch kind {
        case .null:
            return nil
        case .uint64, .int64, .double:
            let (result, code) = with(json_get_uint64)
            if code == .success {
                return result
            } else {
                throw dataCorrupted(codingPath, message(of: code), JSONParseError(code: code))
            }
        default:
            throw typeMismatch(UInt64.self, codingPath,
                "Expected to decode UInt64 but found \(description(of: value)) instead.")
        }
    }
}

@inline(__always)
func description(of value: JSONValue) -> String {
    with(value) { ref in
        switch json_get_type(ref) {
        case .null:
            return "JSONType.null"
        case .bool:
            return "JSONType.bool"
        case .int64:
            return "JSONType.int64"
        case .uint64:
            return "JSONType.uint64"
        case .double:
            return "JSONType.double"
        case .object:
            return "JSONType.object"
        case .array:
            return "JSONType.array"
        case .string:
            return "JSONType.string"
        }
    }
}

@_transparent
func message(of value: JSONParseErrorCode) -> String {
    String(cString: json_error_message(value))
}

@_transparent
func with<Result>(_ value: JSONValue, _ method: (JSONValueRef) throws -> Result) rethrows -> Result {
    try withUnsafePointer(to: value) { (pointer: UnsafePointer<JSONValue>) -> Result in
        try method(UnsafeMutablePointer(mutating: pointer))
    }
}

@_transparent
func with<Result>(_ value: JSONArray, _ method: (JSONArrayRef) throws -> Result) rethrows -> Result {
    try withUnsafePointer(to: value) { (pointer: UnsafePointer<JSONArray>) -> Result in
        try method(UnsafeMutablePointer(mutating: pointer))
    }
}

@_transparent
func with<Result>(_ value: JSONObject, _ method: (JSONObjectRef) throws -> Result) rethrows -> Result {
    try withUnsafePointer(to: value) { (pointer: UnsafePointer<JSONObject>) -> Result in
        try method(UnsafeMutablePointer(mutating: pointer))
    }
}

@_transparent
func with<Result>(_ value: inout JSONValue, _ method: (JSONValueRef) throws -> Result) rethrows -> Result {
    try withUnsafePointer(to: &value) { (pointer: UnsafePointer<JSONValue>) -> Result in
        try method(UnsafeMutablePointer(mutating: pointer))
    }
}
