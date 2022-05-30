extension JSONStream {
    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: Int) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: Int?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: Int?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: Int) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: Int) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: Int?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: Int?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: Int) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: Int) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: Int?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: Int?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: Int32) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: Int32?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: Int32?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: Int32) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: Int32) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: Int32?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: Int32?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: Int32) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: Int32) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: Int32?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: Int32?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: Int64) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: Int64?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: Int64?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: Int64) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: Int64) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: Int64?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: Int64?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: Int64) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: Int64) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: Int64?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: Int64?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: UInt) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: UInt?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: UInt?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: UInt) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: UInt) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: UInt?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: UInt?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: UInt) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: UInt) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: UInt?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: UInt?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: UInt32) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: UInt32?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: UInt32?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: UInt32) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: UInt32) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: UInt32?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: UInt32?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: UInt32) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: UInt32) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: UInt32?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: UInt32?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: UInt64) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: UInt64?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: UInt64?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: UInt64) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: UInt64) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: UInt64?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: UInt64?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: UInt64) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: UInt64) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: UInt64?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: UInt64?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: Double) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: Double?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: Double?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: Double) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: Double) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: Double?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: Double?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: Double) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: Double) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: Double?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: Double?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: Float) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: Float?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: Float?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: Float) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: Float) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: Float?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: Float?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: Float) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: Float) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: Float?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: Float?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: Bool) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: Bool?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: Bool?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: Bool) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: Bool) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: Bool?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: Bool?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: Bool) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: Bool) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: Bool?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: Bool?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "value(_:)")
    public mutating func write(_ value: String) {
        self.value(value)
    }

    @inlinable
    public mutating func optional(_ value: String?) {
        if let value = value {
            self.value(value)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write(optional value: String?) {
        optional(value)
    }

    @inlinable
    public mutating func keyed(_ key: String, value: String) {
        self.key(key)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write(key: String, _ value: String) {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed(_ key: String, optional value: String?) {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write(key: String, optional value: String?) {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, value: String) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, _ value: String) where Key: CodingKey {
        self.key(key.stringValue)
        self.value(value)
    }

    @inlinable
    public mutating func keyed<Key>(_ key: Key, optional value: String?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key>(key: Key, optional value: String?) where Key: CodingKey {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            self.value(value)
        } else {
            null()
        }
    }

    @inlinable
    public mutating func write<T>(_ value: T) where T: JSONEncodable {
        value.encode(to: &self)
    }

    @inlinable
    public mutating func optional<T>(_ value: T?) where T: JSONEncodable {
        if let value = value {
            value.encode(to: &self)
        } else if inObjectValue || useNull {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "optional(_:)")
    public mutating func write<T>(optional value: T?) where T: JSONEncodable {
        optional(value)
    }

    @inlinable
    public mutating func keyed<T>(_ key: String, value: T) where T: JSONEncodable {
        self.key(key)
        value.encode(to: &self)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<T>(key: String, _ value: T) where T: JSONEncodable {
        keyed(key, value: value)
    }

    @inlinable
    public mutating func keyed<T>(_ key: String, optional value: T?) where T: JSONEncodable {
        guard value != nil || useNull else {
            return
        }
        self.key(key)
        if let value = value {
            value.encode(to: &self)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:optional:)")
    public mutating func write<T>(key: String, optional value: T?) where T: JSONEncodable {
        keyed(key, optional: value)
    }

    @inlinable
    public mutating func keyed<Key, T>(_ key: Key, value: T) where Key: CodingKey, T: JSONEncodable {
        self.key(key.stringValue)
        value.encode(to: &self)
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key, T>(key: Key, _ value: T) where Key: CodingKey, T: JSONEncodable {
        self.key(key.stringValue)
        value.encode(to: &self)
    }

    @inlinable
    public mutating func keyed<Key, T>(_ key: Key, optional value: T?) where Key: CodingKey, T: JSONEncodable {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            value.encode(to: &self)
        } else {
            null()
        }
    }

    @inlinable
    @available(*, unavailable, renamed: "keyed(_:value:)")
    public mutating func write<Key, T>(key: Key, optional value: T?) where Key: CodingKey, T: JSONEncodable {
        guard value != nil || useNull else {
            return
        }
        self.key(key.stringValue)
        if let value = value {
            value.encode(to: &self)
        } else {
            null()
        }
    }

}
