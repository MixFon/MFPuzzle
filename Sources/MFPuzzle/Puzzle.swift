//
//  Pazzle.swift
//  N_Puzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import MFStructs
import Foundation
public protocol _Puzzle {
	///  Создает путь в котором содержится последовательность перемещений нуля
	func createPath(board: Board?) -> [Compass]
	/// Поиск решения, используя алгоритм A*
	func searchSolutionWithHeap(board: Board, boardTarget: Board) -> Board?
}

final class Puzzle: _Puzzle {
	
	private var heuristic: Heuristic = .manhattan
	private let checker: _Checker
	
	init(heuristic: Heuristic, checker: _Checker) {
		self.heuristic = heuristic
		self.checker = checker
	}
	
	func createPath(board: Board?) -> [Compass] {
		var iter = board
		var compasses: [Compass] = []
		while iter != nil {
			let startPoint = iter?.grid.getPoint(number: 0)
			let endPoint = iter?.parent?.grid.getPoint(number: 0)
			if let compass = calculateCompass(endPoint: endPoint, startPoint: startPoint) {
				compasses.append(compass)
			}
			iter = iter?.parent
		}
		return compasses
	}
	
	func calculateCompass(endPoint: GridPoint?, startPoint: GridPoint?) -> Compass? {
		guard let endPoint, let startPoint else { return nil }
		let diff = endPoint - startPoint
		switch diff {
		case GridPoint(x: 0, y: 1):
			return .east
		case GridPoint(x: 0, y: -1):
			return .west
		case GridPoint(x: 1, y: 0):
			return .north
		case GridPoint(x: -1, y: 0):
			return .south
		default:
			return nil
		}
	}
	
	/// Поиск решения, используя алгоритм A*
	@discardableResult
	func searchSolutionWithHeap(board: Board, boardTarget: Board) -> Board? {
		let heap = MFHeap<Board>(priorityFunction: {$0.f < $1.f})
		let heuristic = self.heuristic.getHeuristic(grid: board.grid, gridTarget: boardTarget.grid)
		board.setF(heuristic: heuristic)
		heap.insert(board)
		var visited = Set<Int>()
		while let board = heap.extract() {
			if board == boardTarget {
				return board
			}
			guard let children = board.getChildrens(calculateHeuristic: {  [weak self] element, point in
				guard let endPoint = boardTarget.grid.coordinats[element] else { return nil }
				return self?.heuristic.distance(point, endPoint)
			}) else { continue }
			for board in children {
				if !visited.contains(board.hashValue) {
					heap.insert(board)
				}
			}
			visited.insert(board.hashValue)
		}
		return nil
	}
}
