//
//  CompassTests.swift
//
//
//  Created by Михаил Фокин on 02.06.2024.
//

import XCTest
@testable import MFPuzzle

final class CompassTests: XCTestCase {
	
	func testOpposite() {
		// Arrange
		let west = Compass.west
		let east = Compass.east
		let north = Compass.north
		let south = Compass.south
		
		// Act
		
		// Assert
		XCTAssertEqual(west.opposite, .east)
		XCTAssertEqual(east.opposite, .west)
		XCTAssertEqual(north.opposite, .south)
		XCTAssertEqual(south.opposite, .north)
	}

}
