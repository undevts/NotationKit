@frozen
public struct List<Content>: Component where Content: Component {
    @usableFromInline
    let content: Content

    @inlinable
    public init(@JSONBuilder content: () -> Content) {
        self.content = content()
    }

#if JSON_BUILDER_SUPPORT_IOS_9
    public var body: JSONArray<Content> {
        JSONArray { content }
    }
#else
    public var body: some Component {
        JSONArray { content }
    }
#endif

    public func write(to stream: inout JSONStream) {
        body.write(to: &stream)
    }
}

extension List {
    @inlinable
    public init<Data, Item>(_ data: Data, item: @escaping (Data.Element) -> Item)
        where Content == ForEach<Data, Item>, Data: RandomAccessCollection, Item: Component {
        content = ForEach(data, content: item)
    }
}
