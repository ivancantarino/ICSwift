//
//  StringTests.swift
//  
//
//  Created by Ivan Cantarino on 16/01/2022.
//

import XCTest
@testable import ICSwift


/// UnitTests for the each `String` extension.
final class StringTests: XCTestCase {
    private var sut: String = "hello world!"
    
    override func tearDown() {
        sut = "hello world!"
    }
    
    func testFirstLetterCapitalized() {
        XCTAssertEqual(sut.capitalizingFirstLetter(), "Hello world!")
    }
    
    func testSubscriptForCharAtIndex() {
        XCTAssertEqual(sut[4], "o")
    }
    
    func testSubscriptForRange() {
        XCTAssertEqual(sut[2..<7], "llo w")
    }
}
