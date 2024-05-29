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
		let grid = Grid(matrix: matrix)
		let board = Board(grid: grid)
		
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
		let grid = Grid(matrix: matrix)
		let board = Board(grid: grid)
		
		// Act
		for i in 1...100 {
			let randomElement = Int.random(in: 0...100)
			board.lavel = i
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
		let grid = Grid(matrix: matrix)
		let board = Board(grid: grid)
		
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
		let grid = Grid(matrix: matrix)
		
		
		// Act
		for _ in 1...100 {
			let randomElement = Int.random(in: 0...100)
			let board = Board(grid: grid)
			board.setF(heuristic: randomElement)
			XCTAssertEqual(board.f, randomElement)
		}
	}
	
	func testGetChildrens() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let grid = Grid(matrix: matrix)
		let board = Board(grid: grid)
		
		let matrixUp: Matrix =
		[[ 1,  2,  3,  4],
		 [12,  0, 14,  5],
		 [11, 13, 15,  6],
		 [10,  9,  8,  7]]
		let gridUp = Grid(matrix: matrixUp)
		let boardUp = Board(grid: gridUp)
		
		let matrixLeft: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [ 0, 11, 15,  6],
		 [10,  9,  8,  7]]
		let gridLeft = Grid(matrix: matrixLeft)
		let boardLeft = Board(grid: gridLeft)
		
		let matrixRight: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11, 15,  0,  6],
		 [10,  9,  8,  7]]
		let gridRight = Grid(matrix: matrixRight)
		let boardRight = Board(grid: gridRight)
		
		let matrixBottom: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  9, 15,  6],
		 [10,  0,  8,  7]]
		let gridBottom = Grid(matrix: matrixBottom)
		let boardBottom = Board(grid: gridBottom)
		
		let matrixError: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  7, 15,  6],
		 [10,  9,  8,  0]]
		let gridError = Grid(matrix: matrixError)
		let boardError = Board(grid: gridError)
		
		// Act
		let childrens = board.getChildrens(calculateHeuristic: { _ , _ in 1 })
		
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
		let grid = Grid(matrix: matrix)
		let board = Board(grid: grid)
		
		// Act
		let childrens = board.getChildrens(calculateHeuristic: { _ , _ in 1 })
		
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
		let gridOne = Grid(matrix: matrixOne)
		let boardOne = Board(grid: gridOne)
		
		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let gridTwo = Grid(matrix: matrixTwo)
		let boardTwo = Board(grid: gridTwo)
		
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
		let gridOne = Grid(matrix: matrixOne)
		let boardOne = Board(grid: gridOne)
		
		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		let gridTwo = Grid(matrix: matrixTwo)
		let boardTwo = Board(grid: gridTwo)
		
		// Assert
		XCTAssertTrue(boardOne != boardTwo)
	}

}
