//
//  Board.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import Foundation

// Класс предназначенный для поиска решения головоломки
public final class Board {
	public private(set) var grid: Grid<MatrixElement>
	
	private(set) var f: Int
	var lavel: Int
	var parent: Board?
	
	var hashValue: Int {
		self.grid.hashValue
	}
	
	// Конструктор с доской
	public init(grid: Grid<MatrixElement>) {
		self.f = 0
		self.lavel = 0
		self.grid = grid
	}
	
	/// Устанавливает значение f
	func setF(heuristic: Int) {
		if self.grid.size == 3 {
			self.f = self.lavel + heuristic
		} else {
			self.f = heuristic
		}
	}
	
	/// Возвращает список смежных состояний. Состояний, в которые можно перейти
	func getChildrens(calculateHeuristic: (MatrixElement, GridPoint) -> Int? ) -> [Board]? {
		guard let neighbors = self.grid.getNeighbors(number: 0) else { return nil }
		var childrens = [Board]()
		let zeroPoint = self.grid.coordinats[0]!
		let heuristicCurrentZero = calculateHeuristic(0, zeroPoint) ?? 0
		for number in neighbors {
			let newGrid = Grid(from: self.grid, zero: 0)
			let numberPoint = self.grid.coordinats[number]!
			let heuristicNumber = calculateHeuristic(number, numberPoint) ?? 0
			
			newGrid.swapNumber(number: number, target: 0)
			
			let newZeroPoint = newGrid.coordinats[0]!
			let newNuberPoint = newGrid.coordinats[number]!
			let newHeuristicZero = calculateHeuristic(0, newZeroPoint) ?? 0
			let newHeuristicNumber = calculateHeuristic(number, newNuberPoint) ?? 0
			
			let f = self.f + (newHeuristicZero - heuristicCurrentZero) + (newHeuristicNumber - heuristicNumber)
			let newBoard = Board(grid: newGrid)
			newBoard.lavel = self.lavel + 1
			newBoard.setF(heuristic: f)
			childrens.append(newBoard)
		}
		return childrens
	}
}

extension Board: Equatable {
	
	public static func == (left: Board, right: Board) -> Bool {
		return left.grid == right.grid
	}
	
	public static func != (left: Board, right: Board) -> Bool {
		return !(left == right)
	}
}
