#if JSON_BUILDER_SUPPORT_IOS_9
@frozen
public struct ArrayComponent<T>: NothingComponent where T: Component {
    public typealias Body = Never

    let items: [T]

    public init(items: [T]) {
        self.items = items
    }

    public func write(to stream: inout JSONStream) {
        for item in items {
            item.write(to: &stream)
        }
    }
}
#else
struct ArrayComponent<T>: NothingComponent where T: Component {
    typealias Body = Never

    let items: [T]

    func write(to stream: inout JSONStream) {
        for item in items {
            item.write(to: &stream)
        }
    }
}
#endif // JSON_BUILDER_SUPPORT_IOS_9
