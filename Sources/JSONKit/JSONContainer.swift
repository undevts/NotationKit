#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

protocol JSONContainer {
    var storage: JSONStorage { get }
    var value: json_value { get }
}
