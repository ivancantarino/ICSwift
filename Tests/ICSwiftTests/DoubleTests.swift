//
//  DoubleTests.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import XCTest
@testable import ICSwift

final class DoubleTests: XCTestCase {
    func testTruncateDecimalPlaces() {
        let d: Double = 3.1415
        XCTAssertEqual(d.truncate(places: 2), 3.14)
    }
}
