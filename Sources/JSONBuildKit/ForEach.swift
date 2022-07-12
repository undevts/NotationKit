@frozen
public struct ForEach<Data, Content>: NothingComponent where Data: RandomAccessCollection, Content: Component {
    public typealias Body = Never

    let data: Data
    public let content: (Data.Element) -> Content

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

extension ForEach where Data == Range<Int> {
    // @_semantics("swiftui.requires_constant_range")
    public init(_ data: Range<Int>, content: @escaping (Int) -> Content) {
        self.data = data
        self.content = content
    }
}
