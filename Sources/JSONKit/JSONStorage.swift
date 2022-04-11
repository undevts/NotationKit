// MIT License
//
// Copyright (c) 2022 Notation Kit Project Authors
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
