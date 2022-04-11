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

#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct _SingleValueDecodingContainer: SingleValueDecodingContainer, JSONContainer {
    private var context: _Decoder.Context
    let value: JSONValue

    init(_ context: _Decoder.Context, _ value: JSONValue) {
        self.context = context
        self.value = value
    }

    var codingPath: [CodingKey] {
        context.codingPath
    }

    @inline(__always)
    var storage: JSONStorage {
        context.storage
    }

    func decodeNil() -> Bool {
        SimdDecoder(self).isNull
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try SimdDecoder(self).decodeBool(codingPath)
    }

    func decode(_ type: String.Type) throws -> String {
        try SimdDecoder(self).decodeString(codingPath)
    }

    func decode(_ type: Double.Type) throws -> Double {
        try SimdDecoder(self).decodeDouble(codingPath)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try SimdDecoder(self).decodeFloat(codingPath)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try SimdDecoder(self).decodeInt(codingPath)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try SimdDecoder(self).decodeInt8(codingPath)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try SimdDecoder(self).decodeInt16(codingPath)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try SimdDecoder(self).decodeInt32(codingPath)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try SimdDecoder(self).decodeInt64(codingPath)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try SimdDecoder(self).decodeUInt(codingPath)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try SimdDecoder(self).decodeUInt8(codingPath)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try SimdDecoder(self).decodeUInt16(codingPath)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try SimdDecoder(self).decodeUInt32(codingPath)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try SimdDecoder(self).decodeUInt64(codingPath)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        try context.makeDecoder().decode(type)
    }
}
