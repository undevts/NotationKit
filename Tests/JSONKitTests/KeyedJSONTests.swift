import XCTest
@testable import JSONKit

struct SomeApi: Codable {
    let code: Int
    let message: String
    let currentPage: UInt
    let totalPage: UInt
    
    enum CodingKeys: String, CodingKey {
        case code
        case message = "msg"
        case currentPage
        case totalPage
    }
}

extension SomeApi: JSONDecodable {
    init(_ json: JSON) {
        let keyed = json.keyed()
        code = keyed.decoded(key: "code")
        message = keyed.decoded(key: "msg")
        currentPage = keyed.decoded(key: "currentPage")
        totalPage = keyed.decoded(key: "totalPage")
    }
}

final class KeyedJSONTests: XCTestCase {
    typealias Item = StringKeyedJSON.Item
    
    func testItemSet() {
        var set = Set<Item>()
        XCTAssertTrue(set.isEmpty)
        let i = Item(key: "foo")
        XCTAssertFalse(set.contains(i))
        set.update(with: i)
        XCTAssertTrue(set.contains(i))
    }
    
    func testStringKeyedDecode() throws {
        let api = try JSON.parse(#"{"code": 0,"msg": "SUCCESS","currentPage": 1,"totalPage": 2}"#,
            as: SomeApi.self).get()
        XCTAssertEqual(api.code, 0)
        XCTAssertEqual(api.message, "SUCCESS")
        XCTAssertEqual(api.currentPage, 1)
        XCTAssertEqual(api.totalPage, 2)
    }
}
