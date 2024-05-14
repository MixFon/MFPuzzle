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
		[[12, 15, 13,  5],
		 [ 3,  9,  6,  2],
		 [ 1, 11,  7, 10],
		 [ 8, 14,  0,  4]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[12, 13, 11,  4],
		 [ 6,  7,  9,  8],
		 [ 3,  0,  1, 14],
		 [ 5, 10,  2, 15]]
		XCTAssertTrue(self.checker?.checkSolution(matrix: matrix4x4, matrixTarget: matrixTarget4x4) == true)
		matrix4x4 =
		[[11,  4,  6,  5],
		 [ 9,  1,  0,  3],
		 [15,  8, 13, 12],
		 [10,  2,  7, 14]]
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
