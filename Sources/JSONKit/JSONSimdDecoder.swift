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

#if START_JSON_ENABLE_COMBINE && canImport(Combine)
import Combine
#endif

/// A drop-in replacement for the ``Swift.JSONDecoder``,
/// powered by [simd-json](https://github.com/simdjson/simdjson).
///
/// - Note: There is no support of ``Swift.JSONDecoder.KeyDecodingStrategy``.
public final class JSONSimdDecoder {
    /// The strategy to use in decoding dates.
    /// Defaults to ``Swift.JSONDecoder.DateDecodingStrategy.deferredToDate``.
    public var dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.deferredToDate

    /// The strategy to use in decoding binary data.
    /// Defaults to ``Swift.JSONDecoder.DataDecodingStrategy.base64``.
    public var dataDecodingStrategy = JSONDecoder.DataDecodingStrategy.base64

    /// The strategy to use in decoding non-conforming numbers.
    /// Defaults to ``Swift.JSONDecoder.NonConformingFloatDecodingStrategy.throw``.
    public var nonConformingFloatDecodingStrategy = JSONDecoder.NonConformingFloatDecodingStrategy.throw

    /// Contextual user-provided information for use during decoding.
    public var userInfo: [CodingUserInfoKey: Any] = [:]

    /// Creates a new, reusable JSON decoder with the default formatting settings and decoding strategies.
#if JSON_BUILD_FOR_EVOLUTION
    public init() {
        // Do nothing.
    }
#else
    @inlinable
    public init() {
        // Do nothing.
    }
#endif

    /// Returns a value of the type you specify, decoded from a JSON object.
    ///
    /// - Parameter data: The JSON object to decode.
    /// - Returns: A value of the specified type, if the decoder can parse the data.
    /// - Throws: ``JSONParseError`` or ``Swift.DecodingError``.
    @inlinable
    public func decode<T>(from data: Data) throws -> T where T: Decodable {
        let storage = try JSONStorage.parse(data).get()
        return try decode(T.self, storage: storage)
    }

    /// Returns a value of the type you specify, decoded from a JSON object.
    ///
    /// - Parameters:
    ///   - type: The type of the value to decode from the supplied JSON object.
    ///   - data: The JSON object to decode.
    /// - Returns: A value of the specified type, if the decoder can parse the data.
    /// - Throws: ``JSONParseError`` or ``Swift.DecodingError``.
    @inlinable
    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        let storage = try JSONStorage.parse(data).get()
        return try decode(type, storage: storage)
    }

    @inline(__always)
    @usableFromInline
    func decode<T>(_ type: T.Type, storage: JSONStorage) throws -> T where T: Decodable {
        let context = makeContext(storage: storage)
        let decoder = _Decoder(context: context)
        return try decoder.decode(type)
    }

    @inline(__always)
    private func makeContext(storage: JSONStorage) -> _Decoder.Context {
        _Decoder.Context(dateDecodingStrategy: dateDecodingStrategy,
            dataDecodingStrategy: dataDecodingStrategy,
            nonConformingFloatDecodingStrategy: nonConformingFloatDecodingStrategy,
            userInfo: userInfo,
            codingPath: [],
            storage: storage)
    }
}

#if START_JSON_ENABLE_COMBINE && canImport(Combine)
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension JSONSimdDecoder: TopLevelDecoder {
    public typealias Input = Data
}
#endif
