extension StringKeyedJSON {
    /// Decodes a value as `Int` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Int` type.
    @inlinable
    public mutating func decoded(key: String) -> Int {
        item(key: key).int
    }

    /// Decodes a value as `[Int]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Int]` type.
    @inlinable
    public mutating func decoded(key: String) -> [Int] {
        item(key: key).decoded(map: \.int)
    }

    /// Decodes a value as `[String: Int]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Int]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: Int] {
        item(key: key).decoded(map: \.int)
    }

    /// Decodes a value as `Int` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Int` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    /// Decodes a value as `Optional<Int>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Int>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> Int? {
        item(key: key).intValue
    }

    /// Decodes a value as `Int32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Int32` type.
    @inlinable
    public mutating func decoded(key: String) -> Int32 {
        item(key: key).int32
    }

    /// Decodes a value as `[Int32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Int32]` type.
    @inlinable
    public mutating func decoded(key: String) -> [Int32] {
        item(key: key).decoded(map: \.int32)
    }

    /// Decodes a value as `[String: Int32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Int32]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: Int32] {
        item(key: key).decoded(map: \.int32)
    }

    /// Decodes a value as `Int32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Int32` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    /// Decodes a value as `Optional<Int32>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Int32>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> Int32? {
        item(key: key).int32Value
    }

    /// Decodes a value as `Int64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Int64` type.
    @inlinable
    public mutating func decoded(key: String) -> Int64 {
        item(key: key).int64
    }

    /// Decodes a value as `[Int64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Int64]` type.
    @inlinable
    public mutating func decoded(key: String) -> [Int64] {
        item(key: key).decoded(map: \.int64)
    }

    /// Decodes a value as `[String: Int64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Int64]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: Int64] {
        item(key: key).decoded(map: \.int64)
    }

    /// Decodes a value as `Int64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Int64` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    /// Decodes a value as `Optional<Int64>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Int64>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> Int64? {
        item(key: key).int64Value
    }

    /// Decodes a value as `UInt` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `UInt` type.
    @inlinable
    public mutating func decoded(key: String) -> UInt {
        item(key: key).uint
    }

    /// Decodes a value as `[UInt]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[UInt]` type.
    @inlinable
    public mutating func decoded(key: String) -> [UInt] {
        item(key: key).decoded(map: \.uint)
    }

    /// Decodes a value as `[String: UInt]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: UInt]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: UInt] {
        item(key: key).decoded(map: \.uint)
    }

    /// Decodes a value as `UInt` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `UInt` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    /// Decodes a value as `Optional<UInt>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<UInt>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> UInt? {
        item(key: key).uintValue
    }

    /// Decodes a value as `UInt32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `UInt32` type.
    @inlinable
    public mutating func decoded(key: String) -> UInt32 {
        item(key: key).uint32
    }

    /// Decodes a value as `[UInt32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[UInt32]` type.
    @inlinable
    public mutating func decoded(key: String) -> [UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    /// Decodes a value as `[String: UInt32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: UInt32]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    /// Decodes a value as `UInt32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `UInt32` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    /// Decodes a value as `Optional<UInt32>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<UInt32>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> UInt32? {
        item(key: key).uint32Value
    }

    /// Decodes a value as `UInt64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `UInt64` type.
    @inlinable
    public mutating func decoded(key: String) -> UInt64 {
        item(key: key).uint64
    }

    /// Decodes a value as `[UInt64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[UInt64]` type.
    @inlinable
    public mutating func decoded(key: String) -> [UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    /// Decodes a value as `[String: UInt64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: UInt64]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    /// Decodes a value as `UInt64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `UInt64` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    /// Decodes a value as `Optional<UInt64>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<UInt64>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> UInt64? {
        item(key: key).uint64Value
    }

    /// Decodes a value as `Double` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Double` type.
    @inlinable
    public mutating func decoded(key: String) -> Double {
        item(key: key).double
    }

    /// Decodes a value as `[Double]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Double]` type.
    @inlinable
    public mutating func decoded(key: String) -> [Double] {
        item(key: key).decoded(map: \.double)
    }

    /// Decodes a value as `[String: Double]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Double]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: Double] {
        item(key: key).decoded(map: \.double)
    }

    /// Decodes a value as `Double` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Double` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    /// Decodes a value as `Optional<Double>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Double>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> Double? {
        item(key: key).doubleValue
    }

    /// Decodes a value as `Float` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Float` type.
    @inlinable
    public mutating func decoded(key: String) -> Float {
        item(key: key).float
    }

    /// Decodes a value as `[Float]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Float]` type.
    @inlinable
    public mutating func decoded(key: String) -> [Float] {
        item(key: key).decoded(map: \.float)
    }

    /// Decodes a value as `[String: Float]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Float]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: Float] {
        item(key: key).decoded(map: \.float)
    }

    /// Decodes a value as `Float` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Float` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    /// Decodes a value as `Optional<Float>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Float>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> Float? {
        item(key: key).floatValue
    }

    /// Decodes a value as `Bool` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Bool` type.
    @inlinable
    public mutating func decoded(key: String) -> Bool {
        item(key: key).bool
    }

    /// Decodes a value as `[Bool]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Bool]` type.
    @inlinable
    public mutating func decoded(key: String) -> [Bool] {
        item(key: key).decoded(map: \.bool)
    }

    /// Decodes a value as `[String: Bool]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Bool]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: Bool] {
        item(key: key).decoded(map: \.bool)
    }

    /// Decodes a value as `Bool` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Bool` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    /// Decodes a value as `Optional<Bool>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Bool>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> Bool? {
        item(key: key).boolValue
    }

    /// Decodes a value as `String` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `String` type.
    @inlinable
    public mutating func decoded(key: String) -> String {
        item(key: key).string
    }

    /// Decodes a value as `[String]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String] {
        item(key: key).decoded(map: \.string)
    }

    /// Decodes a value as `[String: String]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: String]` type.
    @inlinable
    public mutating func decoded(key: String) -> [String: String] {
        item(key: key).decoded(map: \.string)
    }

    /// Decodes a value as `String` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `String` type.
    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    /// Decodes a value as `Optional<String>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<String>` type.
    @inlinable
    public mutating func decodedValue(key: String) -> String? {
        item(key: key).stringValue
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value of the requested type.
    @inlinable
    public mutating func decoded<T>(key: String) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type.
    @inlinable
    public mutating func decoded<T>(key: String, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    /// Decodes an array containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:compactMap:)-7zb80``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: An array of the requested type.
    @inlinable
    public mutating func decoded<T>(key: String, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    /// Decodes an array containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:map:)-6qvyj``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: An array of the requested type.
    @inlinable
    public mutating func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }

    /// Decodes a dictionary containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:compactMap:)-5so5k``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: A dictionary of the requested type.
    @inlinable
    public mutating func decoded<T>(key: String, map method: (JSON) -> T) -> [String: T] {
        item(key: key).decoded(map: method)
    }

    /// Decodes a dictionary containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:map:)-lkle``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: A dictionary of the requested type.
    @inlinable
    public mutating func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [String: T] {
        item(key: key).decoded(compactMap: method)
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public mutating func decoded<T>(key: String, `default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public mutating func decodedValue<T>(key: String) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public mutating func decodedValue<T>(key: String, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

}

extension KeyedJSON {
    /// Decodes a value as `Int` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Int` type.
    @inlinable
    public mutating func decoded(key: Key) -> Int {
        item(key: key).int
    }

    /// Decodes a value as `[Int]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Int]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [Int] {
        item(key: key).decoded(map: \.int)
    }

    /// Decodes a value as `[String: Int]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Int]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: Int] {
        item(key: key).decoded(map: \.int)
    }

    /// Decodes a value as `Int` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Int` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    /// Decodes a value as `Optional<Int>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Int>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> Int? {
        item(key: key).intValue
    }

    /// Decodes a value as `Int32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Int32` type.
    @inlinable
    public mutating func decoded(key: Key) -> Int32 {
        item(key: key).int32
    }

    /// Decodes a value as `[Int32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Int32]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [Int32] {
        item(key: key).decoded(map: \.int32)
    }

    /// Decodes a value as `[String: Int32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Int32]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: Int32] {
        item(key: key).decoded(map: \.int32)
    }

    /// Decodes a value as `Int32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Int32` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    /// Decodes a value as `Optional<Int32>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Int32>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> Int32? {
        item(key: key).int32Value
    }

    /// Decodes a value as `Int64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Int64` type.
    @inlinable
    public mutating func decoded(key: Key) -> Int64 {
        item(key: key).int64
    }

    /// Decodes a value as `[Int64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Int64]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [Int64] {
        item(key: key).decoded(map: \.int64)
    }

    /// Decodes a value as `[String: Int64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Int64]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: Int64] {
        item(key: key).decoded(map: \.int64)
    }

    /// Decodes a value as `Int64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Int64` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    /// Decodes a value as `Optional<Int64>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Int64>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> Int64? {
        item(key: key).int64Value
    }

    /// Decodes a value as `UInt` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `UInt` type.
    @inlinable
    public mutating func decoded(key: Key) -> UInt {
        item(key: key).uint
    }

    /// Decodes a value as `[UInt]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[UInt]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [UInt] {
        item(key: key).decoded(map: \.uint)
    }

    /// Decodes a value as `[String: UInt]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: UInt]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: UInt] {
        item(key: key).decoded(map: \.uint)
    }

    /// Decodes a value as `UInt` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `UInt` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    /// Decodes a value as `Optional<UInt>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<UInt>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> UInt? {
        item(key: key).uintValue
    }

    /// Decodes a value as `UInt32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `UInt32` type.
    @inlinable
    public mutating func decoded(key: Key) -> UInt32 {
        item(key: key).uint32
    }

    /// Decodes a value as `[UInt32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[UInt32]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    /// Decodes a value as `[String: UInt32]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: UInt32]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    /// Decodes a value as `UInt32` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `UInt32` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    /// Decodes a value as `Optional<UInt32>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<UInt32>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> UInt32? {
        item(key: key).uint32Value
    }

    /// Decodes a value as `UInt64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `UInt64` type.
    @inlinable
    public mutating func decoded(key: Key) -> UInt64 {
        item(key: key).uint64
    }

    /// Decodes a value as `[UInt64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[UInt64]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    /// Decodes a value as `[String: UInt64]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: UInt64]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    /// Decodes a value as `UInt64` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `UInt64` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    /// Decodes a value as `Optional<UInt64>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<UInt64>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> UInt64? {
        item(key: key).uint64Value
    }

    /// Decodes a value as `Double` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Double` type.
    @inlinable
    public mutating func decoded(key: Key) -> Double {
        item(key: key).double
    }

    /// Decodes a value as `[Double]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Double]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [Double] {
        item(key: key).decoded(map: \.double)
    }

    /// Decodes a value as `[String: Double]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Double]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: Double] {
        item(key: key).decoded(map: \.double)
    }

    /// Decodes a value as `Double` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Double` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    /// Decodes a value as `Optional<Double>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Double>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> Double? {
        item(key: key).doubleValue
    }

    /// Decodes a value as `Float` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Float` type.
    @inlinable
    public mutating func decoded(key: Key) -> Float {
        item(key: key).float
    }

    /// Decodes a value as `[Float]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Float]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [Float] {
        item(key: key).decoded(map: \.float)
    }

    /// Decodes a value as `[String: Float]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Float]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: Float] {
        item(key: key).decoded(map: \.float)
    }

    /// Decodes a value as `Float` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Float` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    /// Decodes a value as `Optional<Float>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Float>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> Float? {
        item(key: key).floatValue
    }

    /// Decodes a value as `Bool` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Bool` type.
    @inlinable
    public mutating func decoded(key: Key) -> Bool {
        item(key: key).bool
    }

    /// Decodes a value as `[Bool]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[Bool]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [Bool] {
        item(key: key).decoded(map: \.bool)
    }

    /// Decodes a value as `[String: Bool]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: Bool]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: Bool] {
        item(key: key).decoded(map: \.bool)
    }

    /// Decodes a value as `Bool` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `Bool` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    /// Decodes a value as `Optional<Bool>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<Bool>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> Bool? {
        item(key: key).boolValue
    }

    /// Decodes a value as `String` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `String` type.
    @inlinable
    public mutating func decoded(key: Key) -> String {
        item(key: key).string
    }

    /// Decodes a value as `[String]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String] {
        item(key: key).decoded(map: \.string)
    }

    /// Decodes a value as `[String: String]` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `[String: String]` type.
    @inlinable
    public mutating func decoded(key: Key) -> [String: String] {
        item(key: key).decoded(map: \.string)
    }

    /// Decodes a value as `String` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value as `String` type.
    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    /// Decodes a value as `Optional<String>` type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value as `Optional<String>` type.
    @inlinable
    public mutating func decodedValue(key: Key) -> String? {
        item(key: key).stringValue
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value of the requested type.
    @inlinable
    public mutating func decoded<T>(key: Key) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type.
    @inlinable
    public mutating func decoded<T>(key: Key, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    /// Decodes an array containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:compactMap:)-7uuhm``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: An array of the requested type.
    @inlinable
    public mutating func decoded<T>(key: Key, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    /// Decodes an array containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:map:)-2x1dx``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: An array of the requested type.
    @inlinable
    public mutating func decoded<T>(key: Key, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }

    /// Decodes a dictionary containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:compactMap:)-5fwyn``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: A dictionary of the requested type.
    @inlinable
    public mutating func decoded<T>(key: Key, map method: (JSON) -> T) -> [String: T] {
        item(key: key).decoded(map: method)
    }

    /// Decodes a dictionary containing the results of mapping the given closure for the given key.
    /// - Seealso: ``decoded(key:map:)-5spsk``
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter method: A mapping closure.
    /// - Returns: A dictionary of the requested type.
    @inlinable
    public mutating func decoded<T>(key: Key, compactMap method: (JSON) -> T?) -> [String: T] {
        item(key: key).decoded(compactMap: method)
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter `default`: A default value provided if a decode error was encountered.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public mutating func decoded<T>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public mutating func decodedValue<T>(key: Key) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    /// Decodes a value of the given type for the given key.
    /// - Parameter key: The key that the decoded value is associated with.
    /// - Parameter type: The type to decode as.
    /// - Returns: A value of the requested type, or `nil` if a decode error was encountered.
    @inlinable
    public mutating func decodedValue<T>(key: Key, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

}
