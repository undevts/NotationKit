@frozen
public struct Map<Content>: Component where Content: Component {
    @usableFromInline
    let content: () -> Content

    @inlinable
    public init(@JSONBuilder content: () -> Content) {
        let result = content()
        self.content = { result }
    }

#if JSON_BUILDER_SUPPORT_IOS_9
    public var body: JSONObject<Content> {
        JSONObject(content: content)
    }
#else
    public var body: some Component {
        JSONObject(content: content)
    }
#endif

    public func write(to stream: inout JSONStream) {
        body.write(to: &stream)
    }
}

@frozen
public struct KeyedForEach<Key, Value, Content>: NothingComponent where Key: Hashable, Content: Component {
    public typealias Data = [Key: Value]
    public typealias Body = Never

    @usableFromInline
    let data: Data
    @usableFromInline
    let content: (Data.Element) -> Content

    @inlinable
    public init(_ data: Data, @JSONBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        for item in data {
            let value = content(item)
            value.write(to: &stream)
        }
    }
}

extension KeyedForEach where Key == String {
    @inlinable
    public init<Item>(_ data: Data, @JSONBuilder content: @escaping (Value) -> Item)
        where Item: Component, Content == Keyed<Item> {
        self.data = data
        self.content = { pair in
            Keyed(pair.key) { () -> Item in
                content(pair.value)
            }
        }
    }
}

extension Map {
    public init<Key, Value, Item>(_ data: [Key: Value], item: @escaping ((key: Key, value: Value)) -> Item)
        where Content == KeyedForEach<Key, Value, Item>, Item: Component {
        self.init {
            KeyedForEach(data, content: item)
        }
    }

    public init<Value, Item>(_ data: [String: Value], @JSONBuilder item: @escaping (Value) -> Item)
        where Content == KeyedForEach<String, Value, Keyed<Item>>, Item: Component {
        self.init {
            KeyedForEach(data, content: item)
        }
    }
}
