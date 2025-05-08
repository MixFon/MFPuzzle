//
//  MatrixRondomazer.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 31.03.2025.
//

import MFPuzzle
import Foundation

protocol _MatrixRondomazer {
	associatedtype RantomType
	/// Производит перемешивание элементов матрицы
	func generateRangomSteps(matrix: [[RantomType]], zero: RantomType) -> [[RantomType]]
}

final class MatrixRondomazer<T: Hashable>: _MatrixRondomazer {
	typealias RantomType = T
	func generateRangomSteps(matrix: [[T]], zero: T) -> [[T]] {
		let grid = Grid<T>(matrix: matrix, zero: zero)
		let countSteps = Int.random(in: 1000...100000)
		for _ in 0...countSteps {
			if let randomNeighbors = grid.getNeighbors(number: zero)?.randomElement() {
				grid.swapNumber(number: randomNeighbors, target: zero)
			}
		}
		return grid.matrix
	}
}
