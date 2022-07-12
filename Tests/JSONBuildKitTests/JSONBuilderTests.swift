import XCTest
@testable import JSONBuildKit

func check<Content>(expected: String, file: StaticString = #filePath, line: UInt = #line,
    @JSONBuilder content: @escaping () -> Content) where Content: Component {
    let data = JSON.build(content: content)
    let value = String(data: data, encoding: .utf8)!
    XCTAssertEqual(value, expected, file: file, line: line)
}

func array<Content>(expected: String, file: StaticString = #filePath, line: UInt = #line,
    @JSONBuilder content: @escaping () -> Content) where Content: Component {
    let data = JSON.buildArray(content: content)
    let value = String(data: data, encoding: .utf8)!
    XCTAssertEqual(value, expected, file: file, line: line)
}

func object<Content>(expected: String, file: StaticString = #filePath, line: UInt = #line,
    @JSONBuilder content: @escaping () -> Content) where Content: Component {
    let data = JSON.buildObject(content: content)
    let value = String(data: data, encoding: .utf8)!
    XCTAssertEqual(value, expected, file: file, line: line)
}

final class JSONBuilderTests: XCTestCase {
    override func setUpWithError() throws {
#if JSON_BUILDER_SUPPORT_IOS_9
        // Do nothing.
#else
        if #unavailable(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0) {
            throw XCTSkip()
        }
#endif
    }

//    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    func testBuild() {
        check(expected: "1") {
            1
        }
        check(expected: "\"1\"") {
            "1"
        }
    }

//    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    func testBuildArray() {
        array(expected: "[1]") {
            1
        }
        array(expected: "[\"1\"]") {
            "1"
        }
    }

//    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    func testBuildObject() {
        object(expected: #"{"v":1}"#) {
            Keyed("v", value: 1)
        }
        object(expected: #"{"v":1}"#) {
            Keyed("v") {
                1
            }
        }
        object(expected: #"{"v":"1"}"#) {
            Keyed("v", value: "1")
        }
        object(expected: #"{"v":"1"}"#) {
            Keyed("v") {
                "1"
            }
        }
    }

//    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    func testForEach() {
        check(expected: "[1,2,3]") {
            JSONArray {
                ForEach(1..<4) { element in
                    element
                }
            }
        }
        array(expected: "[1,2,3]") {
            ForEach(1..<4) { element in
                element
            }
        }
        object(expected: #"{"1":1,"2":2,"3":3}"#) {
            ForEach(1..<4) { element in
                Keyed("\(element)", value: element)
            }
        }
    }

//    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    func testKeyed() {
        object(expected: #"{"x":12,"y":false,"z":"Foobar"}"#) {
            let foo = Foobar()
            Keyed("x", value: foo.x)
            Keyed("y", value: foo.y)
            Keyed("z", value: foo.z)
        }
        object(expected: #"{"v":[1,2,3]}"#) {
            Keyed("v") {
                JSONArray {
                    ForEach(1..<4) { element in
                        element
                    }
                }
            }
        }
    }

//    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 6.0, *)
    func testCodingKeyed() {
        object(expected: #"{"x":12,"y":false,"z":"Foobar"}"#) {
            let foo = Foobar()
            CodingKeyed(Foobar.CodingKeys.x, value: foo.x)
            CodingKeyed(Foobar.CodingKeys.y, value: foo.y)
            CodingKeyed(Foobar.CodingKeys.z, value: foo.z)
        }

        object(expected: #"{"x":12,"y":false,"z":"Foobar"}"#) {
            let foo = Foobar()
            let keys = Keys(of: Foobar.CodingKeys.self)
            keys.value(foo.x, key: .x)
            keys.value(foo.y, key: .y)
            keys.value(foo.z, key: .z)
        }
    }
}

struct Foobar: Codable {
    var x = 12
    var y = false
    var z = "Foobar"

    enum CodingKeys: String, CodingKey {
        case x, y, z
    }
}

struct User: JSONDecodable {
    let username: String
    let age: Int
    let array: [JSON]
    let dictionary: [String: String]
    let friends: [User]

    init(_ json: JSON) {
        var keyed = json.keyed()
        username = keyed.decoded(key: "username")
        age = keyed.decoded(key: "age")
        array = keyed.decoded(key: "list")
        dictionary = keyed.decoded(key: "map")
        friends = keyed.decoded(key: "friends")
    }
}

extension User: JSONEncodable {
    func encode(to stream: inout JSONStream) {

    }
}

struct KeyedUser: JSONDecodable {
    let username: String
    let age: Int
    let array: [JSON]
    let dictionary: [String: String]
    let friends: [User]

    init(_ json: JSON) {
        var keyed = json.keyed(by: CodingKeys.self)
        username = keyed.decoded(key: .username)
        age = keyed.decoded(key: .age)
        array = keyed.decoded(key: .array)
        dictionary = keyed.decoded(key: .dictionary)
        friends = keyed.decoded(key: .friends)
    }

    enum CodingKeys: String, CodingKey {
        case username
        case age
        case array = "list"
        case dictionary = "map"
        case friends
    }
}

extension KeyedUser: JSONEncodable {
    func encode(to stream: inout JSONStream) {
//        stream.buildObject {
//            let keys = Keys(of: CodingKeys.self)
//            keys.value(username, key: .username)
//            keys.value(age, key: .age)
//            keys.value(key: .array) {
//                List(array)
//            }
//        }
    }
}
