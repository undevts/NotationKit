#if !JSON_BUILDER_SUPPORT_IOS_9
@frozen
@resultBuilder
@available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
public struct JSONBuilder {
    public static func buildBlock() -> EmptyComponent {
        EmptyComponent()
    }

    public static func buildBlock<T>(_ component: T) -> T {
        component
    }

    public static func buildBlock<T>(_ components: T...) -> some Component where T: Component {
        ArrayComponent(items: components)
    }

    public static func buildExpression<T>(_ element: T) -> T where T: Component {
        element
    }

    public static func buildExpression(_ element: Int) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Int32) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Int64) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: UInt) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: UInt32) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: UInt64) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Double) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Float) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: String) -> some Component {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Bool) -> some Component {
        ValueComponent(element)
    }

    public static func buildOptional<T>(first component: T?) -> some Component where T: Component {
        OptionalComponent(content: component)
    }

    public static func buildEither<T>(first component: T) -> T where T: Component {
        component
    }

    public static func buildEither<T>(second component: T) -> T where T: Component {
        component
    }

    public static func buildArray<T>(_ components: [T]) -> some Component where T: Component {
        ArrayComponent(items: components)
    }

    public static func buildLimitedAvailability<T>(_ component: T) -> T where T: Component {
        component
    }
}
#endif // JSON_BUILDER_SUPPORT_IOS_9
