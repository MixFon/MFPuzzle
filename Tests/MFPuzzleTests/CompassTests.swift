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
	
	
	func testCalculateCompass() {
		// Arrange
		
		// Act
		let north = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 0, y: 1))
		let west = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 1, y: 2))
		let east = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 1, y: 0))
		let south = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 2, y: 1))
		
		let northWest = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 0, y: 2))
		let northEast = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 0, y: 0))
		let southWest = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 2, y: 2))
		let southEast = Compass.calculateCompass(endPoint: GridPoint(x: 1, y: 1), startPoint: GridPoint(x: 2, y: 0))
		
		// Assert
		XCTAssertEqual(north, .north)
		XCTAssertEqual(west, .west)
		XCTAssertEqual(east, .east)
		XCTAssertEqual(south, .south)
		
		XCTAssertNil(northWest)
		XCTAssertNil(northEast)
		XCTAssertNil(southWest)
		XCTAssertNil(southEast)
	}

}
