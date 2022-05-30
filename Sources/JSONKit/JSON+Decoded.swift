extension JSON {
    @inlinable
    public func decoded() -> Int {
        int
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> Int) -> Int {
        intValue ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> Int {
        item(key: key).int
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> Int where Key: CodingKey {
        item(key: key).int
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Int) -> Int where Key: CodingKey {
        item(key: key).intValue ?? `default`()
    }

    @inlinable
    public func decodedValue() -> Int? {
        intValue
    }

    @inlinable
    public func decodedValue(key: String) -> Int? {
        item(key: key).intValue
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> Int? where Key: CodingKey {
        item(key: key).intValue
    }

    @inlinable
    public func decoded() -> Int32 {
        int32
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> Int32) -> Int32 {
        int32Value ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> Int32 {
        item(key: key).int32
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> Int32 where Key: CodingKey {
        item(key: key).int32
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Int32) -> Int32 where Key: CodingKey {
        item(key: key).int32Value ?? `default`()
    }

    @inlinable
    public func decodedValue() -> Int32? {
        int32Value
    }

    @inlinable
    public func decodedValue(key: String) -> Int32? {
        item(key: key).int32Value
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> Int32? where Key: CodingKey {
        item(key: key).int32Value
    }

    @inlinable
    public func decoded() -> Int64 {
        int64
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> Int64) -> Int64 {
        int64Value ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> Int64 {
        item(key: key).int64
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> Int64 where Key: CodingKey {
        item(key: key).int64
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Int64) -> Int64 where Key: CodingKey {
        item(key: key).int64Value ?? `default`()
    }

    @inlinable
    public func decodedValue() -> Int64? {
        int64Value
    }

    @inlinable
    public func decodedValue(key: String) -> Int64? {
        item(key: key).int64Value
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> Int64? where Key: CodingKey {
        item(key: key).int64Value
    }

    @inlinable
    public func decoded() -> UInt {
        uint
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> UInt) -> UInt {
        uintValue ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> UInt {
        item(key: key).uint
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> UInt where Key: CodingKey {
        item(key: key).uint
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> UInt) -> UInt where Key: CodingKey {
        item(key: key).uintValue ?? `default`()
    }

    @inlinable
    public func decodedValue() -> UInt? {
        uintValue
    }

    @inlinable
    public func decodedValue(key: String) -> UInt? {
        item(key: key).uintValue
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> UInt? where Key: CodingKey {
        item(key: key).uintValue
    }

    @inlinable
    public func decoded() -> UInt32 {
        uint32
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> UInt32) -> UInt32 {
        uint32Value ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> UInt32 {
        item(key: key).uint32
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> UInt32 where Key: CodingKey {
        item(key: key).uint32
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> UInt32) -> UInt32 where Key: CodingKey {
        item(key: key).uint32Value ?? `default`()
    }

    @inlinable
    public func decodedValue() -> UInt32? {
        uint32Value
    }

    @inlinable
    public func decodedValue(key: String) -> UInt32? {
        item(key: key).uint32Value
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> UInt32? where Key: CodingKey {
        item(key: key).uint32Value
    }

    @inlinable
    public func decoded() -> UInt64 {
        uint64
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> UInt64) -> UInt64 {
        uint64Value ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> UInt64 {
        item(key: key).uint64
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> UInt64 where Key: CodingKey {
        item(key: key).uint64
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> UInt64) -> UInt64 where Key: CodingKey {
        item(key: key).uint64Value ?? `default`()
    }

    @inlinable
    public func decodedValue() -> UInt64? {
        uint64Value
    }

    @inlinable
    public func decodedValue(key: String) -> UInt64? {
        item(key: key).uint64Value
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> UInt64? where Key: CodingKey {
        item(key: key).uint64Value
    }

    @inlinable
    public func decoded() -> Double {
        double
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> Double) -> Double {
        doubleValue ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> Double {
        item(key: key).double
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> Double where Key: CodingKey {
        item(key: key).double
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Double) -> Double where Key: CodingKey {
        item(key: key).doubleValue ?? `default`()
    }

    @inlinable
    public func decodedValue() -> Double? {
        doubleValue
    }

    @inlinable
    public func decodedValue(key: String) -> Double? {
        item(key: key).doubleValue
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> Double? where Key: CodingKey {
        item(key: key).doubleValue
    }

    @inlinable
    public func decoded() -> Float {
        float
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> Float) -> Float {
        floatValue ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> Float {
        item(key: key).float
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> Float where Key: CodingKey {
        item(key: key).float
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Float) -> Float where Key: CodingKey {
        item(key: key).floatValue ?? `default`()
    }

    @inlinable
    public func decodedValue() -> Float? {
        floatValue
    }

    @inlinable
    public func decodedValue(key: String) -> Float? {
        item(key: key).floatValue
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> Float? where Key: CodingKey {
        item(key: key).floatValue
    }

    @inlinable
    public func decoded() -> Bool {
        bool
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> Bool) -> Bool {
        boolValue ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> Bool {
        item(key: key).bool
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> Bool where Key: CodingKey {
        item(key: key).bool
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Bool) -> Bool where Key: CodingKey {
        item(key: key).boolValue ?? `default`()
    }

    @inlinable
    public func decodedValue() -> Bool? {
        boolValue
    }

    @inlinable
    public func decodedValue(key: String) -> Bool? {
        item(key: key).boolValue
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> Bool? where Key: CodingKey {
        item(key: key).boolValue
    }

    @inlinable
    public func decoded() -> String {
        string
    }

    @inlinable
    public func decoded(`default`: @autoclosure () -> String) -> String {
        stringValue ?? `default`()
    }

    @inlinable
    public func decoded(key: String) -> String {
        item(key: key).string
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    @inlinable
    public func decoded<Key>(key: Key) -> String where Key: CodingKey {
        item(key: key).string
    }

    @inlinable
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> String) -> String where Key: CodingKey {
        item(key: key).stringValue ?? `default`()
    }

    @inlinable
    public func decodedValue() -> String? {
        stringValue
    }

    @inlinable
    public func decodedValue(key: String) -> String? {
        item(key: key).stringValue
    }

    @inlinable
    public func decodedValue<Key>(key: Key) -> String? where Key: CodingKey {
        item(key: key).stringValue
    }

    @inlinable
    public func decoded<T>() -> T where T: JSONDecodable {
        T.init(self)
    }

    @inlinable
    public func decoded<T>(as type: T.Type) -> T where T: JSONDecodable {
        T.init(self)
    }

    @inlinable
    public func decoded<T>(`default`: @autoclosure () -> T) -> T? where T: JSONFailable {
        T.init(self) ?? `default`()
    }

    @inlinable
    public func decoded<T>(key: String) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public func decoded<T>(key: String, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public func decoded<T>(key: String, `default`: @autoclosure () -> T) -> T? where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    @inlinable
    public func decoded<T, Key>(key: Key) -> T where T: JSONDecodable, Key: CodingKey {
        T.init(item(key: key))
    }

    @inlinable
    public func decoded<T, Key>(key: Key, as type: T.Type) -> T where T: JSONDecodable, Key: CodingKey {
        T.init(item(key: key))
    }

    @inlinable
    public func decoded<T, Key>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONFailable, Key: CodingKey {
        T.init(item(key: key)) ?? `default`()
    }

    @inlinable
    public func decodedValue<T>() -> T? where T: JSONFailable {
        T.init(self)
    }

    @inlinable
    public func decodedValue<T>(as type: T.Type) -> T? where T: JSONFailable {
        T.init(self)
    }

    @inlinable
    public func decodedValue<T>(key: String) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    @inlinable
    public func decodedValue<T>(key: String, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    @inlinable
    public func decodedValue<T, Key>(key: Key) -> T? where T: JSONFailable, Key: CodingKey {
        T.init(item(key: key))
    }

    @inlinable
    public func decodedValue<T, Key>(key: Key, as type: T.Type) -> T? where T: JSONFailable, Key: CodingKey {
        T.init(item(key: key))
    }

}
