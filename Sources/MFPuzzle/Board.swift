//
//  Board.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import Foundation

// Класс предназначенный для поиска решения головоломки
final class Board {
	private(set) var f: Int
	private(set) var grid: Grid
	var lavel: Int
	var parent: Board?
	
	var hashValue: Int {
		self.grid.hashValue
	}
	
	// Конструктор с доской
	init(grid: Grid) {
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
	func getChildrens() -> [Board]? {
		guard let neighbors = self.grid.getNeighbors() else { return nil }
		var childrens = [Board]()
		for number in neighbors {
			let newGrid = Grid(from: self.grid)
			newGrid.swapNumber(number: number)
			
			let newBoard = Board(grid: newGrid)
			newBoard.lavel = self.lavel + 1
			newBoard.parent = self
			childrens.append(newBoard)
		}
		return childrens
	}
}

extension Board: Equatable {
	
	static func == (left: Board, right: Board) -> Bool {
		return left.grid == right.grid
	}
	
	static func != (left: Board, right: Board) -> Bool {
		return !(left == right)
	}
}
