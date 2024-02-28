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
		let uint8Matrix3x3: Matrix =
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
		let uint8Matrix4x4: Matrix =
		[[8, 15, 6, 5],
		[ 2, 9, 3, 10],
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
		let uint8Matrix5x5: Matrix = [
			[22, 16, 19, 18, 12],
			[ 1,  3,  4, 14, 15],
			[ 6, 23,  0, 11, 24],
			[ 2, 13, 17, 20, 21],
			[ 7, 10,  5,  8,  9]
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
		let matrixSpiral3x3: Matrix =
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
		let matrixSpiral4x4: Matrix =
		[[ 1,  2,  3,  4],
		 [12, 13, 14,  5],
		 [11,  0, 15,  6],
		 [10,  9,  8,  7]]
		
		// Assert
		XCTAssertEqual(matrix, matrixSpiral4x4)
	}
	
	func testFillBoardSpiral5x5() {
		// Arrange
		let size = 5
		var matrix: Matrix = Array(repeating: Array(repeating: UInt8(), count: size), count: size)
		
		// Act
		self.puzzle?.fillBoardInSpiral(matrix: &matrix)
		
		// Assert
		let matrixSpiral5x5: Matrix =
		[[ 1,  2,  3,  4,  5],
		 [16, 17, 18, 19,  6],
		 [15, 24,  0, 20,  7],
		 [14, 23, 22, 21,  8],
		 [13, 12, 11, 10,  9]]
		XCTAssertEqual(matrix, matrixSpiral5x5)
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
		let grid = Grid(matrix: newMatrix3x3)
		let startBoard = Board(grid: grid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
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
		let grid = Grid(matrix: newMatrix3x3)
		let startBoard = Board(grid: grid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
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
		let grid = Grid(matrix: newMatrix3x3)
		let startBoard = Board(grid: grid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testSolutionIteration4x4() throws {
		// Arrange
		let size = 4
		let lavel = 220
		let board: Board?
		let matrix =
		"""
		# This puzzle is solvable
		4
		14  2  9  1
		11  4  6  8
		12 10 13  3
		15  5  0  7
		"""
		guard let newMatrix = try self.puzzle?.creationMatrix(text: matrix) else {
			XCTFail("Puzzle nil")
			return
		}
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	
	func testSolutionIteration5x5() throws {
		// Arrange
		let size = 5
		let lavel = 384
		let board: Board?
		let matrix =
		"""
		# This puzzle is solvable
		5
		15 18 11 10 24
		12 13  1  7 14
		 9 22 17  2  0
		 8  6 16  5  4
		23  3 20 21 19
		"""
		guard let newMatrix = try self.puzzle?.creationMatrix(text: matrix) else {
			XCTFail("Puzzle nil")
			return
		}
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
    func testPerformanceSearchSolution3x3() throws {
		// Arrange
		let size = 3
		let matrix =
		"""
		# This puzzle is solvable
		3
		7 6 2
		5 8 4
		3 1 0
		"""
		guard let newMatrix = try self.puzzle?.creationMatrix(text: matrix) else {
			XCTFail("Puzzle nil")
			return
		}
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		
		// Assert
        self.measure {
			// Executed 1 test, with 0 failures (0 unexpected) in 0.960 (0.961) seconds
			self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
        }
    }
	
	func testPerformanceSearchSolution4x4() throws {
		// Arrange
		let size = 4
		let lavel = 210
		let matrix =
		"""
		# This puzzle is solvable
		4
		1 10 11 15
		12 13  6  8
		4  2  7 14
		0  5  3  9
		"""
		guard let newMatrix = try self.puzzle?.creationMatrix(text: matrix) else {
			XCTFail("Puzzle nil")
			return
		}
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
		// Assert
		var board: Board? = nil
		self.measure {
			// Executed 1 test, with 0 failures (0 unexpected) in 1.933 (1.934) seconds
			board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		}
		
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
    func testPerformanceSearchSolution5x5() throws {
		// Arrange
		let size = 5
		let lavel = 434
		let matrix =
		"""
		# This puzzle is solvable
		5
		17  3 10 12  4
		20  9  1 14 22
		23  2  8 21  5
		18  6  7  0 16
		15 11 24 13 19
		"""
		guard let newMatrix = try self.puzzle?.creationMatrix(text: matrix) else {
			XCTFail("Puzzle nil")
			return
		}
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		guard let targetMatrix = self.puzzle?.createMatrixSpiral(size: size) else {
			XCTFail("Puzzle nil")
			return
		}
		let gridTarget = Grid(matrix: targetMatrix)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		
		// Assert
		var board: Board?
        self.measure {
			// Executed 50 tests, with 0 failures (0 unexpected) in 6.732 (6.741) seconds
			board = self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
        }
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
    }

}
