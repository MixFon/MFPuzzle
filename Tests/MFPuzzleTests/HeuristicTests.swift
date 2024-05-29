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
		let grid = Grid(matrix: matrix)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 0)
	}
	
	func testGetHeuristicManhattan() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 0, 8]]
		let grid = Grid(matrix: matrix)
		let matrixSolution: Matrix =
		[[1, 2, 3],
		 [4, 5, 6],
		 [7, 8, 0]]
		let gridSolution = Grid(matrix: matrixSolution)
		let heuristic = Heuristic.manhattan
		
		// Act
		let value = heuristic.getHeuristic(grid: grid, gridTarget: gridSolution)
		
		// Assert
		XCTAssertEqual(value, 0)
	}
}
