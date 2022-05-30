import Foundation

#if SWIFT_PACKAGE
@_exported import NotationCore
#endif

public struct AnyTypeNotation<Key> where Key: Hashable {
    private let content: [Key: Any]

    public init(_ content: [Key: Any]) {
        self.content = content
    }

    public func item(key: Key) -> AnyNotation {
        AnyNotation(content[key])
    }

    public subscript(key: Key) -> AnyNotation {
        AnyNotation(content[key])
    }

    public func item<T>(key: Key, as type: T.Type) -> T? {
        AnyNotation(content[key]).to(type)
    }

    public subscript<T>(key: Key, as type: T.Type) -> T? {
        AnyNotation(content[key]).to(type)
    }
}
