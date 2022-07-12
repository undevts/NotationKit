@frozen
public struct JSONObject<Content>: NothingComponent where Content: Component {
    public typealias Body = Never

    let content: () -> Content

    public init(@JSONBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        let value = content()
        stream.beginObject()
        value.write(to: &stream)
        stream.endObject()
    }
}

@frozen
public struct JSONArray<Content>: NothingComponent where Content: Component {
    public typealias Body = Never

    let content: () -> Content

    public init(@JSONBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        let value = content()
        stream.beginArray()
        value.write(to: &stream)
        stream.endArray()
    }
}
