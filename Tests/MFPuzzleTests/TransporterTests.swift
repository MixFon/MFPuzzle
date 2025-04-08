//
//  Transporter.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

import XCTest
@testable import MFPuzzle

final class TransporterTests: XCTestCase {

	func testCreateShortestPathSimple() {
		// Arrange
		let matrix: [[Int]] =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let solution: [[Int]] =
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
		let matrix: [[Int]] =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let solution: [[Int]] =
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
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		
		let solution: [[Int]] =
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
	
	func testCreateDirectionsOnePath() {
		// Arrange
		let matrix: [[Int]] =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let solution: [[Int]] =
		[[0, 2, 3],
		 [6, 5, 4],
		 [7, 8, 1]]
		let transporter = Transporter()

		// Act
		let paths = transporter.createDirections(from: matrix, to: solution)
		
		// Assert
		XCTAssertEqual(paths[0], nil)
		if let path = paths[1] {
			let dict = createDictionaryDirectionCount(directions: path)
			XCTAssertEqual(dict[.up(nil)], 1)
			XCTAssertEqual(dict[.down(nil)], 1)
			XCTAssertEqual(dict[.west], nil)
			XCTAssertEqual(dict[.east], 2)
			XCTAssertEqual(dict[.north], nil)
			XCTAssertEqual(dict[.south], 2)
			XCTAssertEqual(dict[.pause], nil)
		} else {
			XCTFail("Произошла ошибка на шаге \(1)")
		}
		XCTAssertEqual(paths[2], [])
		XCTAssertEqual(paths[3], [])
		XCTAssertEqual(paths[4], [])
		XCTAssertEqual(paths[5], [])
		XCTAssertEqual(paths[6], [])
		XCTAssertEqual(paths[7], [])
		XCTAssertEqual(paths[8], [])
	}
	
	func testCreateDirectionsRandom() {
		// Arrange
		let matrix: [[Int]] =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[0, 2, 3],
		 [6, 5, 4],
		 [7, 8, 1]]
		let transporter = Transporter()

		// Act
		let paths = transporter.createDirections(from: randomMatrix, to: solution)
		let shortestPaths = transporter.createShortestPath(from: randomMatrix, to: solution)

		// Assert
		XCTAssertEqual(paths[0], nil)
		for i in 1...8 {
			if let path = paths[i], let shortestPath = shortestPaths[i] {
				let dict = createDictionaryDirectionCount(directions: path)
				let dictSortestPath = createDictionaryDirectionCount(directions: shortestPath)
				XCTAssertEqual(dict[.up(nil)], dict[.down(nil)])
				XCTAssertEqual(dict[.west], dictSortestPath[.west])
				XCTAssertEqual(dict[.east], dictSortestPath[.east])
				XCTAssertEqual(dict[.north], dictSortestPath[.north])
				XCTAssertEqual(dict[.south], dictSortestPath[.south])
			} else {
				XCTFail("Произошла ошибка на шаге \(i)")
			}
		}
	}
	
