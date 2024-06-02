//
//  Heuristic.swift
//  N_Puzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import Foundation

public enum Heuristic: String {
	case simple = "-s"
	case manhattan = "-m"
	case chebyshev = "-ch"
	case euclidean = "-eu"
	
	var distance : ((GridPoint, GridPoint) -> Int) {
		switch self {
		case .manhattan:
			return manhattanDistance
		case .chebyshev:
			return chebyshevDistance
		case .euclidean:
			return euclideanDistance
		case .simple:
			return simpleDintance
		}
	}
	
	/// Возвращает эвристику согласно установленному флагу.
	func getHeuristic(grid: Grid, gridTarget: Grid) -> Int {
		return calculateDistance(coordinats: grid.coordinats, coordinatsTarget: gridTarget.coordinats, distance: self.distance)
	}
	
	/// Вычисляет эвристику на основе переданной функции-формулы.
	private func calculateDistance(coordinats: [MatrixElement: GridPoint], coordinatsTarget: [MatrixElement: GridPoint], distance: (GridPoint, GridPoint) -> Int) -> Int {
		var result = 0
		for element in coordinats {
			if let targetCoordinats = coordinatsTarget[element.key] {
				result += distance(element.value, targetCoordinats)
			}
		}
		return result
	}
	
	/// Эвристика манхетонского расстояния.
	private func manhattanDistance(coordinats: GridPoint, coordinatsTarget: GridPoint) -> Int {
		return Int(abs(coordinats.x - coordinatsTarget.x) + abs(coordinats.y - coordinatsTarget.y))
	}
	
	/// Эвристика растояния Чебышева.
	private func chebyshevDistance(coordinats: GridPoint, coordinatsTarget: GridPoint) -> Int {
		return Int(max(abs(coordinats.x - coordinatsTarget.x), abs(coordinats.y - coordinatsTarget.y)))
	}
	
	/// Эвристика Эвклидова расстояния.
	private func euclideanDistance(coordinats: GridPoint, coordinatsTarget: GridPoint) -> Int {
		let left = pow(Double(coordinats.x - coordinatsTarget.x), 2.0)
		let right = pow(Double(coordinats.y - coordinatsTarget.y), 2.0)
		return Int(sqrt(left + right))
	}
	
	/// Эвристика высчитывающая количество элементов не на своих местах.
	private func simpleDintance(coordinats: GridPoint, coordinatsTarget: GridPoint) -> Int {
		return coordinats == coordinatsTarget ? 0 : 1
	}
}
