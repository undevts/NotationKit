import Foundation

#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct _Decoder: Decoder, JSONContainer {
    private let context: Context
    let value: JSONValue

    @inline(__always)
    var codingPath: [CodingKey] {
        context.codingPath
    }

    @inline(__always)
    var userInfo: [CodingUserInfoKey: Any] {
        context.userInfo
    }

    @inline(__always)
    var storage: JSONStorage {
        context.storage
    }

    @_transparent
    init(context: Context) {
        self.context = context
        value = context.storage.root
    }

    @_transparent
    init(context: Context, value: JSONValue) {
        self.context = context
        self.value = value
    }

    @inline(__always)
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        if type == Date.self {
            return try decodeDate() as! T
        }
        if type == Data.self {
            return try decodeData() as! T
        }
        return try T.init(from: self)
    }

    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
//        guard json_is_object(value) else {
//            throw typeMismatch(Dictionary<String, JSON>.self, codingPath,
//                "Expected to decode Dictionary<String, JSON> but found \(description(of: value)) instead.")
//        }
        return KeyedDecodingContainer(_KeyedDecodingContainer(context, value))
    }

    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
//        guard json_is_array(value) else {
//            throw typeMismatch(Array<JSON>.self, codingPath,
//                "Expected to decode Array<JSON> but found \(description(of: value)) instead.")
//        }
        return _UnkeyedDecodingContainer(context, value)
    }

    func singleValueContainer() throws -> SingleValueDecodingContainer {
        _SingleValueDecodingContainer(context, value)
    }

    struct Context {
        let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
        let dataDecodingStrategy: JSONDecoder.DataDecodingStrategy
        let nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy
        var userInfo: [CodingUserInfoKey: Any]
        var codingPath: [CodingKey]
        let storage: JSONStorage
        let cache = Cache()

        @inline(__always)
        func makeDecoder() -> _Decoder {
            _Decoder(context: self)
        }

        @inline(__always)
        func makeDecoder(_ value: JSONValue) -> _Decoder {
            _Decoder(context: self, value: value)
        }
    }

    class Cache {
        private var _formatter: Formatter?
        private var _format: ((String) -> Date?)?

        func iso8601Format(_ value: String) -> Date? {
            if let method = _format {
                return method(value)
            } else if #available(macOS 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
                let formatter = ISO8601DateFormatter()
                _formatter = formatter
                _format = formatter.date(from:)
                return formatter.date(from: value)
            } else {
                let formatter = DateFormatter()
                // TODO: Check DateFormatter
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
                _formatter = formatter
                _format = formatter.date(from:)
                return formatter.date(from: value)
            }
        }
    }
}

extension _Decoder {
    func decodeDate() throws -> Date {
        switch context.dateDecodingStrategy {
        case .secondsSince1970:
            let value = try SimdDecoder(self).decodeDouble(codingPath)
            return Date(timeIntervalSince1970: value)
        case .millisecondsSince1970:
            let value = try SimdDecoder(self).decodeDouble(codingPath)
            return Date(timeIntervalSince1970: value / 1000.0)
        case .iso8601:
            let value = try SimdDecoder(self).decodeString(codingPath)
            if let date = context.cache.iso8601Format(value) {
                return date
            } else {
                throw dataCorrupted(codingPath, "Date string does not match format expected by formatter.")
            }
        case let .formatted(formatter):
            let value = try SimdDecoder(self).decodeString(codingPath)
            if let date = formatter.date(from: value) {
                return date
            } else {
                throw dataCorrupted(codingPath, "Date string does not match format expected by formatter.")
            }
        case let .custom(method):
            return try method(self)
        case .deferredToDate:
            fallthrough
        @unknown default:
            return try Date(from: self)
        }
    }

    func decodeData() throws -> Data {
        switch context.dataDecodingStrategy {
        case .base64:
            let value = try SimdDecoder(self).decodeString(codingPath)
            if let data = Data(base64Encoded: value) {
                return data
            } else {
                throw dataCorrupted(codingPath, "Encountered Data is not valid Base64.")
            }
        case let .custom(method):
            return try method(self)
        case .deferredToData:
            fallthrough
        @unknown default:
            return try Data(from: self)
        }
    }
}

@_transparent
func valueNotFound(_ type: Any.Type, _ codingPath: [CodingKey], _ debugDescription: String) -> DecodingError {
    DecodingError.valueNotFound(type,
        DecodingError.Context(codingPath: codingPath, debugDescription: debugDescription))
}

@_transparent
func typeMismatch(_ type: Any.Type, _ codingPath: [CodingKey], _ debugDescription: String) -> DecodingError {
    DecodingError.typeMismatch(type,
        DecodingError.Context(codingPath: codingPath, debugDescription: debugDescription))
}

@_transparent
func keyNotFound(_ key: CodingKey, _ codingPath: [CodingKey], _ debugDescription: String) -> DecodingError {
    DecodingError.keyNotFound(key,
        DecodingError.Context(codingPath: codingPath, debugDescription: debugDescription))
}

@_transparent
func dataCorrupted(_ codingPath: [CodingKey], _ debugDescription: String) -> DecodingError {
    DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: debugDescription))
}

@_transparent
func dataCorrupted(_ codingPath: [CodingKey], _ debugDescription: String, _ error: JSONParseError) -> DecodingError {
    DecodingError.dataCorrupted(
        DecodingError.Context(codingPath: codingPath, debugDescription: debugDescription, underlyingError: error))
}
