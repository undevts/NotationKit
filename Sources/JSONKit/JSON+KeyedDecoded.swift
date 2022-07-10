extension StringKeyedJSON {
    @inlinable
    public func decoded(key: String) -> Int {
        item(key: key).int
    }

    @inlinable
    public func decoded(key: String, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: String) -> Int? {
        item(key: key).intValue
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
    public func decodedValue(key: String) -> Int32? {
        item(key: key).int32Value
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
    public func decodedValue(key: String) -> Int64? {
        item(key: key).int64Value
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
    public func decodedValue(key: String) -> UInt? {
        item(key: key).uintValue
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
    public func decodedValue(key: String) -> UInt32? {
        item(key: key).uint32Value
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
    public func decodedValue(key: String) -> UInt64? {
        item(key: key).uint64Value
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
    public func decodedValue(key: String) -> Double? {
        item(key: key).doubleValue
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
    public func decodedValue(key: String) -> Float? {
        item(key: key).floatValue
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
    public func decodedValue(key: String) -> Bool? {
        item(key: key).boolValue
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
    public func decodedValue(key: String) -> String? {
        item(key: key).stringValue
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
    public func decodedValue<T>(key: String) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    @inlinable
    public func decodedValue<T>(key: String, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

}

extension KeyedJSON {
    @inlinable
    public func decoded(key: Key) -> Int {
        item(key: key).int
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> Int? {
        item(key: key).intValue
    }

    @inlinable
    public func decoded(key: Key) -> Int32 {
        item(key: key).int32
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> Int32? {
        item(key: key).int32Value
    }

    @inlinable
    public func decoded(key: Key) -> Int64 {
        item(key: key).int64
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> Int64? {
        item(key: key).int64Value
    }

    @inlinable
    public func decoded(key: Key) -> UInt {
        item(key: key).uint
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> UInt? {
        item(key: key).uintValue
    }

    @inlinable
    public func decoded(key: Key) -> UInt32 {
        item(key: key).uint32
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> UInt32? {
        item(key: key).uint32Value
    }

    @inlinable
    public func decoded(key: Key) -> UInt64 {
        item(key: key).uint64
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> UInt64? {
        item(key: key).uint64Value
    }

    @inlinable
    public func decoded(key: Key) -> Double {
        item(key: key).double
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> Double? {
        item(key: key).doubleValue
    }

    @inlinable
    public func decoded(key: Key) -> Float {
        item(key: key).float
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> Float? {
        item(key: key).floatValue
    }

    @inlinable
    public func decoded(key: Key) -> Bool {
        item(key: key).bool
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> Bool? {
        item(key: key).boolValue
    }

    @inlinable
    public func decoded(key: Key) -> String {
        item(key: key).string
    }

    @inlinable
    public func decoded(key: Key, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    @inlinable
    public func decodedValue(key: Key) -> String? {
        item(key: key).stringValue
    }

    @inlinable
    public func decoded<T>(key: Key) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public func decoded<T>(key: Key, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public func decoded<T>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    @inlinable
    public func decodedValue<T>(key: Key) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    @inlinable
    public func decodedValue<T>(key: Key, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

}
