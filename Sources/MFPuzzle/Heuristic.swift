//
//  Heuristic.swift
//  N_Puzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import Foundation

enum Heuristic: String {
	case manhattan = "-m"
	case chebyshev = "-ch"
	case euclidean = "-eu"
	case simple = "-s"
	
	/// Возвращает эвристику согласно установленному флагу.
	func getHeuristic(grid: Grid, gridTarget: Grid) -> Int {
		switch self {
		case .manhattan:
			return getDistance(coordinats: grid.coordinats, coordinatsTarget: gridTarget.coordinats, distance: manhattanDistance)
		case .chebyshev:
			return getDistance(coordinats: grid.coordinats, coordinatsTarget: gridTarget.coordinats, distance: chebyshevDistance)
		case .euclidean:
			return getDistance(coordinats: grid.coordinats, coordinatsTarget: gridTarget.coordinats, distance: euclideanDistance)
		default:
			return getDistance(coordinats: grid.coordinats, coordinatsTarget: gridTarget.coordinats, distance: simpleDintance)
		}
	}
	
	/// Вычисляет эвристику на основе переданной функции-формулы.
	private func getDistance(coordinats: [UInt8: GridPoint], coordinatsTarget: [UInt8: GridPoint], distance: (GridPoint, GridPoint) -> Int) -> Int {
		var result = 0
		for element in coordinats {
			let targetCoordinats = coordinatsTarget[element.key]!
			result += distance(element.value, targetCoordinats)
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