	func testCreateDirectionsOnePath4x4() {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let solution: [[Int]] =
		[[13,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 1]]
		let transporter = Transporter()

		// Act
		let paths = transporter.createDirections(from: matrix, to: solution)
		
		// Assert
		XCTAssertEqual(paths[0], nil)
		if let path = paths[1] {
			let dict = createDictionaryDirectionCount(directions: path)
			XCTAssertEqual(dict[.up(nil)], dict[.down(nil)])
			XCTAssertEqual(dict[.west], nil)
			XCTAssertEqual(dict[.east], 3)
			XCTAssertEqual(dict[.north], nil)
			XCTAssertEqual(dict[.south], 3)
			XCTAssertEqual(dict[.pause], nil)
		} else {
			XCTFail("Произошла ошибка на шаге \(1)")
		}
		XCTAssertEqual(paths[2], [])
		XCTAssertEqual(paths[3], [])
		XCTAssertEqual(paths[4], [])
		XCTAssertEqual(paths[5], [])
		XCTAssertEqual(paths[6], [])
		XCTAssertEqual(paths[7], [])
		XCTAssertEqual(paths[8], [])
		XCTAssertEqual(paths[9], [])
		XCTAssertEqual(paths[10], [])
		XCTAssertEqual(paths[11], [])
		XCTAssertEqual(paths[12], [])
		if let path = paths[13] {
			let dict = createDictionaryDirectionCount(directions: path)
			XCTAssertEqual(dict[.up(nil)], dict[.down(nil)])
			XCTAssertEqual(dict[.west], 3)
			XCTAssertEqual(dict[.east], nil)
			XCTAssertEqual(dict[.north], 3)
			XCTAssertEqual(dict[.south], nil)
			XCTAssertEqual(dict[.pause], nil)
		} else {
			XCTFail("Произошла ошибка на шаге \(13)")
		}
		XCTAssertEqual(paths[14], [])
		XCTAssertEqual(paths[15], [])
	}
	
	func testCreateDirectionsRandom4x4() {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = transporter.createDirections(from: randomMatrix, to: solution)
		let shortestPaths = transporter.createShortestPath(from: randomMatrix, to: solution)

		
		// Assert
		XCTAssertEqual(paths[0], nil)
		for i in 1...size {
			if let path = paths[i], let shortestPath = shortestPaths[i] {
				let dict = createDictionaryDirectionCount(directions: path)
				let dictSortestPath = createDictionaryDirectionCount(directions: shortestPath)
				XCTAssertEqual(dict[.up(nil)], dict[.down(nil)])
				XCTAssertEqual(dict[.west], dictSortestPath[.west])
				XCTAssertEqual(dict[.east], dictSortestPath[.east])
				XCTAssertEqual(dict[.north], dictSortestPath[.north])
				XCTAssertEqual(dict[.south], dictSortestPath[.south])
			} else {
				XCTFail("Произошла ошибка на шаге \(i)")
			}
		}
	}
	
	func testCreateDirectionsRandom5x5() {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4,  5],
		 [10,  9,  8,  7,  6],
		 [11, 12, 13, 14, 15],
		 [20, 19, 18, 17, 16],
		 [21, 22, 23, 24,  0]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4,  5],
		 [10,  9,  8,  7,  6],
		 [11, 12, 13, 14, 15],
		 [20, 19, 18, 17, 16],
		 [21, 22, 23, 24,  0]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = transporter.createDirections(from: randomMatrix, to: solution)
		let shortestPaths = transporter.createShortestPath(from: randomMatrix, to: solution)

		
		// Assert
		XCTAssertEqual(paths[0], nil)
		for i in 1...size {
			if let path = paths[i], let shortestPath = shortestPaths[i] {
				let dict = createDictionaryDirectionCount(directions: path)
				let dictSortestPath = createDictionaryDirectionCount(directions: shortestPath)
				XCTAssertEqual(dict[.up(nil)], dict[.down(nil)])
				XCTAssertEqual(dict[.west], dictSortestPath[.west])
				XCTAssertEqual(dict[.east], dictSortestPath[.east])
				XCTAssertEqual(dict[.north], dictSortestPath[.north])
				XCTAssertEqual(dict[.south], dictSortestPath[.south])
			} else {
				XCTFail("Произошла ошибка на шаге \(i)")
			}
		}
	}
	
	private func createDictionaryDirectionCount(directions: [Direction]) -> [Direction: Int] {
		var directionCount: [Direction: Int] = [:]
		for direction in directions {
			switch direction {
			case .up(let upDir):
				if let upDir {
					directionCount[upDir, default: 0] += 1
				}
				directionCount[.up(nil), default: 0] += 1
			case .down(let downDir):
				if let downDir {
					directionCount[downDir, default: 0] += 1
				}
				directionCount[.down(nil), default: 0] += 1
			default:
				directionCount[direction, default: 0] += 1
			}
		}
		return directionCount
	}
}
