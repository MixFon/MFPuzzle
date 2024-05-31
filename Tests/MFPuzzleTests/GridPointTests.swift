//
//  GridPointTests.swift
//  
//
//  Created by Михаил Фокин on 31.05.2024.
//

import XCTest
@testable import MFPuzzle

final class GridPointTests: XCTestCase {

	func testAddition() {
		// Arrange
		let one = GridPoint(x: 3, y: 4)
		let two = GridPoint(x: 5, y: 9)
		
		// Act
		let three = one + two
		
		// Assert
		XCTAssertEqual(three, GridPoint(x: 8, y: 13))
	}
	
	func testSubtraction() {
		// Arrange
		let one = GridPoint(x: 7, y: 10)
		let two = GridPoint(x: 8, y: 9)
		
		// Act
		let three = one - two
		
		// Assert
		XCTAssertEqual(three, GridPoint(x: -1, y: 1))
	}

}
