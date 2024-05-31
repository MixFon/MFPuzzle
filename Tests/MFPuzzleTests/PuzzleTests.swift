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
	// MARK: Testing solution
	
	func testSolution4Iteration3x3() throws {
		// Arrange
		let size = 3
		let lavel = 4
		let board: Board?
		let matrix =
		"""
		# This puzzle is solvable 4 iteration
		3
		0 2 3
		1 6 4
		8 7 5
		"""
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		let matrix =
		"""
		# This puzzle is solvable
		3
		0 3 2
		8 7 5
		6 4 1
		"""
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		let matrix =
		"""
		# This puzzle is solvable
		3
		7 6 2
		5 8 4
		3 1 0
		"""
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
		let checker = Checker()
		let worker = MatrixWorker(checker: checker)
		
		let newMatrix = try worker.creationMatrix(text: matrix)
		let newGrid = Grid(matrix: newMatrix)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
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
	
	func testCreatePath() {
		// Arrange
		let mockChecket = MockChecker()
		let puzzle = Puzzle(heuristic: .manhattan, checker: mockChecket)
		let matrixes: [Matrix] = [
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 0, 8]],
		[[1, 2, 3],
		 [6, 0, 4],
		 [7, 5, 8]],
		[[1, 2, 3],
		 [0, 6, 4],
		 [7, 5, 8]],
		[[0, 2, 3],
		 [1, 6, 4],
		 [7, 5, 8]],
		[[2, 0, 3],
		 [1, 6, 4],
		 [7, 5, 8]],
		[[2, 3, 0],
		 [1, 6, 4],
		 [7, 5, 8]],
		[[2, 3, 4],
		 [1, 6, 0],
		 [7, 5, 8]],
		[[2, 3, 4],
		 [1, 6, 0],
		 [7, 5, 8]],
		[[2, 3, 4],
		 [1, 6, 8],
		 [7, 5, 0]]
		]
		
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		var board = Board(grid: Grid(matrix: matrix))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid(matrix: matrix))
			newBoard.parent = board
			board = newBoard
		}
		let compassesAnswers: [Compass] = [.east, .north, .east, .north, .west, .west, .south, .south]
		
		// Act
		let compasses = puzzle.createPath(board: board)
		
		// Assert
		XCTAssertEqual(compasses, compassesAnswers.reversed())
	}
	
	func testCreateEast() {
		// Arrange
		let mockChecket = MockChecker()
		let puzzle = Puzzle(heuristic: .manhattan, checker: mockChecket)
		let matrixes: [Matrix] = [
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 0, 8]]]
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		var board = Board(grid: Grid(matrix: matrix))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid(matrix: matrix))
			newBoard.parent = board
			board = newBoard
		}
		let compassesAnswers: [Compass] = [.east]
		
		// Act
		let compasses = puzzle.createPath(board: board)
		
		// Assert
		XCTAssertEqual(compasses, compassesAnswers)
	}
	
	func testCreateWest() {
		// Arrange
		let mockChecket = MockChecker()
		let puzzle = Puzzle(heuristic: .manhattan, checker: mockChecket)
		let matrixes: [Matrix] = [
		[[1, 2, 3],
		 [6, 4, 0],
		 [7, 5, 8]]]
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 0, 4],
		 [7, 5, 8]]
		var board = Board(grid: Grid(matrix: matrix))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid(matrix: matrix))
			newBoard.parent = board
			board = newBoard
		}
		let compassesAnswers: [Compass] = [.west]
		
		// Act
		let compasses = puzzle.createPath(board: board)
		
		// Assert
		XCTAssertEqual(compasses, compassesAnswers)
	}
	
	func testCreateNorth() {
		// Arrange
		let mockChecket = MockChecker()
		let puzzle = Puzzle(heuristic: .manhattan, checker: mockChecket)
		let matrixes: [Matrix] = [
		[[1, 0, 3],
		 [6, 2, 4],
		 [7, 5, 8]]]
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 0, 4],
		 [7, 5, 8]]
		var board = Board(grid: Grid(matrix: matrix))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid(matrix: matrix))
			newBoard.parent = board
			board = newBoard
		}
		let compassesAnswers: [Compass] = [.north]
		
		// Act
		let compasses = puzzle.createPath(board: board)
		
		// Assert
		XCTAssertEqual(compasses, compassesAnswers)
	}
	
	func testCreateSouth() {
		// Arrange
		let mockChecket = MockChecker()
		let puzzle = Puzzle(heuristic: .manhattan, checker: mockChecket)
		let matrixes: [Matrix] = [
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 0, 8]]]
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 0, 4],
		 [7, 5, 8]]
		var board = Board(grid: Grid(matrix: matrix))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid(matrix: matrix))
			newBoard.parent = board
			board = newBoard
		}
		let compassesAnswers: [Compass] = [.south]
		
		// Act
		let compasses = puzzle.createPath(board: board)
		
		// Assert
		XCTAssertEqual(compasses, compassesAnswers)
	}

}
