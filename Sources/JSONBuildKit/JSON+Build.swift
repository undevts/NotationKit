import Foundation

extension JSONStream {
    /// Creates a JSON data
    ///
    /// - Parameter content: The contents of the JSON to be build inside the context.
    @inlinable
    public mutating func build<Content>(@JSONBuilder content: @escaping () -> Content)
        where Content: Component {
        let value = content()
        value.write(to: &self)
    }

    @inlinable
    public mutating func buildArray<Content>(@JSONBuilder content: @escaping () -> Content)
        where Content: Component {
        let value = content()
        beginArray()
        value.write(to: &self)
        endArray()
    }

    @inlinable
    public mutating func buildObject<Content>(@JSONBuilder content: @escaping () -> Content)
        where Content: Component {
        let value = content()
        beginObject()
        value.write(to: &self)
        endObject()
    }
}

extension JSON {
    public static func build<Content>(@JSONBuilder content: @escaping () -> Content) -> Data
        where Content: Component {
        var stream = JSONStream()
        stream.build(content: content)
        return stream.finalize()
    }

    public static func buildArray<Content>(@JSONBuilder content: @escaping () -> Content) -> Data
        where Content: Component {
        var stream = JSONStream()
        stream.buildArray(content: content)
        return stream.finalize()
    }

    public static func buildObject<Content>(@JSONBuilder content: @escaping () -> Content) -> Data
        where Content: Component {
        var stream = JSONStream()
        stream.buildObject(content: content)
        return stream.finalize()
    }
}
