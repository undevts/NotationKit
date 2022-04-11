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

public typealias JSONCodable = JSONEncodable & JSONDecodable

public protocol JSONEncodable {
    func encode(to stream: inout JSONStream)
}

extension JSONEncodable {
    @inlinable
    public func encoded() -> Data {
        var stream = JSONStream()
        encode(to: &stream)
        return stream.finalize()
    }
}

extension Array: JSONEncodable where Element: JSONEncodable {
    @inlinable
    public func encode(to stream: inout JSONStream) {
        stream.beginArray()
        for item in self {
            item.encode(to: &stream)
        }
        stream.endArray()
    }
}

extension Dictionary: JSONEncodable where Key == String, Value: JSONEncodable {
    @inlinable
    public func encode(to stream: inout JSONStream) {
        stream.beginObject()
        for (key, value) in self {
            stream.write(key: key, value)
        }
        stream.endObject()
    }
}
