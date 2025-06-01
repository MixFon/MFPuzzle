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
	/// Поиск решения, используя алгоритм A* с ограничением длины кучи
	func searchSolutionWithHeap(board: Board, limiter: Int?, boardTarget: Board) async throws -> Board?
}

final public class Puzzle: _Puzzle, @unchecked Sendable {
	
	private var heuristic: Heuristic = .manhattan
	
	public init(heuristic: Heuristic) {
		self.heuristic = heuristic
	}
	
	public func createPath(board: Board?) -> [Compass] {
		var iter = board
		var compasses: [Compass] = []
		while iter != nil {
			let startPoint = iter?.grid.getPoint(number: 0)
			let endPoint = iter?.parent?.grid.getPoint(number: 0)
			if let compass = Compass.calculateCompass(endPoint: endPoint, startPoint: startPoint) {
				compasses.append(compass)
			}
			iter = iter?.parent
		}
		return compasses
	}

	@discardableResult
	public func searchSolutionWithHeap(board: Board, limiter: Int? = nil, boardTarget: Board) async throws -> Board? {
		let heap = MFLimitedHeap<Board>(limiter: limiter, priorityFunction: {$0.f < $1.f})
		let heuristic = self.heuristic.getHeuristic(grid: board.grid, gridTarget: boardTarget.grid)
		board.setF(heuristic: heuristic)
		heap.insert(board)
		var visited = Set<Int>()
		while let board = heap.extract() {
			try Task.checkCancellation()
			if board == boardTarget {
				return board
			}
			guard let children = board.getChildrens(calculateHeuristic: {  [weak self] element, point in
				guard let endPoint = boardTarget.grid.coordinats[element] else { return nil }
				return self?.heuristic.distance(point, endPoint)
			}) else { continue }
			for child in children {
				if !visited.contains(child.hashValue) {
					// Только если не было добавлен назначаем предка
					child.parent = board
					heap.insert(child) { deleteChild in
						deleteChild?.parent = nil
					}
				}
			}
			visited.insert(board.hashValue)
		}
		return nil
	}
}
