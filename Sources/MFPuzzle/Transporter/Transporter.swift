//
//  Transporter.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

public protocol _Transporter {
	/// Создает для каждого номера массив направлений перемещений до его цели.
	func createDirections(from current: [[Int]], to solution: [[Int]]) throws -> [Int : [Direction]]
	/// Создание для каждого номера короткого пути. Комбинация из Direction, для достижения точки в solution
	func createShortestPath(from current: [[Int]], to solution: [[Int]]) -> [Int : [Direction]]
}

final public class Transporter: _Transporter {
	
	public init() {}
	
	public func createDirections(from current: [[Int]], to solution: [[Int]]) throws -> [Int : [Direction]] {
		if current.isEmpty || solution.isEmpty { return [:] }
		var cube = createCube(size: current[0].count)
		cube[cube.count / 2] = current
		let grid3D = Grid3D(cube: cube)
		let shortestPath = createShortestPath(from: current, to: solution)
		let boxes: [Box] = shortestPath.map { Box(number: $0.key, shortestPath: $0.value) }
		var i = current.count * current.count * current.count
		while !boxes.allSatisfy( { $0.shortestPath.isEmpty }) {
			for box in boxes {
				if box.shortestPath.isEmpty { continue }
				isAvalableDirectionOnMiddle(box: box, grid3D: grid3D)
			}
			i -= 1
			if i <= 0 {
				//throw TransporterError.limitAttemptsHasBeenReached
			}
		}
		var result: [Int : [Direction]] = [:]
		for box in boxes {
			result[box.number] = box.path
		}
		return result
	}
	
	private func createCube(size: Int) -> [[[Int]]] {
		var value = 0
		var cube: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: size), count: size), count: 9)
		for (k, matrix) in cube.enumerated() {
			for (i, row) in matrix.enumerated() {
				for (j, _) in row.enumerated() {
					value -= 1
					cube[k][i][j] = value
				}
			}
		}
		return cube
	}
	
	/// true если нашел на среднем уровне направдение.
	/// false если на среднем уровне нельзя сделать шаг
	private func isAvalableDirectionOnMiddle(box: Box, grid3D: Grid3D<Int>) {
		guard let currentPoint = grid3D.getPoint(number: box.number) else { return }
		let availableDirections = box.availableDirections
		for availableDirection in availableDirections {
			let nextPoint = currentPoint.getByAdding(from: availableDirection)
			if let target = grid3D.getNumber(point: nextPoint), target <= 0 {
				box.path.append(availableDirection)
				box.deleteDirectionForShortPath(availableDirection)
				grid3D.swapNumber(number: box.number, target: target)
				return
			}
		}
		for availableDirection in availableDirections {
			if isUpOrDown(availableDirection) { continue }
			let upPoint = currentPoint.getByAdding(from: .up(nil))
			if !grid3D.isInsidea(point: upPoint) { continue }
			let nextPoint = upPoint.getByAdding(from: availableDirection)
			if let target = grid3D.getNumber(point: nextPoint), let upNumber = grid3D.getNumber(point: upPoint) {
				if target > 0 || upNumber > 0 { continue }
				box.path.append(.up(availableDirection))
				box.shortestPath.append(.down(nil))
				box.deleteDirectionForShortPath(availableDirection)
				grid3D.swapNumber(number: box.number, target: target)
				return
			}
		}
		for availableDirection in availableDirections {
			if isUpOrDown(availableDirection) { continue }
			let donwPoint = currentPoint.getByAdding(from: .down(nil))
			if !grid3D.isInsidea(point: donwPoint) { continue }
			let nextPoint = donwPoint.getByAdding(from: availableDirection)
			if let target = grid3D.getNumber(point: nextPoint), let downNumber = grid3D.getNumber(point: donwPoint) {
				if target > 0 || downNumber > 0 { continue }
				box.path.append(.down(availableDirection))
				box.shortestPath.append(.up(nil))
				box.deleteDirectionForShortPath(availableDirection)
				grid3D.swapNumber(number: box.number, target: target)
				return
			}
		}
		// Если ни в одно направление не удалось попать, то добавляем паузу
		box.path.append(.pause)
		return
	}
	
	private func isUpOrDown(_ direction: Direction) -> Bool {
		switch direction {
		case .up, .down:
			return true
		default:
			return false
		}
	}
	
	public func createShortestPath(from current: [[Int]], to solution: [[Int]]) -> [Int : [Direction]] {
		let currentGrid = Grid(matrix: current)
		let solutionGrid = Grid(matrix: solution)
		var result: [Int : [Direction]] = [:]
		for row in current {
			for element in row {
				if element == 0 { continue }
				guard let pointCurrentElemnt = currentGrid.getPoint(number: element) else { continue }
				guard let pointSolutionElemnt = solutionGrid.getPoint(number: element) else { continue }
				let diffX = pointCurrentElemnt.x - pointSolutionElemnt.x
				if diffX < 0 {
					result[element] = Array(repeating: .south, count: Int(abs(diffX)))
				} else {
					result[element] = Array(repeating: .north, count: Int(abs(diffX)))
				}
				let diffY = pointCurrentElemnt.y - pointSolutionElemnt.y
				if diffY < 0 {
					result[element]?.append(contentsOf: Array(repeating: .east, count: Int(abs(diffY))))
				} else {
					result[element]?.append(contentsOf: Array(repeating: .west, count: Int(abs(diffY))))
				}
			}
		}
		return result
	}
}
