#if JSON_BUILDER_SUPPORT_IOS_9
@frozen
@resultBuilder
public struct JSONBuilder {
    public static func buildBlock() -> EmptyComponent {
        EmptyComponent()
    }

    public static func buildBlock<T>(_ component: T) -> T {
        component
    }

    public static func buildBlock<T>(_ components: T...) -> ArrayComponent<T> where T: Component {
        ArrayComponent(items: components)
    }

    public static func buildExpression<T>(_ element: T) -> T where T: Component {
        element
    }

    public static func buildExpression(_ element: Int) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Int32) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Int64) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: UInt) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: UInt32) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: UInt64) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Double) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Float) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: String) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildExpression(_ element: Bool) -> ValueComponent {
        ValueComponent(element)
    }

    public static func buildOptional<T>(first component: T?) -> OptionalComponent<T> where T: Component {
        OptionalComponent(content: component)
    }

    public static func buildEither<T>(first component: T) -> T where T: Component {
        component
    }

    public static func buildEither<T>(second component: T) -> T where T: Component {
        component
    }

    public static func buildArray<T>(_ components: [T]) -> ArrayComponent<T> where T: Component {
        ArrayComponent(items: components)
    }

    public static func buildLimitedAvailability<T>(_ component: T) -> T where T: Component {
        component
    }
}
#endif // JSON_BUILDER_SUPPORT_IOS_9
