@frozen
public struct CodingKeyed<Key, Content>: NothingComponent where Key: CodingKey, Content: Component {
    public typealias Body = Never

    let key: Key
    public let content: () -> Content

    public init(_ key: Key, @JSONBuilder content: @escaping () -> Content) {
        self.key = key
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        stream.key(key)
        let value = content()
        value.write(to: &stream)
    }
}

extension CodingKeyed where Content == ValueComponent {
    public init(_ key: Key, value: @autoclosure () -> Int) {
        self.key = key
#if arch(arm64) || arch(x86_64)
        let content = ValueComponent.Content.i64(Int64(value()))
#else
        let content = ValueComponent.Content.i32(Int32(value()))
#endif
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> Int32) {
        self.key = key
        let content = ValueComponent.Content.i32(Int32(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> Int64) {
        self.key = key
        let content = ValueComponent.Content.i64(Int64(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> UInt) {
        self.key = key
#if arch(arm64) || arch(x86_64)
        let content = ValueComponent.Content.u64(UInt64(value()))
#else
        let content = ValueComponent.Content.u32(UInt32(value()))
#endif
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> UInt32) {
        self.key = key
        let content = ValueComponent.Content.u32(UInt32(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> UInt64) {
        self.key = key
        let content = ValueComponent.Content.u64(UInt64(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> Float) {
        self.key = key
        let content = ValueComponent.Content.float(value())
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> Double) {
        self.key = key
        let content = ValueComponent.Content.double(value())
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> Bool) {
        self.key = key
        let content = ValueComponent.Content.bool(value())
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: Key, value: @autoclosure () -> String) {
        self.key = key
        let content = ValueComponent.Content.string(value())
        self.content = {
            ValueComponent(content: content)
        }
    }
}

@frozen
public struct Keys<Key> where Key: CodingKey {
    @_transparent
    public init(of type: Key.Type) {
        // Do nothings.
    }

    public func value(_ value: Int, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: Int32, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: Int64, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: UInt, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: UInt32, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: UInt64, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: Double, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: Float, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: Bool, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value(_ value: String, key: Key) -> CodingKeyed<Key, ValueComponent> {
        CodingKeyed(key, value: value)
    }

    public func value<Content>(key: Key, @JSONBuilder content: @escaping () -> Content)
        -> CodingKeyed<Key, Content> where Content: Component {
        CodingKeyed(key, content: content)
    }
}
