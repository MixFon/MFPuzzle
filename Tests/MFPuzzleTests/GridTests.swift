//
//  GridTests.swift
//  
//
//  Created by Михаил Фокин on 28.02.2024.
//

import XCTest
@testable import MFPuzzle

final class GridTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testGetNeighbors() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(13), true)
		XCTAssertEqual(neighbors?.contains(11), true)
		XCTAssertEqual(neighbors?.contains(15), true)
		XCTAssertEqual(neighbors?.contains(9), true)
		XCTAssertEqual(neighbors?.count, 4)
	}
	
	func testGetNeighborsLeft() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [0,  11, 15,  6],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(12), true)
		XCTAssertEqual(neighbors?.contains(11), true)
		XCTAssertEqual(neighbors?.contains(10), true)
		XCTAssertEqual(neighbors?.count, 3)
	}
	
	
	func testGetNeighborsRiht() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  6, 15,  0],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(5), true)
		XCTAssertEqual(neighbors?.contains(7), true)
		XCTAssertEqual(neighbors?.contains(15), true)
		XCTAssertEqual(neighbors?.count, 3)
	}

	func testGetNeighborsUp() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  0,  3,  4],
		 [12, 13, 14,  5],
		 [11,  2, 15,  6],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(13), true)
		XCTAssertEqual(neighbors?.contains(1), true)
		XCTAssertEqual(neighbors?.contains(3), true)
		XCTAssertEqual(neighbors?.count, 3)
	}
	
	func testGetNeighborsBottom() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  9, 15,  6],
		 [10,  0,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(8), true)
		XCTAssertEqual(neighbors?.contains(10), true)
		XCTAssertEqual(neighbors?.contains(9), true)
		XCTAssertEqual(neighbors?.count, 3)
	}

	func testGetNeighborsUpLeft() {
		// Arrange
		let matrix: Matrix =
		[[ 0,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  1, 15,  6],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(12), true)
		XCTAssertEqual(neighbors?.contains(2), true)
		XCTAssertEqual(neighbors?.count, 2)
	}

	func testGetNeighborsUpRight() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  0],
		 [12, 13, 14,  5],
		 [11,  4, 15,  6],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(3), true)
		XCTAssertEqual(neighbors?.contains(5), true)
		XCTAssertEqual(neighbors?.count, 2)
	}
	
	func testGetNeighborsBottomRight() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  7, 15,  6],
		 [10,  9,  8,  0]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(6), true)
		XCTAssertEqual(neighbors?.contains(8), true)
		XCTAssertEqual(neighbors?.count, 2)
	}

	func testGetNeighborsBottomLeft() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 10, 15,  6],
		 [ 0,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNotNil(neighbors)
		XCTAssertEqual(neighbors?.contains(11), true)
		XCTAssertEqual(neighbors?.contains(9), true)
		XCTAssertEqual(neighbors?.count, 2)
	}
	
	func testGetNeighborsNil() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 10, 15,  6],
		 [16,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let neighbors = grid.getNeighbors(number: 0)
		
		// Assert
		XCTAssertNil(neighbors)
	}
	
	func testIsNeighbors() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 10, 15,  6],
		 [16,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		
		// Assert
		XCTAssertEqual(grid.isNeighbors(one: 1, two: 2), true)
		XCTAssertEqual(grid.isNeighbors(one: 3, two: 14), true)
		XCTAssertEqual(grid.isNeighbors(one: 10, two: 11), true)
		XCTAssertEqual(grid.isNeighbors(one: 7, two: 6), true)
		
		XCTAssertEqual(grid.isNeighbors(one: 7, two: 4), false)
		XCTAssertEqual(grid.isNeighbors(one: 9, two: 15), false)
		XCTAssertEqual(grid.isNeighbors(one: 16, two: 12), false)
		XCTAssertEqual(grid.isNeighbors(one: 13, two: 6), false)
		
		XCTAssertNil(grid.isNeighbors(one: 1, two: 17))
		XCTAssertNil(grid.isNeighbors(one: 3, two: 18))
		XCTAssertNil(grid.isNeighbors(one: 9, two: 19))
		XCTAssertNil(grid.isNeighbors(one: 10, two: 20))
	}
	
	func testSwapNumberNotSwap() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 10, 15,  6],
		 [16,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Act
		grid.swapNumber(number: 2)
		grid.swapNumber(number: 21)
		
		// Assert
		XCTAssertEqual(matrix, grid.matrix)
	}
	
	func testSwapNumber() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 10, 15,  6],
		 [ 0,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		
		// Assert
		grid.swapNumber(number: 2)
		XCTAssertEqual(grid.matrix[0][1], 0)
		XCTAssertEqual(grid.matrix[3][0], 2)
		
		grid.swapNumber(number: 14)
		XCTAssertEqual(grid.matrix[3][0], 2)
		XCTAssertEqual(grid.matrix[1][2], 0)
		XCTAssertEqual(grid.matrix[0][1], 14)
		
	}
	
	func testGetNumberWest() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 0, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .west)
		
		// Assert
		XCTAssertNotNil(number)
		XCTAssertEqual(number, 6)
	}
	
	func testGetNumberWestNil() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 6, 0],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .west)
		
		// Assert
		XCTAssertNil(number)
		XCTAssertNotEqual(number, 6)
	}
	
	func testGetNumberEast() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 0, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .east)
		
		// Assert
		XCTAssertNotNil(number)
		XCTAssertEqual(number, 4)
	}
	
	func testGetNumberEastNil() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [0, 4, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .east)
		
		// Assert
		XCTAssertNil(number)
		XCTAssertNotEqual(number, 4)
	}
	
	func testGetNumberNorth() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 0, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .north)
		
		// Assert
		XCTAssertNotNil(number)
		XCTAssertEqual(number, 2)
	}
	
	func testGetNumberNorthNil() {
		// Arrange
		let matrix: Matrix =
		[[1, 0, 3],
		 [4, 2, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .north)
		
		// Assert
		XCTAssertNil(number)
		XCTAssertNotEqual(number, 2)
	}
	
	func testGetNumberSouth() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 0, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .south)
		
		// Assert
		XCTAssertNotNil(number)
		XCTAssertEqual(number, 5)
	}
	
	func testGetNumberSouthhNil() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 0, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let number = grid.getNumber(for: .south)
		
		// Assert
		XCTAssertNil(number)
		XCTAssertNotEqual(number, 5)
	}
	
	func testIsInsidea() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 0, 8]]
		let grid = Grid(matrix: matrix)
		
		// Act
		
		// Assert
		XCTAssertEqual(grid.isInsidea(x: 0, y: 0), true)
		XCTAssertEqual(grid.isInsidea(x: 0, y: 1), true)
		XCTAssertEqual(grid.isInsidea(x: 0, y: 2), true)
		XCTAssertEqual(grid.isInsidea(x: 1, y: 0), true)
		XCTAssertEqual(grid.isInsidea(x: 1, y: 1), true)
		XCTAssertEqual(grid.isInsidea(x: 1, y: 2), true)
		XCTAssertEqual(grid.isInsidea(x: 2, y: 0), true)
		XCTAssertEqual(grid.isInsidea(x: 2, y: 1), true)
		XCTAssertEqual(grid.isInsidea(x: 2, y: 2), true)
		
		XCTAssertEqual(grid.isInsidea(x: -1, y: 0), false)
		XCTAssertEqual(grid.isInsidea(x: -1, y: 1), false)
		XCTAssertEqual(grid.isInsidea(x: -1, y: 2), false)
		XCTAssertEqual(grid.isInsidea(x: 3, y: 0), false)
		XCTAssertEqual(grid.isInsidea(x: 3, y: 1), false)
		XCTAssertEqual(grid.isInsidea(x: 3, y: 2), false)
		XCTAssertEqual(grid.isInsidea(x: 0, y: 3), false)
		XCTAssertEqual(grid.isInsidea(x: 1, y: 3), false)
		XCTAssertEqual(grid.isInsidea(x: 2, y: 3), false)
		XCTAssertEqual(grid.isInsidea(x: 0, y: -1), false)
		XCTAssertEqual(grid.isInsidea(x: 1, y: -1), false)
		XCTAssertEqual(grid.isInsidea(x: 2, y: -1), false)
	}

	
	func testGetCompass() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 0, 4],
		 [7, 8, 5]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let north = grid.getCompass(for: 2)
		let west = grid.getCompass(for: 4)
		let east = grid.getCompass(for: 6)
		let south = grid.getCompass(for: 8)
		
		let northWest = grid.getCompass(for: 1)
		let northEast = grid.getCompass(for: 3)
		let southWest = grid.getCompass(for: 5)
		let southEast = grid.getCompass(for: 7)
		
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
	
	func testGetCompassFromTo() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 0, 4],
		 [7, 8, 5]]
		let grid = Grid(matrix: matrix)
		
		// Act
		let north = grid.getCompass(from: 6, to: 1)
		let west = grid.getCompass(from: 8, to: 5)
		let east = grid.getCompass(from: 2, to: 1)
		let south = grid.getCompass(from: 6, to: 7)
		
		let northWest = grid.getCompass(from: 8, to: 4)
		let northEast = grid.getCompass(from: 4, to: 2)
		let southWest = grid.getCompass(from: 2, to: 4)
		let southEast = grid.getCompass(from: 4, to: 8)
		
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
