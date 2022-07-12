#if JSON_BUILDER_SUPPORT_IOS_9
@frozen
public struct WrapComponent<T>: NothingComponent where T: JSONEncodable {
    public typealias Body = Never

    let content: T

    public init(_ content: T) {
        self.content = content
    }

    public func write(to stream: inout JSONStream) {
        content.encode(to: &stream)
    }
}
#else
struct WrapComponent<T>: NothingComponent where T: JSONEncodable {
    typealias Body = Never

    let content: T

    init(_ content: T) {
        self.content = content
    }

    func write(to stream: inout JSONStream) {
        content.encode(to: &stream)
    }
}
#endif // JSON_BUILDER_SUPPORT_IOS_9
