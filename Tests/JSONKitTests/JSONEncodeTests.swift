// MIT License
//
// Copyright (c) 2021-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import XCTest
@testable import JSONKit

struct Foobar: JSONEncodable {
    var x = 12
    var y = false
    var z = "Foobar"

    func encode(to stream: inout JSONStream) {
        stream.beginObject()
        stream.write(key: "x", x)
        stream.write(key: "y", y)
        stream.write(key: "z", z)
        stream.endObject()
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
        stream.write(key: CodingKeys.name, name)
        stream.write(key: CodingKeys.perfUrl, perfUrl)
        stream.write(key: CodingKeys.releases, releases)
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
        stream.write(key: "release_date", date)
        stream.write(key: "status", status)
        stream.write(key: "engine", engine)
        stream.write(key: "engine_version", engineVersion)
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
