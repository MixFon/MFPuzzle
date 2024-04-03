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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors(number: 0)
		
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
		let board = Grid(matrix: matrix)
		
		// Act
		
		// Assert
		XCTAssertEqual(board.isNeighbors(one: 1, two: 2), true)
		XCTAssertEqual(board.isNeighbors(one: 3, two: 14), true)
		XCTAssertEqual(board.isNeighbors(one: 10, two: 11), true)
		XCTAssertEqual(board.isNeighbors(one: 7, two: 6), true)
		
		XCTAssertEqual(board.isNeighbors(one: 7, two: 4), false)
		XCTAssertEqual(board.isNeighbors(one: 9, two: 15), false)
		XCTAssertEqual(board.isNeighbors(one: 16, two: 12), false)
		XCTAssertEqual(board.isNeighbors(one: 13, two: 6), false)
		
		XCTAssertNil(board.isNeighbors(one: 1, two: 17))
		XCTAssertNil(board.isNeighbors(one: 3, two: 18))
		XCTAssertNil(board.isNeighbors(one: 9, two: 19))
		XCTAssertNil(board.isNeighbors(one: 10, two: 20))
	}

}
