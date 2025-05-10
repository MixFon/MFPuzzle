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
	
	func testCreateDirectionsOnePath() throws {
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
		let paths = try transporter.createDirections(from: matrix, to: solution)
		
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
	
	func testCreateDirectionsRandom() throws {
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
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsOnePath4x4() throws {
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
		let paths = try transporter.createDirections(from: matrix, to: solution)
		
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
	
	func testCreateDirectionsRandom4x4() throws {
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
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsRandom5x5() throws {
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
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsRandom6x6() throws {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6],
		 [12, 11, 10,  9,  8,  7],
		 [13, 14, 15, 16, 17, 18],
		 [24, 23, 22, 21, 20, 19],
		 [25, 26, 27, 28, 29, 30],
		 [ 0, 35, 34, 33, 32, 31]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6],
		 [12, 11, 10,  9,  8,  7],
		 [13, 14, 15, 16, 17, 18],
		 [24, 23, 22, 21, 20, 19],
		 [25, 26, 27, 28, 29, 30],
		 [ 0, 35, 34, 33, 32, 31]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsRandom7x7() throws {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7],
		 [14, 13, 12, 11, 10,  9,  8],
		 [15, 16, 17, 18, 19, 20, 21],
		 [28, 27, 26, 25, 24, 23, 22],
		 [29, 30, 31, 32, 33, 34, 35],
		 [42, 41, 40, 39, 38, 37, 36],
		 [43, 44, 45, 46, 47, 48,  0]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7],
		 [14, 13, 12, 11, 10,  9,  8],
		 [15, 16, 17, 18, 19, 20, 21],
		 [28, 27, 26, 25, 24, 23, 22],
		 [29, 30, 31, 32, 33, 34, 35],
		 [42, 41, 40, 39, 38, 37, 36],
		 [43, 44, 45, 46, 47, 48,  0]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsRandom8x8() throws {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7,  8],
		 [16, 15, 14, 13, 12, 11, 10,  9],
		 [17, 18, 19, 20, 21, 22, 23, 24],
		 [32, 31, 30, 29, 28, 27, 26, 25],
		 [33, 34, 35, 36, 37, 38, 39, 40],
		 [48, 47, 46, 45, 44, 43, 42, 41],
		 [49, 50, 51, 52, 53, 54, 55, 56],
		 [ 0, 63, 62, 61, 60, 59, 58, 57]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7,  8],
		 [16, 15, 14, 13, 12, 11, 10,  9],
		 [17, 18, 19, 20, 21, 22, 23, 24],
		 [32, 31, 30, 29, 28, 27, 26, 25],
		 [33, 34, 35, 36, 37, 38, 39, 40],
		 [48, 47, 46, 45, 44, 43, 42, 41],
		 [49, 50, 51, 52, 53, 54, 55, 56],
		 [ 0, 63, 62, 61, 60, 59, 58, 57]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsRandom9x9() throws {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7,  8,  9],
		 [18, 17, 16, 15, 14, 13, 12, 11, 10],
		 [19, 20, 21, 22, 23, 24, 25, 26, 27],
		 [36, 35, 34, 33, 32, 31, 30, 29, 28],
		 [37, 38, 39, 40, 41, 42, 43, 44, 45],
		 [54, 53, 52, 51, 50, 49, 48, 47, 46],
		 [55, 56, 57, 58, 59, 60, 61, 62, 63],
		 [72, 71, 70, 69, 68, 67, 66, 65, 64],
		 [73, 74, 75, 76, 77, 78, 79, 80,  0]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7,  8,  9],
		 [18, 17, 16, 15, 14, 13, 12, 11, 10],
		 [19, 20, 21, 22, 23, 24, 25, 26, 27],
		 [36, 35, 34, 33, 32, 31, 30, 29, 28],
		 [37, 38, 39, 40, 41, 42, 43, 44, 45],
		 [54, 53, 52, 51, 50, 49, 48, 47, 46],
		 [55, 56, 57, 58, 59, 60, 61, 62, 63],
		 [72, 71, 70, 69, 68, 67, 66, 65, 64],
		 [73, 74, 75, 76, 77, 78, 79, 80,  0]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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
	
	func testCreateDirectionsRandom10x10() throws {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10],
		 [20, 19, 18, 17, 16, 15, 14, 13, 12, 11],
		 [21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
		 [40, 39, 38, 37, 36, 35, 34, 33, 32, 31],
		 [41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
		 [60, 59, 58, 57, 56, 55, 54, 53, 52, 51],
		 [61, 62, 63, 64, 65, 66, 67, 68, 69, 70],
		 [80, 79, 78, 77, 76, 75, 74, 73, 72, 71],
		 [81, 82, 83, 84, 85, 86, 87, 88, 89, 90],
		 [ 0, 99, 98, 97, 96, 95, 94, 93, 92, 91]]
		let randorizer = MatrixRondomazer<Int>()
		let randomMatrix = randorizer.generateRangomSteps(matrix: matrix, zero: 0)
		let solution: [[Int]] =
		[[ 1,  2,  3,  4,  5,  6,  7,  8,  9, 10],
		 [20, 19, 18, 17, 16, 15, 14, 13, 12, 11],
		 [21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
		 [40, 39, 38, 37, 36, 35, 34, 33, 32, 31],
		 [41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
		 [60, 59, 58, 57, 56, 55, 54, 53, 52, 51],
		 [61, 62, 63, 64, 65, 66, 67, 68, 69, 70],
		 [80, 79, 78, 77, 76, 75, 74, 73, 72, 71],
		 [81, 82, 83, 84, 85, 86, 87, 88, 89, 90],
		 [ 0, 99, 98, 97, 96, 95, 94, 93, 92, 91]]
		let transporter = Transporter()
		let size = solution.count * solution.count - 1

		// Act
		let paths = try transporter.createDirections(from: randomMatrix, to: solution)
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

	func testCreateDirectionsThrows() {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  6],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let solution: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let transporter = Transporter()

		// Act
		
		// Assert
		XCTAssertThrowsError(try transporter.createDirections(from: matrix, to: solution)) { error in
			XCTAssertEqual(error as? TransporterError, TransporterError.limitAttemptsHasBeenReached)
		}
	}
	
	func testCreateDirectionsEmptyMatrix() throws {
		// Arrange
		let solution: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let transporter = Transporter()

		// Act
		let paths = try transporter.createDirections(from: [[]], to: solution)
		
		// Assert
		XCTAssertEqual(paths, [:])
	}
	
	func testCreateDirectionsEmptySolution() throws {
		// Arrange
		let matrix: [[Int]] =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  6],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		let transporter = Transporter()

		// Act
		let paths = try transporter.createDirections(from: matrix, to: [[]])
		
		// Assert
		XCTAssertEqual(paths, [:])
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
