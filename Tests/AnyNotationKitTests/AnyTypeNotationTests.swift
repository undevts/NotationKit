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
