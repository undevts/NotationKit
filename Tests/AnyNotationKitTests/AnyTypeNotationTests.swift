// MIT License
//
// Copyright (c) 2022 Notation Kit Project Authors
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
import AnyNotationKitTestsSupport
@testable import AnyNotationKit

#if canImport(UIKit)
import UIKit
#endif

final class AnyTypeNotationTests: XCTestCase {
    func testDecodeAttributes() {
        let container = AnyTypeNotation(any_attributes())

#if os(macOS)
        XCTAssertFalse(container.item(key: .accessibilityAlignment).isExists)
        
        XCTAssertEqual(container.item(key: .foregroundColor, as: NSColor.self)!, NSColor.textColor)
        XCTAssertEqual(container.item(key: .backgroundColor, as: NSColor.self)!, NSColor.textBackgroundColor)
#else
        XCTAssertEqual(container.item(key: .foregroundColor, as: UIColor.self)!, UIColor.gray)
        XCTAssertEqual(container.item(key: .backgroundColor, as: UIColor.self)!, UIColor.darkText)
#endif
        
        XCTAssertEqual(container.item(key: .ligature, as: Int.self)!, 1)
        XCTAssertEqual(container.item(key: .ligature).int, 1)
        XCTAssertEqual(container.item(key: .ligature).intValue!, 1)
        
        XCTAssertEqual(container.item(key: .writingDirection, as: [Int].self)!, [0, 2])
        XCTAssertEqual(container.item(key: .writingDirection, as: NSArray.self)!, [0, 2] as NSArray)

#if os(macOS)
        XCTAssertTrue(container.item(key: .accessibilityAutocorrected, as: Bool.self)!)
        XCTAssertTrue(container.item(key: .accessibilityAutocorrected).bool)
        XCTAssertTrue(container.item(key: .accessibilityAutocorrected).boolValue!)
#endif
    }
}
