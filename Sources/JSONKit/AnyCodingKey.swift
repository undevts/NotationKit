@frozen
public enum AnyCodingKey: CodingKey, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral {
    case keyed(String)
    case unkeyed(Int)

    @inlinable
    public init(stringValue: String) {
        self = .keyed(stringValue)
    }

    @inlinable
    public init(intValue: Int) {
        self = .unkeyed(intValue)
    }

    @inlinable
    public init(stringLiteral value: String) {
        self = .keyed(value)
    }

    @inlinable
    public init(integerLiteral value: Int) {
        self = .unkeyed(value)
    }

    @inlinable
    public var stringValue: String {
        switch self {
        case let .keyed(key):
            return key
        case let .unkeyed(index):
            return String(index)
        }
    }

    @inlinable
    public var intValue: Int? {
        switch self {
        case .keyed:
            return nil
        case let .unkeyed(index):
            return index
        }
    }
}
