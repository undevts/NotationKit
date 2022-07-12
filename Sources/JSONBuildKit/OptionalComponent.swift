#if JSON_BUILDER_SUPPORT_IOS_9
@frozen
public struct OptionalComponent<T>: NothingComponent where T: Component {
    public typealias Body = Never

    let content: T?

    public init(content: T?) {
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        if let content = content {
            content.write(to: &stream)
        } else {
            // TODO: write null only needed.
            stream.null()
        }
    }
}
#else
struct OptionalComponent<T>: NothingComponent where T: Component {
    typealias Body = Never

    let content: T?

    func write(to stream: inout JSONStream) {
        if let content = content {
            content.write(to: &stream)
        } else {
            // TODO: write null only needed.
            stream.null()
        }
    }
}
#endif // JSON_BUILDER_SUPPORT_IOS_9
