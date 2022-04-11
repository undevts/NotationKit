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

@frozen
public enum AnyCodingKey: CodingKey, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral {
    case keyed(String)
    case unkeyed(Int)

    @inlinable
    public init(stringValue: String) {
        self = .keyed(stringValue)
    }

    @inlinable
    public init(intValue: Int) {
        self = .unkeyed(intValue)
    }

    @inlinable
    public init(stringLiteral value: String) {
        self = .keyed(value)
    }

    @inlinable
    public init(integerLiteral value: Int) {
        self = .unkeyed(value)
    }

    @inlinable
    public var stringValue: String {
        switch self {
        case let .keyed(key):
            return key
        case let .unkeyed(index):
            return String(index)
        }
    }

    @inlinable
    public var intValue: Int? {
        switch self {
        case .keyed:
            return nil
        case let .unkeyed(index):
            return index
        }
    }
}
