#if JSON_BUILDER_SUPPORT_IOS_9
@frozen
public struct ValueComponent: NothingComponent {
    public typealias Body = Never

    @usableFromInline
    let content: Content
}
#else
@frozen
struct ValueComponent: NothingComponent {
    typealias Body = Never

    let content: Content
}
#endif // JSON_BUILDER_SUPPORT_IOS_9

extension ValueComponent {
    @inlinable
    init(_ value: Int) {
#if arch(arm64) || arch(x86_64)
        content = .i64(Int64(value))
#else
        content = .i32(Int32(value))
#endif
    }

    @inlinable
    init(_ value: Int32) {
        content = .i32(value)
    }

    @inlinable
    init(_ value: Int64) {
        content = .i64(value)
    }

    @inlinable
    init(_ value: UInt) {
#if arch(arm64) || arch(x86_64)
        content = .u64(UInt64(value))
#else
        content = .u32(UInt32(value))
#endif
    }

    @inlinable
    init(_ value: UInt32) {
        content = .u32(value)
    }

    @inlinable
    init(_ value: UInt64) {
        content = .u64(value)
    }

    @inlinable
    init(_ value: Double) {
        content = .double(value)
    }

    @inlinable
    init(_ value: Float) {
        content = .float(value)
    }

    @inlinable
    init(_ value: String) {
        content = .string(value)
    }

    @inlinable
    init(_ value: Bool) {
        content = .bool(value)
    }

    public func write(to stream: inout JSONStream) {
        switch content {
        case let .i32(value):
            stream.value(value)
        case let .u32(value):
            stream.value(value)
        case let .i64(value):
            stream.value(value)
        case let .u64(value):
            stream.value(value)
        case let .bool(value):
            stream.value(value)
        case let .float(value):
            stream.value(value)
        case let .double(value):
            stream.value(value)
        case let .string(value):
            stream.value(value)
        }
    }

    @frozen
    @usableFromInline
    enum Content {
        case i32(Int32)
        case u32(UInt32)
        case i64(Int64)
        case u64(UInt64)
        case bool(Bool)
        case float(Float)
        case double(Double)
        case string(String)
    }
}
