import Foundation

/// A type that can decode itself from an JSON representation.
public protocol JSONDecodable {
    /// Creates a new instance by decoding from the given ``JSON``.
    ///
    /// This initializer ignore any errors. if decoding errors important,
    ///  use ``JSONFailable`` or ``JSONCreatable`` instead.
    ///
    /// - Parameter json: The JSON data.
    init(_ json: JSON)
}

/// A type that can decode itself (or failed) from an JSON representation.
public protocol JSONFailable {
    init?(_ json: JSON)
}

public protocol JSONCreatable {
    static func create(_ json: JSON) -> Result<Self, Error>
}

extension Array: JSONDecodable where Element: JSONDecodable {
    /// Creates a new array by decoding from the given ``JSON``.
    ///
    /// Same as `json.decoded(map: Element.init)`
    ///
    /// - Parameter json: The JSON data.
    @inlinable
    public init(_ json: JSON) {
        self = json.decoded(map: Element.init)
    }
}

extension Array: JSONFailable where Element: JSONFailable {
    /// Creates a new array by decoding  (or failed) from the given ``JSON``.
    ///
    /// Same as `json.decoded(compactMap: Element.init)`
    ///
    /// - Parameter json: The JSON data.
    @inlinable
    public init?(_ json: JSON) {
        self = json.decoded(compactMap: Element.init)
    }
}

extension Dictionary: JSONDecodable where Key == String, Value: JSONDecodable {
    /// Creates a new dictionary by decoding from the given ``JSON``.
    ///
    /// Same as `json.decoded(map: Element.init)`
    ///
    /// - Parameter json: The JSON data.
    @inlinable
    public init(_ json: JSON) {
        self = json.decoded(map: Value.init)
    }
}

extension Dictionary: JSONFailable where Key == String, Value: JSONFailable {
    /// Creates a new dictionary by decoding  (or failed) from the given ``JSON``.
    ///
    /// Same as `json.decoded(compactMap: Value.init)`
    ///
    /// - Parameter json: The JSON data.
    @inlinable
    public init?(_ json: JSON) {
        self = json.decoded(compactMap: Value.init)
    }
}

extension JSON {
    @inlinable
    public func decoded<T>() -> Result<T, Error> where T: JSONCreatable {
        T.create(self)
    }

    @inlinable
    public func decoded<T>(`default`: @autoclosure () -> T) -> T where T: JSONCreatable {
        switch T.create(self) {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    @inlinable
    public func decoded<T>(key: String, `default`: @autoclosure () -> T) -> T where T: JSONCreatable {
        switch T.create(item(key: key)) {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    @inlinable
    public func decoded<T, Key>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONCreatable, Key: CodingKey {
        switch T.create(item(key: key)) {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    @inlinable
    public static func parse<T>(_ value: String) -> Result<T, JSONParseError> where T: JSONDecodable {
        parse(value).map(T.init)
    }

    @inlinable
    public static func parse<T>(_ data: Data) -> Result<T, JSONParseError> where T: JSONDecodable {
        parse(data).map(T.init)
    }

    @inlinable
    public static func parse<T>(_ value: String) -> Result<T?, JSONParseError> where T: JSONFailable {
        parse(value).map(T.init)
    }

    @inlinable
    public static func parse<T>(_ data: Data) -> Result<T?, JSONParseError> where T: JSONFailable {
        parse(data).map(T.init)
    }

    @inlinable
    public static func parse<T>(_ value: String) -> Result<T, Error> where T: JSONCreatable {
        switch parse(value) {
        case let .success(json):
            return T.create(json)
        case let .failure(error):
            return .failure(error)
        }
    }

    @inlinable
    public static func parse<T>(_ data: Data) -> Result<T, Error> where T: JSONCreatable {
        switch parse(data) {
        case let .success(json):
            return T.create(json)
        case let .failure(error):
            return .failure(error)
        }
    }

    @inlinable
    public static func parse<T>(_ value: String, as type: T.Type) -> Result<T, JSONParseError> where T: JSONDecodable {
        parse(value)
    }

    @inlinable
    public static func parse<T>(_ data: Data, as type: T.Type) -> Result<T, JSONParseError> where T: JSONDecodable {
        parse(data)
    }

    @inlinable
    public static func parse<T>(_ value: String, as type: T.Type) -> Result<T?, JSONParseError> where T: JSONFailable {
        parse(value)
    }

    @inlinable
    public static func parse<T>(_ data: Data, as type: T.Type) -> Result<T?, JSONParseError> where T: JSONFailable {
        parse(data)
    }

    @inlinable
    public static func parse<T>(_ value: String, as type: T.Type) -> Result<T, Error> where T: JSONCreatable {
        parse(value)
    }

    @inlinable
    public static func parse<T>(_ data: Data, as type: T.Type) -> Result<T, Error> where T: JSONCreatable {
        parse(data)
    }
}
