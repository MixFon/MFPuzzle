//
//  HeuristicTests.swift
//  
//
//  Created by Михаил Фокин on 29.05.2024.
//

import XCTest
@testable import MFPuzzle

final class HeuristicTests: XCTestCase {
	
	func testGetHeuristicManhattanZero() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let grid = Grid(matrix: matrix, zero: 0)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution, zero: 0)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 0)
	}
	
	func testGetHeuristicManhattanOne() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 0, 8]]
		let grid = Grid(matrix: matrix, zero: 0)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution, zero: 0)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 2)
	}
	
	func testGetHeuristicManhattanTwo() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 0, 6],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix, zero: 0)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution, zero: 0)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 4)
	}
	
	func testGetHeuristicManhattanThree() {
		// Arrange
		let matrix: Matrix =
		[[0, 1, 2],
		 [4, 6, 3],
		 [7, 5, 8]]
		let grid = Grid(matrix: matrix, zero: 0)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution, zero: 0)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 10)
	}
	
	func testGetHeuristicManhattanFive() {
		// Arrange
		let matrix: Matrix =
		[[5, 4, 2],
		 [0, 1, 3],
		 [6, 7, 8]]
		let grid = Grid(matrix: matrix, zero: 0)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution, zero: 0)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 16)
	}
	
}
