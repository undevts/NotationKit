extension StringKeyedJSON {
    @inlinable
    public mutating func decoded(key: String) -> Int {
        item(key: key).int
    }

    @inlinable
    public mutating func decoded(key: String) -> [Int] {
        item(key: key).decoded(map: \.int)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: Int] {
        item(key: key).decoded(map: \.int)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> Int? {
        item(key: key).intValue
    }

    @inlinable
    public mutating func decoded(key: String) -> Int32 {
        item(key: key).int32
    }

    @inlinable
    public mutating func decoded(key: String) -> [Int32] {
        item(key: key).decoded(map: \.int32)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: Int32] {
        item(key: key).decoded(map: \.int32)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> Int32? {
        item(key: key).int32Value
    }

    @inlinable
    public mutating func decoded(key: String) -> Int64 {
        item(key: key).int64
    }

    @inlinable
    public mutating func decoded(key: String) -> [Int64] {
        item(key: key).decoded(map: \.int64)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: Int64] {
        item(key: key).decoded(map: \.int64)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> Int64? {
        item(key: key).int64Value
    }

    @inlinable
    public mutating func decoded(key: String) -> UInt {
        item(key: key).uint
    }

    @inlinable
    public mutating func decoded(key: String) -> [UInt] {
        item(key: key).decoded(map: \.uint)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: UInt] {
        item(key: key).decoded(map: \.uint)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> UInt? {
        item(key: key).uintValue
    }

    @inlinable
    public mutating func decoded(key: String) -> UInt32 {
        item(key: key).uint32
    }

    @inlinable
    public mutating func decoded(key: String) -> [UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> UInt32? {
        item(key: key).uint32Value
    }

    @inlinable
    public mutating func decoded(key: String) -> UInt64 {
        item(key: key).uint64
    }

    @inlinable
    public mutating func decoded(key: String) -> [UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> UInt64? {
        item(key: key).uint64Value
    }

    @inlinable
    public mutating func decoded(key: String) -> Double {
        item(key: key).double
    }

    @inlinable
    public mutating func decoded(key: String) -> [Double] {
        item(key: key).decoded(map: \.double)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: Double] {
        item(key: key).decoded(map: \.double)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> Double? {
        item(key: key).doubleValue
    }

    @inlinable
    public mutating func decoded(key: String) -> Float {
        item(key: key).float
    }

    @inlinable
    public mutating func decoded(key: String) -> [Float] {
        item(key: key).decoded(map: \.float)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: Float] {
        item(key: key).decoded(map: \.float)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> Float? {
        item(key: key).floatValue
    }

    @inlinable
    public mutating func decoded(key: String) -> Bool {
        item(key: key).bool
    }

    @inlinable
    public mutating func decoded(key: String) -> [Bool] {
        item(key: key).decoded(map: \.bool)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: Bool] {
        item(key: key).decoded(map: \.bool)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> Bool? {
        item(key: key).boolValue
    }

    @inlinable
    public mutating func decoded(key: String) -> String {
        item(key: key).string
    }

    @inlinable
    public mutating func decoded(key: String) -> [String] {
        item(key: key).decoded(map: \.string)
    }

    @inlinable
    public mutating func decoded(key: String) -> [String: String] {
        item(key: key).decoded(map: \.string)
    }

    @inlinable
    public mutating func decoded(key: String, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: String) -> String? {
        item(key: key).stringValue
    }

    @inlinable
    public mutating func decoded<T>(key: String) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public mutating func decoded<T>(key: String, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public mutating func decoded<T>(key: String, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public mutating func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    public mutating func decoded<T>(key: String, map method: (JSON) -> T) -> [String: T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public mutating func decoded<T>(key: String, compactMap method: (JSON) -> T?) -> [String: T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    public mutating func decoded<T>(key: String, `default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    @inlinable
    public mutating func decodedValue<T>(key: String) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    @inlinable
    public mutating func decodedValue<T>(key: String, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

}

extension KeyedJSON {
    @inlinable
    public mutating func decoded(key: Key) -> Int {
        item(key: key).int
    }

    @inlinable
    public mutating func decoded(key: Key) -> [Int] {
        item(key: key).decoded(map: \.int)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: Int] {
        item(key: key).decoded(map: \.int)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Int) -> Int {
        item(key: key).intValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> Int? {
        item(key: key).intValue
    }

    @inlinable
    public mutating func decoded(key: Key) -> Int32 {
        item(key: key).int32
    }

    @inlinable
    public mutating func decoded(key: Key) -> [Int32] {
        item(key: key).decoded(map: \.int32)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: Int32] {
        item(key: key).decoded(map: \.int32)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Int32) -> Int32 {
        item(key: key).int32Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> Int32? {
        item(key: key).int32Value
    }

    @inlinable
    public mutating func decoded(key: Key) -> Int64 {
        item(key: key).int64
    }

    @inlinable
    public mutating func decoded(key: Key) -> [Int64] {
        item(key: key).decoded(map: \.int64)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: Int64] {
        item(key: key).decoded(map: \.int64)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Int64) -> Int64 {
        item(key: key).int64Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> Int64? {
        item(key: key).int64Value
    }

    @inlinable
    public mutating func decoded(key: Key) -> UInt {
        item(key: key).uint
    }

    @inlinable
    public mutating func decoded(key: Key) -> [UInt] {
        item(key: key).decoded(map: \.uint)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: UInt] {
        item(key: key).decoded(map: \.uint)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> UInt) -> UInt {
        item(key: key).uintValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> UInt? {
        item(key: key).uintValue
    }

    @inlinable
    public mutating func decoded(key: Key) -> UInt32 {
        item(key: key).uint32
    }

    @inlinable
    public mutating func decoded(key: Key) -> [UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: UInt32] {
        item(key: key).decoded(map: \.uint32)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> UInt32) -> UInt32 {
        item(key: key).uint32Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> UInt32? {
        item(key: key).uint32Value
    }

    @inlinable
    public mutating func decoded(key: Key) -> UInt64 {
        item(key: key).uint64
    }

    @inlinable
    public mutating func decoded(key: Key) -> [UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: UInt64] {
        item(key: key).decoded(map: \.uint64)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> UInt64) -> UInt64 {
        item(key: key).uint64Value ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> UInt64? {
        item(key: key).uint64Value
    }

    @inlinable
    public mutating func decoded(key: Key) -> Double {
        item(key: key).double
    }

    @inlinable
    public mutating func decoded(key: Key) -> [Double] {
        item(key: key).decoded(map: \.double)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: Double] {
        item(key: key).decoded(map: \.double)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Double) -> Double {
        item(key: key).doubleValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> Double? {
        item(key: key).doubleValue
    }

    @inlinable
    public mutating func decoded(key: Key) -> Float {
        item(key: key).float
    }

    @inlinable
    public mutating func decoded(key: Key) -> [Float] {
        item(key: key).decoded(map: \.float)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: Float] {
        item(key: key).decoded(map: \.float)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Float) -> Float {
        item(key: key).floatValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> Float? {
        item(key: key).floatValue
    }

    @inlinable
    public mutating func decoded(key: Key) -> Bool {
        item(key: key).bool
    }

    @inlinable
    public mutating func decoded(key: Key) -> [Bool] {
        item(key: key).decoded(map: \.bool)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: Bool] {
        item(key: key).decoded(map: \.bool)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> Bool) -> Bool {
        item(key: key).boolValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> Bool? {
        item(key: key).boolValue
    }

    @inlinable
    public mutating func decoded(key: Key) -> String {
        item(key: key).string
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String] {
        item(key: key).decoded(map: \.string)
    }

    @inlinable
    public mutating func decoded(key: Key) -> [String: String] {
        item(key: key).decoded(map: \.string)
    }

    @inlinable
    public mutating func decoded(key: Key, `default`: @autoclosure () -> String) -> String {
        item(key: key).stringValue ?? `default`()
    }

    @inlinable
    public mutating func decodedValue(key: Key) -> String? {
        item(key: key).stringValue
    }

    @inlinable
    public mutating func decoded<T>(key: Key) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public mutating func decoded<T>(key: Key, as type: T.Type) -> T where T: JSONDecodable {
        T.init(item(key: key))
    }

    @inlinable
    public mutating func decoded<T>(key: Key, map method: (JSON) -> T) -> [T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public mutating func decoded<T>(key: Key, compactMap method: (JSON) -> T?) -> [T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    public mutating func decoded<T>(key: Key, map method: (JSON) -> T) -> [String: T] {
        item(key: key).decoded(map: method)
    }

    @inlinable
    public mutating func decoded<T>(key: Key, compactMap method: (JSON) -> T?) -> [String: T] {
        item(key: key).decoded(compactMap: method)
    }

    @inlinable
    public mutating func decoded<T>(key: Key, `default`: @autoclosure () -> T) -> T where T: JSONFailable {
        T.init(item(key: key)) ?? `default`()
    }

    @inlinable
    public mutating func decodedValue<T>(key: Key) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

    @inlinable
    public mutating func decodedValue<T>(key: Key, as type: T.Type) -> T? where T: JSONFailable {
        T.init(item(key: key))
    }

}
