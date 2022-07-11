#if SWIFT_PACKAGE
@_implementationOnly import JSONSimd
#endif

struct _SingleValueDecodingContainer: SingleValueDecodingContainer, JSONContainer {
    private var context: _Decoder.Context
    let value: json_value

    init(_ context: _Decoder.Context, _ value: json_value) {
        self.context = context
        self.value = value
    }

    var codingPath: [CodingKey] {
        context.codingPath
    }

    @inline(__always)
    var storage: JSONStorage {
        context.storage
    }

    func decodeNil() -> Bool {
        SimdDecoder(self).isNull
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        try SimdDecoder(self).decodeBool(codingPath)
    }

    func decode(_ type: String.Type) throws -> String {
        try SimdDecoder(self).decodeString(codingPath)
    }

    func decode(_ type: Double.Type) throws -> Double {
        try SimdDecoder(self).decodeDouble(codingPath)
    }

    func decode(_ type: Float.Type) throws -> Float {
        try SimdDecoder(self).decodeFloat(codingPath)
    }

    func decode(_ type: Int.Type) throws -> Int {
        try SimdDecoder(self).decodeInt(codingPath)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        try SimdDecoder(self).decodeInt8(codingPath)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        try SimdDecoder(self).decodeInt16(codingPath)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        try SimdDecoder(self).decodeInt32(codingPath)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        try SimdDecoder(self).decodeInt64(codingPath)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        try SimdDecoder(self).decodeUInt(codingPath)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        try SimdDecoder(self).decodeUInt8(codingPath)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        try SimdDecoder(self).decodeUInt16(codingPath)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        try SimdDecoder(self).decodeUInt32(codingPath)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        try SimdDecoder(self).decodeUInt64(codingPath)
    }

    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        try context.makeDecoder().decode(type)
    }
}
