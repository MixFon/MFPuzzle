//
//  CheckerTest.swift
//  
//
//  Created by Михаил Фокин on 28.01.2024.
//

import XCTest
@testable import MFPuzzle

final class CheckerTest: XCTestCase {

	private var checker: Checker?
	private let randomizer = MatrixRondomazer<MatrixElement>()

	override func setUpWithError() throws {
		self.checker = Checker()
	}

	override func tearDownWithError() throws {
		self.checker = nil
	}

	func testCheckSolution3x3() throws {
		let matrixTarget3x3: [[MatrixElement]] =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		var matrix3x3: [[MatrixElement]] =
		[[6, 3, 4],
		 [5, 1, 2],
		 [7, 8, 0]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix3x3, matrixTarget: matrixTarget3x3) == true)
		matrix3x3 =
		[[8, 6, 0],
		 [2, 4, 7],
		 [5, 3, 1]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix3x3, matrixTarget: matrixTarget3x3) == true)
		matrix3x3 =
		[[4, 3, 1],
		 [7, 6, 2],
		 [0, 8, 5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix3x3, matrixTarget: matrixTarget3x3) == true)
	}
	
	func testCheckSolution4x4() throws {
		let matrixTarget4x4: [[MatrixElement]] =
		[[ 1, 2,  3,  4],
		 [12, 13, 14, 5],
		 [11,  0, 15, 6],
		 [10,  9, 8,  7]]
		var matrix4x4: [[MatrixElement]] =
		[[ 1, 2,  3,  4],
		 [12, 13, 14, 0],
		 [11, 15,  6, 5],
		 [10,  9, 8,  7]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  3,  4],
		 [12, 13,  6, 14],
		 [11,  0, 15,  5],
		 [10,  9,  8,  7]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  4,  6],
		 [12, 13,  3, 14],
		 [11,  9, 15,  0],
		 [10,  8,  7,  5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  4,  6],
		 [12, 13,  3, 14],
		 [11,  0,  9, 15],
		 [10,  8,  7,  5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  4,  6],
		 [12, 13,  3, 14],
		 [ 0, 11,  9, 15],
		 [10,  8,  7,  5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  4,  6],
		 [12, 13,  3, 14],
		 [10, 11,  9, 15],
		 [ 0,  8,  7,  5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  4,  6],
		 [12, 13,  3, 14],
		 [10, 11,  9, 15],
		 [ 8,  7,  0,  5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 1,  2,  4,  6],
		 [12, 13,  0, 14],
		 [10, 11,  3, 15],
		 [ 8,  7,  9,  5]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
	}
	
	func testCheckSolution5x5() throws {
		let matrixTarget5x5: [[MatrixElement]] =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		var matrix5x5: [[MatrixElement]] =
		[[14,  4, 19, 18,  0],
		 [20, 16, 15,  2,  9],
		 [ 8,  1, 23, 22, 10],
		 [ 3,  6, 11,  5, 17],
		 [ 7, 24, 13, 21, 12]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix5x5, matrixTarget: matrixTarget5x5) == true)
		matrix5x5 =
		[[ 2, 15,  6,  7, 11],
		 [19, 17, 10,  3, 21],
		 [18,  9, 24, 20, 12],
		 [23,  0, 14,  8, 22],
		 [ 5,  4,  1, 13, 16]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix5x5, matrixTarget: matrixTarget5x5) == true)
		matrix5x5 =
		[[ 5, 14, 17, 11,  6],
		 [24,  0, 13, 20, 22],
		 [10,  1,  3,  7,  8],
		 [19, 23, 15, 21,  2],
		 [16,  4,  9, 12, 18]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix5x5, matrixTarget: matrixTarget5x5) == true)
	}
	
	func testCheckRandomClassicMatrixSolution3x3() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomClassicMatrixSolution4x4() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 14, 15,  0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomClassicMatrixSolution5x5() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [ 6,  7,  8,  9, 10],
		 [11, 12, 13, 14, 15],
		 [16, 17, 18, 19, 20],
		 [21, 22, 23, 24,  0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomClassicMatrixNotSolution3x3() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomClassicMatrixNotSolution4x4() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 14, 15,  0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomClassicMatrixNotSolution5x5() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [ 6,  7,  8,  9, 10],
		 [11, 12, 13, 14, 15],
		 [16, 17, 18, 19, 20],
		 [21, 22, 23, 24,  0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomSnailMatrixSolution3x3() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomSnailMatrixSolution4x4() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[ 1, 2,  3,  4],
		 [12, 13, 14, 5],
		 [11,  0, 15, 6],
		 [10,  9, 8,  7]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomSnailMatrixSolution5x5() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomSnailMatrixNotSolution3x3() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomSnailMatrixNotSolution4x4() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[ 1, 2,  3,  4],
		 [12, 13, 14, 5],
		 [11,  0, 15, 6],
		 [10,  9, 8,  7]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomSnailMatrixNotSolution5x5() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomBostrophedonMatrixSolution3x3() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomBostrophedonMatrixSolution4x4() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomBostrophedonMatrixSolution5x5() {
		// Arrange
		let checker = Checker()
		let matrix: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [10,  9,  8,  7,  6],
		 [11, 12, 13, 14, 15],
		 [20, 19, 18, 17, 16],
		 [21, 22, 23, 24,  0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), true)
	}
	
	func testCheckRandomBostrophedonMatrixNotSolution3x3() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[2, 1, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomBostrophedonMatrixNotSolution4x4() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[ 1,  2,  3,  4],
		 [ 8,  7,  6,  5],
		 [ 9, 10, 11, 12],
		 [ 0, 15, 14, 13]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	func testCheckRandomBostrophedonMatrixNotSolution5x5() {
		// Arrange
		let checker = Checker()
		var matrix: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [10,  9,  8,  7,  6],
		 [11, 12, 13, 14, 15],
		 [20, 19, 18, 17, 16],
		 [21, 22, 23, 24,  0]]
		
		// Act
		let matrixTransition = self.randomizer.generateRangomSteps(matrix: matrix, zero: 0)
		(matrix[0][0], matrix[0][1]) = (matrix[0][1], matrix[0][0])
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: matrix, matrixTarget: matrixTransition), false)
	}
	
	// MARK: Test check not solution.
	
	func testCheckNotSolution3x3() throws {
		let matrixTarget3x3: [[MatrixElement]] =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		var matrix3x3: [[MatrixElement]] =
		[[1, 6, 3],
		 [4, 0, 2],
		 [7, 8, 5]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix3x3, matrixTarget: matrixTarget3x3) == true)
		matrix3x3 =
		[[8, 1, 4],
		 [2, 3, 5],
		 [7, 6, 0]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix3x3, matrixTarget: matrixTarget3x3) == true)
		matrix3x3 =
		[[5, 6, 0],
		 [4, 1, 2],
		 [7, 3, 8]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix3x3, matrixTarget: matrixTarget3x3) == true)
	}
	
	
	func testCheckNotSolution4x4() throws {
		let matrixTarget4x4: [[MatrixElement]] =
		[[ 1,  2,   3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		var matrix4x4: [[MatrixElement]] =
		[[ 6,  8,  2,  3],
		 [ 0, 10, 13,  9],
		 [ 5, 11,  7,  1],
		 [14, 15, 12,  4]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[ 6,  3, 13,  5],
		 [ 4, 12,  0,  8],
		 [ 2, 15, 10,  7],
		 [ 1, 14,  9, 11]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[12,  3,  7,  4],
		 [ 6, 14,  0, 10],
		 [ 8, 15,  2,  9],
		 [ 5,  1, 11, 13]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
	}
	
	func testCheckNotSolution5x5() throws {
		let matrixTarget5x5: [[MatrixElement]] =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		var matrix5x5: [[MatrixElement]] =
		[[ 0, 12, 22, 17,  1],
		 [19,  4,  2,  7, 11],
		 [23, 15, 21, 13,  3],
		 [ 9,  6,  5,  10, 18],
		 [ 8, 16, 24, 20, 14]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix5x5, matrixTarget: matrixTarget5x5) == true)
		matrix5x5 =
		[[24, 23, 17,  6,  0],
		 [ 5, 12,  4, 13,  3],
		 [ 2, 11, 19,  1, 18],
		 [10, 21, 22, 16, 15],
		 [14, 20,  7,  8,  9]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix5x5, matrixTarget: matrixTarget5x5) == true)
		matrix5x5 =
		[[12,  1, 22,  8, 13],
		 [17, 24, 14, 10, 21],
		 [18, 23,  5, 20,  0],
		 [ 2, 19, 16,  6,  9],
		 [ 4, 11,  7,  3, 15]]
		XCTAssertFalse(self.checker?.checkSolution(matrix: matrix5x5, matrixTarget: matrixTarget5x5) == true)
	}
	
	func testCheckUniqueElementsMatrixTrue() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		
		// Act
		let answer = self.checker?.checkUniqueElementsMatrix(matrix: matrix)
		
		// Assert
		XCTAssertTrue(answer == true)
	}
	
	func testCheckUniqueElementsMatrixDublicateFalse() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 6]]
		
		// Act
		let answer = self.checker?.checkUniqueElementsMatrix(matrix: matrix)
		
		// Assert
		XCTAssertFalse(answer == true)
	}
	
	func testCheckUniqueElementsMatrixWrongElementFalse() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [9, 0, 4],
		 [7, 6, 5]]
		
		// Act
		let answer = self.checker?.checkUniqueElementsMatrix(matrix: matrix)
		
		// Assert
		XCTAssertFalse(answer == true)
	}
	
	func testGetCoordingateXZero() {
		// Arrange
		var matrix: Matrix =
		[[10, 2, 3],
		 [9, 1, 4],
		 [7, 6, 5]]
		
		// Act
		var prev = (0, 0)
		for j in 0..<matrix.count {
			for i in 1..<matrix.count {
				matrix[prev.0][prev.1] = matrix[j][i]
				matrix[j][i] = 0
				let zeroX = self.checker?.getCoordinateXZero(matrix: matrix)
				XCTAssertNotNil(zeroX)
				XCTAssertEqual(zeroX, i)
				XCTAssertEqual(matrix[j][i], 0)
				prev = (j, i)
			}
		}
	
		// Assert
	}
	
	func testGetCoordingateXZeroNil() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [9, 10, 4],
		 [7, 6, 5]]
		
		// Act
		let zeroX = self.checker?.getCoordinateXZero(matrix: matrix)
	
		// Assert
		XCTAssertNil(zeroX)
	}
	
	/// Проверка что все три случая могут переходить один в доругой
	func testCheckSolutionIn3Type() {
		// Arrange
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)

		// Act
		let boustrophedon = worker.createMatrixClassic(size: 3)
		let snake = worker.createMatrixBoustrophedon(size: 3)
		let snail = worker.createMatrixSnail(size: 3)
		
		// Assert
		XCTAssertEqual(checker.checkSolution(matrix: boustrophedon, matrixTarget: snail), false)
		XCTAssertEqual(checker.checkSolution(matrix: boustrophedon, matrixTarget: snake), false)
		XCTAssertEqual(checker.checkSolution(matrix: snake, matrixTarget: snail), true)
	}
	
	
	func testIsSquereMatrix() {
		// Arrange
		let checker = Checker()
		let matrix1: [[MatrixElement]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		let matrix2: [[MatrixElement]] = [[1, 2, 3], [4, 5], [7, 8, 9]]
		let matrix3: [[MatrixElement]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
		let matrix4: [[MatrixElement]] = [[]]
		let matrix5: [[MatrixElement]] = []
		
		// Act
		let result1 = checker.isSquereMatrix(matrix: matrix1)
		let result2 = checker.isSquereMatrix(matrix: matrix2)
		let result3 = checker.isSquereMatrix(matrix: matrix3)
		let result4 = checker.isSquereMatrix(matrix: matrix4)
		let result5 = checker.isSquereMatrix(matrix: matrix5)
		
		// Assert
		XCTAssertEqual(result1, true)
		XCTAssertEqual(result2, false)
		XCTAssertEqual(result3, false)
		XCTAssertEqual(result4, false)
		XCTAssertEqual(result5, false)
	}
	
	func testGetSummInversionSwapHorizontalZero() {
		// Arrange
		let checker = Checker()
		let matrixOne: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 14,  0, 15]]
		// 1 2 3 4 8 7 6 5 9 10 11 12 15 0 14 13
		//         3 2 1               2    1
		// --> 9

		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 0,  14, 15]]
		// 1 2 3 4 8 7 6 5 9 10 11 12 15 14 0 13
		//         3 2 1               2  1
		// --> 9
		let matrixThree: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 14, 15, 0]]
		// 1 2 3 4 8 7 6 5 9 10 11 12 0 15 14 13
		//         3 2 1                 2  1
		// --> 9
		
		// Act
		let summInversionOne = checker.getSummInversion(matrix: matrixOne)
		let summInversionTwo = checker.getSummInversion(matrix: matrixTwo)
		let summInversionThree = checker.getSummInversion(matrix: matrixThree)
		
		// Assert
		XCTAssertEqual(summInversionOne, 9)
		XCTAssertEqual(summInversionTwo, 9)
		XCTAssertEqual(summInversionThree, 9)
	}
	
	func testGetSummInversionSwapVerticalZero() {
		// Arrange
		let checker = Checker()
		let matrixOne: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 14,  0, 15]]
		// 1 2 3 4 8 7 6 5 9 10 11 12 15 0 14 13
		//         3 2 1               2    1
		// --> 9
		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10,  0, 12],
		 [13, 14, 11, 15]]
		// 1 2 3 4 8 7 6 5 9 10 0 12 15 11 14 13
		//         3 2 1           1  3     1
		// --> 11

		let matrixThree: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  0,  8],
		 [ 9, 10,  7, 12],
		 [13, 14, 11, 15]]
		// 1 2 3 4 8 0 6 5 9 10 7 12 15 11 14 13
		//         3   1   1  1    1  3     1
		// --> 11
		
		// Act
		let summInversionOne = checker.getSummInversion(matrix: matrixOne)
		let summInversionTwo = checker.getSummInversion(matrix: matrixTwo)
		let summInversionThree = checker.getSummInversion(matrix: matrixThree)
		
		// Assert
		XCTAssertEqual(summInversionOne, 9)
		XCTAssertEqual(summInversionTwo, 11)
		XCTAssertEqual(summInversionThree, 11)
	}
	
	func testGetSummInversionSwapHorizontalNumbers() {
		// Arrange
		let checker = Checker()
		let matrixOne: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 14,  15, 0]]
		let matrixTwo: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 11, 12],
		 [13, 15,  14, 0]]
		// 1 2 3 4 8 7 6 5 9 10 11 12 0 15 14 13
		//         3 2 1                 2  1
		// --> 9
		let matrixThree: Matrix =
		[[ 1,  2,  3,  4],
		 [ 5,  6,  7,  8],
		 [ 9, 10, 15, 12],
		 [13, 14, 11, 0]]
		// 1 2 3 4 8 7 6 5 9 10 15 12 0 11 14 13
		//         3 2 1         4  1       1
		// --> 12
		
		// Act
		let summInversionOne = checker.getSummInversion(matrix: matrixOne)
		let summInversionTwo = checker.getSummInversion(matrix: matrixTwo)
		let summInversionThree = checker.getSummInversion(matrix: matrixThree)
		
		// Assert
		XCTAssertEqual(summInversionOne, 9)
		XCTAssertEqual(summInversionTwo, 8)
		XCTAssertEqual(summInversionThree, 12)
		XCTAssertNotEqual(summInversionOne, summInversionTwo)
		XCTAssertNotEqual(summInversionTwo, summInversionThree)
	}

}
