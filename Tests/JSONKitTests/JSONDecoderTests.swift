import XCTest
@testable import JSONKit

final class JSONDecoderTests: XCTestCase {
    typealias TargetDecoder = JSONSimdDecoder
//    typealias TargetDecoder = JSONDecoder

    func decode<T>(_ json: String, as type: T.Type) throws -> T where T: Decodable {
        let decoder = TargetDecoder()
        return try decoder.decode(type, from: json.data(using: .utf8)!)
    }

    func testDecodeSingleNumbers() {
        XCTAssertNoThrow(try decode(#"0"#, as: UInt.self))
        XCTAssertNoThrow(try decode(#"0"#, as: UInt8.self))
        XCTAssertNoThrow(try decode(#"0"#, as: UInt16.self))
        XCTAssertNoThrow(try decode(#"0"#, as: UInt32.self))
        XCTAssertNoThrow(try decode(#"0"#, as: UInt64.self))
        XCTAssertNoThrow(try decode(#"0"#, as: Int.self))
        XCTAssertNoThrow(try decode(#"0"#, as: Int8.self))
        XCTAssertNoThrow(try decode(#"0"#, as: Int16.self))
        XCTAssertNoThrow(try decode(#"0"#, as: Int32.self))
        XCTAssertNoThrow(try decode(#"0"#, as: Int64.self))
    }

    func testDecodeNumbers() throws {
        struct DataStruct: Codable {
            let int8Value: Int8?
            let uint8Value: UInt8?
            let int16Value: Int16?
            let uint16Value: UInt16?
            let int32Value: Int32?
            let uint32Value: UInt32?
            let int64Value: Int64?
            let intValue: Int?
            let uintValue: UInt?
            let uint64Value: UInt64?
            let floatValue: Float?
            let doubleValue: Double?
            let decimalValue: Decimal?

            enum CodingKeys: String, CodingKey {
                case int8Value
                case uint8Value
                case int16Value
                case uint16Value
                case int32Value
                case uint32Value
                case int64Value
                case intValue
                case uintValue
                case uint64Value
                case floatValue
                case doubleValue
                case decimalValue
            }
        }

        func test(key: DataStruct.CodingKeys, decode: String) throws {
            let decoder = TargetDecoder()
            let json = """
                       {"\(key.stringValue)": \(decode)}
                       """
            _ = try decoder.decode(DataStruct.self, from: json.data(using: .utf8)!)
        }

        XCTAssertNoThrow(try test(key: .int8Value, decode: "0"))
    }

    func testDecodeArray() throws {
        let intArray = try decode("[1,3,5]", as: Array<Int>.self)
        XCTAssertEqual(intArray, [1, 3, 5])
    }

    func testDecodeResponse() throws {
        struct Response<Body>: Equatable, Codable where Body: Equatable & Codable {
            let code: Int
            let message: String
            let body: Body
        }

        let response = try decode(
            """
            {
                "code": 200,
                "message": "success",
                "body": 1000
            }
            """, as: Response<Int>.self)
        XCTAssertEqual(response, Response<Int>(code: 200, message: "success", body: 1000))
        XCTAssertThrowsError(try decode(
            """
            {
                "message": "success",
                "body": 1000
            }
            """, as: Response<Int>.self))
        XCTAssertThrowsError(try decode(
            """
            {
                "code": null,
                "message": "success",
                "body": 1000
            }
            """, as: Response<Int>.self))
    }

    func testKeyedSuperDecode() throws {
        class Root: Decodable {
            private let name: String

            var rootName: String {
                name
            }

            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
            }

            enum CodingKeys: String, CodingKey {
                case name
            }
        }

        class Child: Root {
            let name: String

            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
                try super.init(from: container.superDecoder())
            }

            enum CodingKeys: String, CodingKey {
                case name
            }
        }

        let child = try decode(
            """
            {
                "super": {
                    "name": "root"
                },
                "name": "child"
            }
            """, as: Child.self)
        XCTAssertEqual(child.name, "child")
        XCTAssertEqual(child.rootName, "root")
    }

    func testKeyedSuperDecodeWithKey() throws {
        class Root: Decodable {
            private let name: String

            var rootName: String {
                name
            }

            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
            }

            enum CodingKeys: String, CodingKey {
                case name
            }
        }

        class Child: Root {
            let name: String

            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                name = try container.decode(String.self, forKey: .name)
                try super.init(from: container.superDecoder(forKey: .parent))
            }

            enum CodingKeys: String, CodingKey {
                case name
                case parent
            }
        }

        let child = try decode(
            """
            {
                "parent": {
                    "name": "root"
                },
                "name": "child"
            }
            """, as: Child.self)
        XCTAssertEqual(child.name, "child")
        XCTAssertEqual(child.rootName, "root")
    }
}
