@frozen
public struct EmptyComponent: NothingComponent {
    public typealias Body = Never

    public func write(to stream: inout JSONStream) {
        // Do nothing.
    }
}
