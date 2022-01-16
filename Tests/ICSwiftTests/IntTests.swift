//
//  IntTests.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import XCTest
@testable import ICSwift

final class IntTests: XCTestCase {
    func testDegreesToRadians() {
        let i = 180
        XCTAssertEqual(i.degreesToRadians, Double.pi)
    }
}
