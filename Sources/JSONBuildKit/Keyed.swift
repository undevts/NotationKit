@frozen
public struct Keyed<Content>: NothingComponent where Content: Component {
    public typealias Body = Never

    let key: String
    public let content: () -> Content

    public init(_ key: String, @JSONBuilder content: @escaping () -> Content) {
        self.key = key
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        stream.key(key)
        let value = content()
        value.write(to: &stream)
    }
}

extension Keyed where Content == ValueComponent {
    public init(_ key: String, value: @autoclosure () -> Int) {
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

    public init(_ key: String, value: @autoclosure () -> Int32) {
        self.key = key
        let content = ValueComponent.Content.i32(Int32(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> Int64) {
        self.key = key
        let content = ValueComponent.Content.i64(Int64(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> UInt) {
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

    public init(_ key: String, value: @autoclosure () -> UInt32) {
        self.key = key
        let content = ValueComponent.Content.u32(UInt32(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> UInt64) {
        self.key = key
        let content = ValueComponent.Content.u64(UInt64(value()))
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> Float) {
        self.key = key
        let content = ValueComponent.Content.float(value())
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> Double) {
        self.key = key
        let content = ValueComponent.Content.double(value())
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> Bool) {
        self.key = key
        let content = ValueComponent.Content.bool(value())
        self.content = {
            ValueComponent(content: content)
        }
    }

    public init(_ key: String, value: @autoclosure () -> String) {
        self.key = key
        let content = ValueComponent.Content.string(value())
        self.content = {
            ValueComponent(content: content)
        }
    }
}
