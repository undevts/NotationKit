import XCTest
@testable import JSONKit

struct Foobar: JSONEncodable, Codable {
    var x = 12
    var y = false
    var z = "Foobar"

    func encode(to stream: inout JSONStream) {
        stream.beginObject()
        stream.keyed("x", value: x)
        stream.keyed("y", value: y)
        stream.keyed("z", value: z)
        stream.endObject()
    }
    
    enum CodingKeys: String, CodingKey {
        case x, y, z
    }
}

struct Browser: JSONCodable, Codable {
    let name: String
    let perfUrl: String
    let releases: [String: Release]

    init(_ json: JSON) {
        name = json.decoded(key: CodingKeys.name)
        perfUrl = json.decoded(key: CodingKeys.perfUrl)
        releases = json.decoded(key: CodingKeys.releases, map: Release.init)
    }

    func encode(to stream: inout JSONStream) {
        stream.beginObject()
        stream.keyed(CodingKeys.name, value: name)
        stream.keyed(CodingKeys.perfUrl, value: perfUrl)
        stream.keyed(CodingKeys.releases, value: releases)
        stream.endObject()
    }

    enum CodingKeys: String, CodingKey {
        case name
        case perfUrl = "pref_url"
        case releases
    }
}

struct Release: JSONCodable, Codable {
    let date: String
    let status: String
    let engine: String
    let engineVersion: String

    init(_ json: JSON) {
        date = json.decoded(key: "release_date")
        status = json.decoded(key: "status")
        engine = json.decoded(key: "engine")
        engineVersion = json.decoded(key: "engine_version")
    }

    func encode(to stream: inout JSONStream) {
        stream.beginObject()
        stream.keyed("release_date", value: date)
        stream.keyed("status", value: status)
        stream.keyed("engine", value: engine)
        stream.keyed("engine_version", value: engineVersion)
        stream.endObject()
    }
}

final class JSONEncodeTests: XCTestCase {
    func testFoobar() {
        var value = Foobar()
        XCTAssertEqual(String(data: value.encoded(), encoding: .utf8)!,
            "{\"x\":12,\"y\":false,\"z\":\"Foobar\"}")
        value.y = true
        XCTAssertEqual(String(data: value.encoded(), encoding: .utf8)!,
            "{\"x\":12,\"y\":true,\"z\":\"Foobar\"}")
    }

    func testBrowser() {
        let json = #"{"name":"Firefox","pref_url":"about:config","releases":{"1":{"release_date":"2004-11-09","# +
            #""status":"retired","engine":"Gecko","engine_version":"1.7"}}}"#
        let browser = try! JSON.parse(json, as: Browser.self).get()
        let result = String(data: browser.encoded(), encoding: .utf8)!
        XCTAssertEqual(json, result)
    }
}
