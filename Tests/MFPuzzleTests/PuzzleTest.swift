//
//  PuzzleTest.swift
//  
//
//  Created by Михаил Фокин on 24.01.2024.
//

import XCTest
@testable import MFPuzzle

final class PuzzleTest: XCTestCase {
	
	private var puzzle: Puzzle?

    override func setUpWithError() throws {
		let checker = Checker()
		self.puzzle = Puzzle(heuristic: .manhattan, checker: checker)
    }

    override func tearDownWithError() throws {
		self.puzzle = nil
    }
	
	// MARK: Test create matrix.

	func testCreateMatrix3x3() throws {
		// Arrange
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		6 2 1
		4 0 5
		7 3 8
		"""
		let uint8Matrix3x3: [[UInt8]] =
		[[6, 2, 1],
		[4, 0, 5],
		[7, 3, 8]]
		
		// Act
		let newMatrix3x3 = try self.puzzle?.creationMatrix(text: matrix3x3)
		
		// Assert
		XCTAssertEqual(uint8Matrix3x3, newMatrix3x3)
    }
	
	func testErrorNumberCreateMatrix3x3() throws {
		// Arrange
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		a6 2 1
		4 0 5
		7 3 8
		"""
		
		// Assert
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: matrix3x3)) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "The number a6 does not match the size of UInt8."))
		}
	}
	
	func testErrorSizeCreateMatrix3x3() throws {
		// Arrange
		var matrix3x3 =
		"""
		# This puzzle is solvable
		3
		6 2 1
		4 0 5
		"""
		
		// Assert
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: matrix3x3)) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "The board size is set incorrectly."))
		}
		matrix3x3 =
		"""
		3
		3
		"""
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: matrix3x3)) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "Invalid data: 3"))
		}
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: "")) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "Invalid data."))
		}
	}
	
	func testErrorUInt8CreateMatrix3x3() throws {
		// Arrange
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		6 2 1
		4 0 5
		7 3 512
		"""
		
		// Assert
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: matrix3x3)) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "The number 512 does not match the size of UInt8."))
		}
	}
	
	func testCreateMatrix4x4() throws {
		// Arrange
		let matrix4x4 =
		"""
		# This puzzle is solvable
		4
		 8 15  6  5
		 2  9  3 10
		14 11  4  7
		12  1  0 13
		"""
		let uint8Matrix4x4: [[UInt8]] =
		[[8, 15, 6, 5],
		[2, 9, 3, 10],
		[14, 11, 4, 7],
		[12, 1, 0, 13]]
		
		// Act
		let newMatrix4x4 = try self.puzzle?.creationMatrix(text: matrix4x4)
		
		// Assert
		XCTAssertEqual(uint8Matrix4x4, newMatrix4x4)
	}
	
	func testCreateMatrix5x5() throws {
		// Arrange
		let matrix5x5 =
		"""
		# This puzzle is solvable
		5
		22 16 19 18 12
		 1  3  4 14 15
		 6 23  0 11 24
		 2 13 17 20 21
		 7 10  5  8  9
		"""
		let uint8Matrix5x5: [[UInt8]] = [
			[22, 16, 19, 18, 12],
			[1, 3, 4, 14, 15],
			[6, 23, 0, 11, 24],
			[2, 13, 17, 20, 21],
			[7, 10, 5, 8, 9]
		]
		
		// Act
		let newMatrix5x5 = try self.puzzle?.creationMatrix(text: matrix5x5)
		
		// Assert
		XCTAssertEqual(uint8Matrix5x5, newMatrix5x5)
	}
	
	// MARK: Testing the filling of the board in a spiral.
	
	func testFillBoardSpiral3x3() {
		// Arrange
		let size = 3
		var matrix: Matrix = Array(repeating: Array(repeating: UInt8(), count: size), count: size)
		
		// Act
		self.puzzle?.fillBoardInSpiral(matrix: &matrix)
		
		// Assert
		let matrixSpiral3x3: [[UInt8]] =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		XCTAssertEqual(matrix, matrixSpiral3x3)
	}
	
	func testFillBoardSpiral4x4() {
		// Arrange
		let size = 4
		var matrix: Matrix = Array(repeating: Array(repeating: UInt8(), count: size), count: size)
		
		// Act
		self.puzzle?.fillBoardInSpiral(matrix: &matrix)
		
		// Assert
		let matrixSpiral3x3: [[UInt8]] =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		
		// Assert
		XCTAssertEqual(matrix, matrixSpiral3x3)
	}
	
	func testFillBoardSpiral5x5() {
		// Arrange
		let size = 5
		var matrix: Matrix = Array(repeating: Array(repeating: UInt8(), count: size), count: size)
		
		// Act
		self.puzzle?.fillBoardInSpiral(matrix: &matrix)
		
		// Assert
		let matrixSpiral3x3: [[UInt8]] =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		XCTAssertEqual(matrix, matrixSpiral3x3)
	}
	
	func testCreateMatrixSpiral3x3() {
		// Arrange
		let size = 3
		let matrix: Matrix?
		let matrixSpiral: Matrix =
		[[1, 2, 3],
		 [8, 0, 4],
		 [7, 6, 5]]
		
		// Act
		matrix = self.puzzle?.createMatrixSpiral(size: size)
		
		// Assert
		XCTAssertEqual(matrix, matrixSpiral)
	}
	
	func testCreateMatrixSpiral4x4() {
		// Arrange
		let size = 4
		let matrix: Matrix?
		let matrixSpiral: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		
		// Act
		matrix = self.puzzle?.createMatrixSpiral(size: size)
		
		// Assert
		XCTAssertEqual(matrix, matrixSpiral)
	}
	
	func testCreateMatrixSpiral5x5() {
		// Arrange
		let size = 5
		let matrix: Matrix?
		let matrixSpiral: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		
		// Act
		matrix = self.puzzle?.createMatrixSpiral(size: size)
		
		// Assert
		XCTAssertEqual(matrix, matrixSpiral)
	}
	
	// MARK: Testing solution
	
	func testSolution4Iteration3x3() throws {
		// Arrange
		let size = 3
		let lavel = 4
		let board: Board?
		let matrix3x3 =
		"""
		# This puzzle is solvable 4 iteration
		3
		0 2 3
		1 6 4
		8 7 5
		"""
		guard let newMatrix3x3 = try self.puzzle?.creationMatrix(text: matrix3x3) else {
			XCTFail("Puzzle nil")
			return
		}
		let startBoard = Board(matrix: newMatrix3x3)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let targetBoard = Board(matrix: targetMatrix)
		
		// Act
		board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testSolution18Iteration3x3() throws {
		// Arrange
		let size = 3
		let lavel = 18
		let board: Board?
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		0 3 2
		8 7 5
		6 4 1
		"""
		guard let newMatrix3x3 = try self.puzzle?.creationMatrix(text: matrix3x3) else {
			XCTFail("Puzzle nil")
			return
		}
		let startBoard = Board(matrix: newMatrix3x3)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let targetBoard = Board(matrix: targetMatrix)
		
		// Act
		board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testSolution23Iteration3x3() throws {
		// Arrange
		let size = 3
		let lavel = 24
		let board: Board?
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		7 6 2
		5 8 4
		3 1 0
		"""
		guard let newMatrix3x3 = try self.puzzle?.creationMatrix(text: matrix3x3) else {
			XCTFail("Puzzle nil")
			return
		}
		let startBoard = Board(matrix: newMatrix3x3)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let targetBoard = Board(matrix: targetMatrix)
		
		// Act
		board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
