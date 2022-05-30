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

extension JSON: Encodable {
    public func encode(to encoder: Encoder) throws {
        switch type {
        case .array:
            var container = encoder.unkeyedContainer()
            for item in array {
                try container.encode(item)
            }
        case .object:
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            for (key, value) in dictionary {
                try container.encode(value, forKey: .keyed(key))
            }
        case .int64:
            var container = encoder.singleValueContainer()
            try container.encode(int64)
        case .uint64:
            var container = encoder.singleValueContainer()
            try container.encode(uint64)
        case .double:
            var container = encoder.singleValueContainer()
            try container.encode(double)
        case .string:
            var container = encoder.singleValueContainer()
            try container.encode(string)
        case .bool:
            var container = encoder.singleValueContainer()
            try container.encode(bool)
        case .null:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}


extension JSON: JSONDecodable {
#if SWIFT_PACKAGE
    public convenience init(_ json: JSON) {
        self.init(storage: json.storage, value: json.value)
    }
#else
    public init(_ json: JSON) {
        self = json
    }
#endif
}

extension JSON: JSONEncodable {
    public func encode(to stream: inout JSONStream) {
        switch type {
        case .array:
            stream.beginArray()
            for item in array {
                item.encode(to: &stream)
            }
            stream.endArray()
        case .object:
            stream.beginObject()
            for (key, value) in dictionary {
                stream.keyed(key, value: value)
            }
            stream.endObject()
        case .int64:
            stream.value(int64)
        case .uint64:
            stream.value(uint64)
        case .double:
            stream.value(double)
        case .string:
            stream.value(string)
        case .bool:
            stream.value(bool)
        case .null:
            stream.null()
        }
    }
}
