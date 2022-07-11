import Foundation // Data

public typealias JSONCodable = JSONEncodable & JSONDecodable

public protocol JSONEncodable {
    func encode(to stream: inout JSONStream)
}

extension JSONEncodable {
    @inlinable
    public func encoded() -> Data {
        var stream = JSONStream()
        encode(to: &stream)
        return stream.finalize()
    }
}

extension Array: JSONEncodable where Element: JSONEncodable {
    @inlinable
    public func encode(to stream: inout JSONStream) {
        stream.beginArray()
        for item in self {
            item.encode(to: &stream)
        }
        stream.endArray()
    }
}

extension Dictionary: JSONEncodable where Key == String, Value: JSONEncodable {
    @inlinable
    public func encode(to stream: inout JSONStream) {
        stream.beginObject()
        for (key, value) in self {
            stream.keyed(key, value: value)
        }
        stream.endObject()
    }
}
