extension JSON {
    /// Decodes a single value as `Int` type.
    /// - Seealso: ``int``
    /// - Returns: A value as `Int` type.
    @inlinable
    public func decoded() -> Int {
        int
    }

    /// Decodes a single value as `Int` type, or a provided default value.
    /// - Seealso: ``intValue``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `Int` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> Int) -> Int {
        intValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> Int {
        item(key: key).int
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> Int where Key: CodingKey {
        item(key: key).int
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Int) -> Int where Key: CodingKey {
        item(key: key).intValue ?? `default`()
    }

    /// Decodes a single value as `Optional<Int>` type.
    /// - Seealso: ``intValue``
    /// - Returns: A value as `Optional<Int>` type.
    @inlinable
    public func decodedValue() -> Int? {
        intValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> Int? {
        item(key: key).intValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> Int? where Key: CodingKey {
        item(key: key).intValue
    }

    /// Decodes a single value as `Int32` type.
    /// - Seealso: ``int32``
    /// - Returns: A value as `Int32` type.
    @inlinable
    public func decoded() -> Int32 {
        int32
    }

    /// Decodes a single value as `Int32` type, or a provided default value.
    /// - Seealso: ``int32Value``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `Int32` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> Int32) -> Int32 {
        int32Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> Int32 {
        item(key: key).int32
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> Int32 where Key: CodingKey {
        item(key: key).int32
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Int32) -> Int32 where Key: CodingKey {
        item(key: key).int32Value ?? `default`()
    }

    /// Decodes a single value as `Optional<Int32>` type.
    /// - Seealso: ``int32Value``
    /// - Returns: A value as `Optional<Int32>` type.
    @inlinable
    public func decodedValue() -> Int32? {
        int32Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> Int32? {
        item(key: key).int32Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> Int32? where Key: CodingKey {
        item(key: key).int32Value
    }

    /// Decodes a single value as `Int64` type.
    /// - Seealso: ``int64``
    /// - Returns: A value as `Int64` type.
    @inlinable
    public func decoded() -> Int64 {
        int64
    }

    /// Decodes a single value as `Int64` type, or a provided default value.
    /// - Seealso: ``int64Value``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `Int64` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> Int64) -> Int64 {
        int64Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> Int64 {
        item(key: key).int64
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> Int64 where Key: CodingKey {
        item(key: key).int64
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Int64) -> Int64 where Key: CodingKey {
        item(key: key).int64Value ?? `default`()
    }

    /// Decodes a single value as `Optional<Int64>` type.
    /// - Seealso: ``int64Value``
    /// - Returns: A value as `Optional<Int64>` type.
    @inlinable
    public func decodedValue() -> Int64? {
        int64Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> Int64? {
        item(key: key).int64Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> Int64? where Key: CodingKey {
        item(key: key).int64Value
    }

    /// Decodes a single value as `UInt` type.
    /// - Seealso: ``uint``
    /// - Returns: A value as `UInt` type.
    @inlinable
    public func decoded() -> UInt {
        uint
    }

    /// Decodes a single value as `UInt` type, or a provided default value.
    /// - Seealso: ``uintValue``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `UInt` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> UInt) -> UInt {
        uintValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> UInt {
        item(key: key).uint
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> UInt where Key: CodingKey {
        item(key: key).uint
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> UInt) -> UInt where Key: CodingKey {
        item(key: key).uintValue ?? `default`()
    }

    /// Decodes a single value as `Optional<UInt>` type.
    /// - Seealso: ``uintValue``
    /// - Returns: A value as `Optional<UInt>` type.
    @inlinable
    public func decodedValue() -> UInt? {
        uintValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> UInt? {
        item(key: key).uintValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> UInt? where Key: CodingKey {
        item(key: key).uintValue
    }

    /// Decodes a single value as `UInt32` type.
    /// - Seealso: ``uint32``
    /// - Returns: A value as `UInt32` type.
    @inlinable
    public func decoded() -> UInt32 {
        uint32
    }

    /// Decodes a single value as `UInt32` type, or a provided default value.
    /// - Seealso: ``uint32Value``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `UInt32` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> UInt32) -> UInt32 {
        uint32Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> UInt32 {
        item(key: key).uint32
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> UInt32 where Key: CodingKey {
        item(key: key).uint32
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> UInt32) -> UInt32 where Key: CodingKey {
        item(key: key).uint32Value ?? `default`()
    }

    /// Decodes a single value as `Optional<UInt32>` type.
    /// - Seealso: ``uint32Value``
    /// - Returns: A value as `Optional<UInt32>` type.
    @inlinable
    public func decodedValue() -> UInt32? {
        uint32Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> UInt32? {
        item(key: key).uint32Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> UInt32? where Key: CodingKey {
        item(key: key).uint32Value
    }

    /// Decodes a single value as `UInt64` type.
    /// - Seealso: ``uint64``
    /// - Returns: A value as `UInt64` type.
    @inlinable
    public func decoded() -> UInt64 {
        uint64
    }

    /// Decodes a single value as `UInt64` type, or a provided default value.
    /// - Seealso: ``uint64Value``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `UInt64` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> UInt64) -> UInt64 {
        uint64Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> UInt64 {
        item(key: key).uint64
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> UInt64 where Key: CodingKey {
        item(key: key).uint64
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> UInt64) -> UInt64 where Key: CodingKey {
        item(key: key).uint64Value ?? `default`()
    }

    /// Decodes a single value as `Optional<UInt64>` type.
    /// - Seealso: ``uint64Value``
    /// - Returns: A value as `Optional<UInt64>` type.
    @inlinable
    public func decodedValue() -> UInt64? {
        uint64Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> UInt64? {
        item(key: key).uint64Value
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> UInt64? where Key: CodingKey {
        item(key: key).uint64Value
    }

    /// Decodes a single value as `Double` type.
    /// - Seealso: ``double``
    /// - Returns: A value as `Double` type.
    @inlinable
    public func decoded() -> Double {
        double
    }

    /// Decodes a single value as `Double` type, or a provided default value.
    /// - Seealso: ``doubleValue``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `Double` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> Double) -> Double {
        doubleValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> Double {
        item(key: key).double
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> Double where Key: CodingKey {
        item(key: key).double
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Double) -> Double where Key: CodingKey {
        item(key: key).doubleValue ?? `default`()
    }

    /// Decodes a single value as `Optional<Double>` type.
    /// - Seealso: ``doubleValue``
    /// - Returns: A value as `Optional<Double>` type.
    @inlinable
    public func decodedValue() -> Double? {
        doubleValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> Double? {
        item(key: key).doubleValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> Double? where Key: CodingKey {
        item(key: key).doubleValue
    }

    /// Decodes a single value as `Float` type.
    /// - Seealso: ``float``
    /// - Returns: A value as `Float` type.
    @inlinable
    public func decoded() -> Float {
        float
    }

    /// Decodes a single value as `Float` type, or a provided default value.
    /// - Seealso: ``floatValue``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `Float` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> Float) -> Float {
        floatValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> Float {
        item(key: key).float
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> Float where Key: CodingKey {
        item(key: key).float
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Float) -> Float where Key: CodingKey {
        item(key: key).floatValue ?? `default`()
    }

    /// Decodes a single value as `Optional<Float>` type.
    /// - Seealso: ``floatValue``
    /// - Returns: A value as `Optional<Float>` type.
    @inlinable
    public func decodedValue() -> Float? {
        floatValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> Float? {
        item(key: key).floatValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> Float? where Key: CodingKey {
        item(key: key).floatValue
    }

    /// Decodes a single value as `Bool` type.
    /// - Seealso: ``bool``
    /// - Returns: A value as `Bool` type.
    @inlinable
    public func decoded() -> Bool {
        bool
    }

    /// Decodes a single value as `Bool` type, or a provided default value.
    /// - Seealso: ``boolValue``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `Bool` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> Bool) -> Bool {
        boolValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> Bool {
        item(key: key).bool
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> Bool where Key: CodingKey {
        item(key: key).bool
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> Bool) -> Bool where Key: CodingKey {
        item(key: key).boolValue ?? `default`()
    }

    /// Decodes a single value as `Optional<Bool>` type.
    /// - Seealso: ``boolValue``
    /// - Returns: A value as `Optional<Bool>` type.
    @inlinable
    public func decodedValue() -> Bool? {
        boolValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> Bool? {
        item(key: key).boolValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> Bool? where Key: CodingKey {
        item(key: key).boolValue
    }

    /// Decodes a single value as `String` type.
    /// - Seealso: ``string``
    /// - Returns: A value as `String` type.
    @inlinable
    public func decoded() -> String {
        string
    }

    /// Decodes a single value as `String` type, or a provided default value.
    /// - Seealso: ``stringValue``
    /// - Parameter `default`: A default value provided if such value is absent.
    /// - Returns: A value as `String` type.
    @inlinable
    public func decoded(`default`: @autoclosure () -> String) -> String {
        stringValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String) -> String {
        item(key: key).string
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded(key: String, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key) -> String where Key: CodingKey {
        item(key: key).string
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<Key>(key: Key, `default`: @autoclosure () -> String) -> String where Key: CodingKey {
        item(key: key).stringValue ?? `default`()
    }

    /// Decodes a single value as `Optional<String>` type.
    /// - Seealso: ``stringValue``
    /// - Returns: A value as `Optional<String>` type.
    @inlinable
    public func decodedValue() -> String? {
        stringValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue(key: String) -> String? {
        item(key: key).stringValue
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<Key>(key: Key) -> String? where Key: CodingKey {
        item(key: key).stringValue
    }

    /// Decodes a single value of the given type.
    /// - Returns: A value of the requested type.
    @inlinable
    public func decoded<T>() -> T where T: JSONDecodable {
        T.init(self)
    }

    /// Decodes a single value of the given type.
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type.
    @inlinable
    public func decoded<T>(as type: T.Type) -> T where T: JSONDecodable {
        T.init(self)
    }

    /// Decodes a single value of the given type.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value of the requested type.
    @inlinable
    public func decoded<T>(`default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(self) ?? `default`()
    }

    /// Decodes a single value of the given type.
    /// - Returns: A value of the requested type.
    @inlinable
    public func decoded<T>() throws -> T where T: JSONCreatable {
        try T.create(self).get()
    }
    
    /// Decodes a single value of the given type.
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type.
    @inlinable
    public func decoded<T>(as type: T.Type) throws -> T where T: JSONCreatable {
        try T.create(self).get()
    }
    
    /// Decodes a single value of the given type.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value of the requested type.
    @inlinable
    public func decoded<T>(`default`: @autoclosure () -> T) -> T where T: JSONCreatable {
        switch T.create(self) {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, `default`: @autoclosure () -> T) -> T where T: JSONCreatable {
        switch T.create(item(key: key)) {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T, Key>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONCreatable, Key: CodingKey {
        switch T.create(item(key: key)) {
        case let .success(value):
            return value
        case .failure:
            return `default`()
        }
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T>(key: String, `default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T, Key>(key: Key) -> T where T: JSONDecodable, Key: CodingKey {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T, Key>(key: Key, as type: T.Type) -> T where T: JSONDecodable, Key: CodingKey {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decoded<T, Key>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONFailable, Key: CodingKey {
        T.init(item(key: key)) ?? `default`()
    }

    /// Decodes a single value of the given type.
    /// - Seealso: ``decodedValue(as:)-4gwie``
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public func decodedValue<T>() -> T? where T: JSONFailable {
        T.init(self)
    }

    /// Decodes a single value of the given type.
    /// - Seealso: ``decodedValue()-6bbi3``
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public func decodedValue<T>(as type: T.Type) -> T? where T: JSONFailable {
        T.init(self)
    }

    /// Decodes a single value of the given type.
    /// - Seealso: ``decodedValue(as:)-2lc6z``
    /// - Returns: A resolved result contains the value or a decode error.
    @inlinable
    public func decodedValue<T>() -> Result<T, Error> where T: JSONCreatable {
        T.create(self)
    }
    
    /// Decodes a single value of the given type.
    /// - Seealso: ``decodedValue()-3itr4``
    /// - Returns: A resolved result contains the value or a decode error.
    @inlinable
    public func decodedValue<T>(as type: T.Type) -> Result<T, Error> where T: JSONCreatable {
        T.create(self)
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<T>(key: String) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<T>(key: String, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<T, Key>(key: Key) -> T? where T: JSONFailable, Key: CodingKey {
        T.init(item(key: key))
    }

    /// - Seealso: ``KeyedJSON``, ``StringKeyedJSON``
    @inlinable
    @available(*, deprecated, message: "use `StringKeyedJSON` or `KeyedJSON` instead.")
    public func decodedValue<T, Key>(key: Key, as type: T.Type) -> T? where T: JSONFailable, Key: CodingKey {
        T.init(item(key: key))
    }

}
