extension Never: Component {
    public var body: Never {
        fatalError("This component has no body")
    }
}

public protocol NothingComponent: Component where Body == Never {}

extension NothingComponent {
    public var body: Never {
        fatalError("This component has no body")
    }
}
