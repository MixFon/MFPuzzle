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
	
	func testSolution4Iteration3x3() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testSolution18Iteration3x3() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testSolution23Iteration3x3() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testSolutionIteration4x4() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	
	func testSolutionIteration5x5() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
		
		// Assert
		XCTAssertNotNil(board)
		XCTAssertEqual(board?.lavel, lavel)
	}
	
	func testCansaletionIteration5x5() async throws {
		// Arrange
		let size = 5
		var board: Board?
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		let task = Task {
			do {
				board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
			} catch {
				XCTAssertTrue(error is CancellationError)
			}
		}
		task.cancel()
		// Assert
		XCTAssertNil(board)
	}
	
	// Почему-то выполняется очень долго примерно 23 секунды
    func testPerformanceSearchSolution3x3() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		
		// Assert
		self.measure {
			let expectation = self.expectation(description: "Performance test")
			Task {
				// Executed 1 test, with 0 failures (0 unexpected) in 1.933 (1.934) seconds
				try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 5)
		}
	}
	
	func testPerformanceSearchSolution4x4() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Assert

		self.measure {
			let expectation = self.expectation(description: "Performance test")
			Task {
				// Executed 1 test, with 0 failures (0 unexpected) in 1.933 (1.934) seconds
				var board: Board? = nil
				board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
				XCTAssertNotNil(board)
				XCTAssertEqual(board?.lavel, lavel)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 5)
		}
	}
	
	func testPerformanceSearchSolution5x5() async throws {
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
		let newGrid = Grid<MatrixElement>(matrix: newMatrix, zero: 0)
		let startBoard = Board(grid: newGrid)
		
		let targetMatrix = worker.createMatrixSnail(size: size)
		let gridTarget = Grid<MatrixElement>(matrix: targetMatrix, zero: 0)
		let targetBoard = Board(grid: gridTarget)
		
		// Act
		
		// Assert
		self.measure {
			let expectation = self.expectation(description: "Performance test")
			Task {
				var board: Board? = nil
				// Executed 50 tests, with 0 failures (0 unexpected) in 6.732 (6.741) seconds
				board = try await self.puzzle?.searchSolutionWithHeap(board: startBoard, boardTarget: targetBoard)
				XCTAssertNotNil(board)
				XCTAssertEqual(board?.lavel, lavel)
				expectation.fulfill()
			}
			wait(for: [expectation], timeout: 5)
		}
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
		var board = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
			newBoard.parent = board
			board = newBoard
		}
		let compassesAnswers: [Compass] = [.south, .south, .west, .west, .north, .east, .north, .east]
		
		// Act
		let compasses = puzzle.createPath(board: board)
		
		// Assert
		XCTAssertEqual(compasses, compassesAnswers)
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
		var board = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
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
		var board = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
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
		var board = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
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
		var board = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
		for matrix in matrixes {
			let newBoard = Board(grid: Grid<MatrixElement>(matrix: matrix, zero: 0))
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
