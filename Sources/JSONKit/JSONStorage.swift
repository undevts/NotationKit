import Foundation

#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

@usableFromInline
final class JSONStorage {
    var ref: JSONRef

    @inline(__always)
    var root: JSONValue {
        var out = JSONValue()
        json_get_root(ref, &out)
        return out
    }

    @inline(__always)
    init(ref: JSONRef) {
        self.ref = ref
    }

    deinit {
        json_free(ref)
    }

    @usableFromInline
    static func parse(_ value: String) -> Result<JSONStorage, JSONParseError> {
        value.withCString { (buffer: UnsafePointer<Int8>) -> Result<JSONStorage, JSONParseError> in
            let input = json_input_create(buffer)
            var code = JSONParseErrorCode.success
            let ref = json_parse_string(input, &code)
            json_input_free(input)
            if code == .success, let ref = ref {
                return .success(JSONStorage(ref: ref))
            } else {
                return .failure(JSONParseError(code: code))
            }
        }
    }

    @usableFromInline
    static func parse(_ data: Data) -> Result<JSONStorage, JSONParseError> {
        var input = data
        let count = data.count
        input.reserveCapacity(count + NK_JSON_DATA_PADDING)
        return input.withUnsafeBytes { (pointer: UnsafeRawBufferPointer) -> Result<JSONStorage, JSONParseError> in
            guard let buffer = pointer.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                return .failure(JSONParseError(code: .tape))
            }
            var code = JSONParseErrorCode.success
            let ref = json_parse_data(buffer, count, &code)
            if code == .success, let ref = ref {
                return .success(JSONStorage(ref: ref))
            } else {
                return .failure(JSONParseError(code: code))
            }
        }
    }
}
