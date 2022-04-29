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
@_exported import NotationCore
#endif

public struct AnyTypeNotation<Key> where Key: Hashable {
    private let content: [Key: Any]

    public init(_ content: [Key: Any]) {
        self.content = content
    }

    public func item(key: Key) -> AnyNotation {
        AnyNotation(content[key])
    }

    public subscript(key: Key) -> AnyNotation {
        AnyNotation(content[key])
    }

    public func item<T>(key: Key, as type: T.Type) -> T? {
        AnyNotation(content[key]).to(type)
    }

    public subscript<T>(key: Key, as type: T.Type) -> T? {
        AnyNotation(content[key]).to(type)
    }
}
