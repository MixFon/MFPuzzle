//
//  BoardTests.swift
//  
//
//  Created by Михаил Фокин on 02.02.2024.
//

import XCTest
@testable import MFPuzzle

final class BoardTests: XCTestCase {

	
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


	func testSetF3x3() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [9, 0, 4],
		 [7, 6, 5]]
		let board = Board(matrix: matrix)
		
		// Act
		board.setF(heuristic: 10)
		
		// Assert
		XCTAssertEqual(board.f, 10)
	}
	
	func testSetFRandomElements3x3() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [9, 0, 4],
		 [7, 6, 5]]
		var board = Board(matrix: matrix)
		
		// Act
		for i in 1...100 {
			let randomElement = Int.random(in: 0...100)
			board = Board(board: board)
			board.setF(heuristic: randomElement)
			XCTAssertEqual(board.f, randomElement + i)
		}
	}
	
	func testSetF4x4() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let board = Board(matrix: matrix)
		
		// Act
		board.setF(heuristic: 10)
		
		// Assert
		XCTAssertEqual(board.f, 10)
	}
	
	func testSetFRandomElements4x4() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		var board = Board(matrix: matrix)
		
		// Act
		for _ in 1...100 {
			let randomElement = Int.random(in: 0...100)
			board = Board(board: board)
			board.setF(heuristic: randomElement)
			XCTAssertEqual(board.f, randomElement)
		}
	}
	
	func testGetNeighbors() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
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
		let board = Board(matrix: matrix)
		
		// Act
		let neighbors = board.getNeighbors()
		
		// Assert
		XCTAssertNil(neighbors)
	}
	
	func testGetChildrens() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 0, 15,  6],
		 [10,  9,  8,  7]]
		let board = Board(matrix: matrix)
		
		let matrixUp: Matrix =
		[[ 1,  2,  3,  4],
		 [12,  0, 14,  5],
		 [11, 13, 15,  6],
		 [10,  9,  8,  7]]
		let boardUp = Board(matrix: matrixUp)
		
		let matrixLeft: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [ 0, 11, 15,  6],
		 [10,  9,  8,  7]]
		let boardLeft = Board(matrix: matrixLeft)
		
		let matrixRight: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 15, 0,  6],
		 [10,  9,  8,  7]]
		let boardRight = Board(matrix: matrixRight)
		
		let matrixBottom: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  9, 15,  6],
		 [10,  0,  8,  7]]
		let boardBottom = Board(matrix: matrixBottom)
		
		let matrixError: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  7, 15,  6],
		 [10,  9,  8,  0]]
		let boardError = Board(matrix: matrixError)
		
		// Act
		let childrens = board.getChildrens()
		
		// Assert
		XCTAssertNotNil(childrens)
		XCTAssertEqual(childrens?.contains(boardUp), true)
		XCTAssertEqual(childrens?.contains(boardLeft), true)
		XCTAssertEqual(childrens?.contains(boardRight), true)
		XCTAssertEqual(childrens?.contains(boardBottom), true)
		XCTAssertEqual(childrens?.count, 4)
		
		XCTAssertEqual(childrens?.contains(boardError), false)
	}
	
	func testGetChildrensNil() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 16, 15,  6],
		 [10,  9,  8,  7]]
		let board = Board(matrix: matrix)
		
		// Act
		let childrens = board.getChildrens()
		
		// Assert
		XCTAssertNil(childrens)
	}
	
	func testEquel() {
		// Arrange
		let matrixOne: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let boardOne = Board(matrix: matrixOne)
		
		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let boardTwo = Board(matrix: matrixTwo)
		
		// Assert
		XCTAssertTrue(boardOne == boardTwo)
	}
	
	func testEquelNotEquel() {
		// Arrange
		let matrixOne: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 15,  0,  6],
		 [10,  9,  8,  7]]
		let boardOne = Board(matrix: matrixOne)
		
		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let boardTwo = Board(matrix: matrixTwo)
		
		// Assert
		XCTAssertTrue(boardOne != boardTwo)
	}
	
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
