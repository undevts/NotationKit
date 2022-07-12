public protocol Component {
    associatedtype Body: Component

    @JSONBuilder var body: Body { get }

    func write(to stream: inout JSONStream)
}

extension Component {
    public func write(to stream: inout JSONStream) {
        let value = body
        if value is Never {
            return
        }
        value.write(to: &stream)
    }
}
