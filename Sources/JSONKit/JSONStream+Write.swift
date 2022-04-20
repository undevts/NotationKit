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

extension JSONStream {
    @inlinable
    public mutating func write(_ value: Int) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: Int?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: Int) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: Int?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: Int) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: Int?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: Int32) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: Int32?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: Int32) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: Int32?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: Int32) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: Int32?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: Int64) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: Int64?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: Int64) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: Int64?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: Int64) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: Int64?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: UInt) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: UInt?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: UInt) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: UInt?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: UInt) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: UInt?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: UInt32) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: UInt32?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: UInt32) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: UInt32?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: UInt32) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: UInt32?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: UInt64) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: UInt64?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: UInt64) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: UInt64?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: UInt64) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: UInt64?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: Double) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: Double?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: Double) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: Double?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: Double) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: Double?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: Float) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: Float?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: Float) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: Float?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: Float) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: Float?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: Bool) {
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(optional value: Bool?) {
        if let value = value {
            writeValue(String(value))
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: Bool) {
        writeKey(key)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write(key: String, optional value: Bool?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: Bool) where Key: CodingKey {
        writeKey(key.stringValue)
        writeValue(String(value))
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: Bool?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            writeValue(String(value))
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(_ value: String) {
        pushValueState()
        write(byte: 0x22) // "
        write(raw: value)
        write(byte: 0x22) // "
    }

    @inlinable
    public mutating func write(optional value: String?) {
        if let value = value {
            pushValueState()
            write(byte: 0x22) // "
            write(raw: value)
            write(byte: 0x22) // "
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write(key: String, _ value: String) {
        writeKey(key)
        write(value)
    }

    @inlinable
    public mutating func write(key: String, optional value: String?) {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key>(key: Key, _ value: String) where Key: CodingKey {
        writeKey(key.stringValue)
        write(value)
    }

    @inlinable
    public mutating func write<Key>(key: Key, optional value: String?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            write(value)
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<T>(_ value: T) where T: JSONEncodable {
        value.encode(to: &self)
    }

    @inlinable
    public mutating func write<T>(optional value: T?) where T: JSONEncodable {
        if let value = value {
            value.encode(to: &self)
        } else if useNull {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<T>(key: String, _ value: T) where T: JSONEncodable {
        writeKey(key)
        value.encode(to: &self)
    }

    @inlinable
    public mutating func write<T>(key: String, optional value: T?) where T: JSONEncodable {
        guard value != nil || useNull else {
            return
        }
        writeKey(key)
        if let value = value {
            value.encode(to: &self)
        } else {
            writeNull()
        }
    }

    @inlinable
    public mutating func write<Key, T>(key: Key, _ value: T) where Key: CodingKey, T: JSONEncodable {
        writeKey(key.stringValue)
        value.encode(to: &self)
    }

    @inlinable
    public mutating func write<Key, T>(key: Key, optional value: T?) where Key: CodingKey, T: JSONEncodable {
        guard value != nil || useNull else {
            return
        }
        writeKey(key.stringValue)
        if let value = value {
            value.encode(to: &self)
        } else {
            writeNull()
        }
    }

}
