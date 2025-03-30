//
//  Transporter.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

import XCTest
@testable import MFPuzzle

final class TransporterTests: XCTestCase {

    override func setUpWithError() throws {
		
    }

    override func tearDownWithError() throws {
		
    }

	func testCreateShortestPathSimple() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let solution: Matrix =
		[[2, 3, 4],
		 [1, 6, 8],
		 [7, 5, 0]]
		let transporter = Transporter()
		
		// Act
		let shortestPath = transporter.createShortestPath(from: matrix, to: solution)
		
		// Assert
		XCTAssertEqual(shortestPath[0], nil)
		XCTAssertEqual(shortestPath[1], [.south])
		XCTAssertEqual(shortestPath[2], [.west])
		XCTAssertEqual(shortestPath[3], [.west])
		XCTAssertEqual(shortestPath[4], [.north])
		XCTAssertEqual(shortestPath[5], [.south])
		XCTAssertEqual(shortestPath[6], [.east])
		XCTAssertEqual(shortestPath[7], [])
		XCTAssertEqual(shortestPath[8], [.north, .east])
	}
	
	func testCreateShortestPath3x3() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let solution: Matrix =
		[[4, 8, 6],
		 [3, 7, 0],
		 [2, 1, 5]]
		let transporter = Transporter()
		
		// Act
		let shortestPath = transporter.createShortestPath(from: matrix, to: solution)
		
		// Assert
		XCTAssertEqual(shortestPath[0], nil)
		XCTAssertEqual(shortestPath[1], [.south, .south, .east])
		XCTAssertEqual(shortestPath[2], [.south, .south, .west])
		XCTAssertEqual(shortestPath[3], [.south, .west, .west])
		XCTAssertEqual(shortestPath[4], [.north, .west, .west])
		XCTAssertEqual(shortestPath[5], [.south, .east])
		XCTAssertEqual(shortestPath[6], [.north, .east, .east])
		XCTAssertEqual(shortestPath[7], [.north, .east])
		XCTAssertEqual(shortestPath[8], [.north, .north])
	}
	
	func testCreateShortestPath_4x4() {
		// Arrange
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		
		let solution: Matrix =
		[[ 4,  8, 12,  0],
		 [ 3,  7, 11, 15],
		 [ 2,  6, 10, 14],
		 [ 1,  5,  9, 13]]
		
		let transporter = Transporter()
		
		// Act
		let shortestPath = transporter.createShortestPath(from: matrix, to: solution)
		
		// Assert
		XCTAssertEqual(shortestPath[0],  nil)
		XCTAssertEqual(shortestPath[1],  [.south, .south, .south])
		XCTAssertEqual(shortestPath[2],  [.south, .south, .west])
		XCTAssertEqual(shortestPath[3],  [.south, .west, .west])
		XCTAssertEqual(shortestPath[4],  [.west, .west, .west])
		XCTAssertEqual(shortestPath[5],  [.south, .south, .west, .west])
		XCTAssertEqual(shortestPath[6],  [.west, .west])
		XCTAssertEqual(shortestPath[7],  [.north, .north, .west, .west])
		XCTAssertEqual(shortestPath[8],  [.north, .north, .north, .west])
		XCTAssertEqual(shortestPath[9],  [.east])
		XCTAssertEqual(shortestPath[10], [.north, .east, .east])
		XCTAssertEqual(shortestPath[11], [.north, .east, .east])
		XCTAssertEqual(shortestPath[12], [.north, .east, .east])
		XCTAssertEqual(shortestPath[13], [.south, .south, .east, .east])
		XCTAssertEqual(shortestPath[14], [.south, .east])
		XCTAssertEqual(shortestPath[15], [.north, .east])
	}
	
	func testCreateDirections() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 253]]
		let solution: Matrix =
		[[253, 7, 3],
		 [6, 5, 4],
		 [2, 8, 1]]
		let transporter = Transporter()

		// Act
		let paths = transporter.createDirections(from: matrix, to: solution)
		print(paths)
		
		// Assert
		
	}
}
