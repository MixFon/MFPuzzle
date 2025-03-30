//
//  Grid.swift
//  
//
//  Created by Михаил Фокин on 28.02.2024.
//

import Foundation

/// Класс для работы с матрицей
open class Grid {
	public private(set) var matrix: Matrix
	private(set) var coordinats = [MatrixElement: GridPoint]()
	
	public var size: Int {
		self.matrix.count
	}
	
	public var hashValue: Int {
		self.matrix.hashValue
	}
	
	/// Создание доски на основе матрицы и размера
	public init(matrix: Matrix) {
		self.matrix = matrix
		setCoordinats()
	}
	
	/// Конструктор копирования
	public init(from: Grid) {
		self.matrix = from.matrix
		self.coordinats = from.coordinats
	}
	
	/// Возврат словаря с координатами ячеек. Используется с для матрицы содержащей ответ.
	private func setCoordinats() {
		for (i, row) in self.matrix.enumerated() {
			for (j, element) in row.enumerated() {
				self.coordinats[element] = GridPoint(x: Int8(i), y: Int8(j))
			}
		}
	}
	
	/// Возвращает координаты ячейки с номером.
	public func getPoint(number: MatrixElement) -> GridPoint? {
		return self.coordinats[number]
	}
	
	/// Меняет местами два указанных номера
	public func swapNumber(number: MatrixElement, target: MatrixElement = 0) {
		guard let coordinatsNumber = getPoint(number: number) else { return }
		guard let coordinatsTarget = getPoint(number: target) else { return }
		self.matrix[Int(coordinatsNumber.x)][Int(coordinatsNumber.y)] = target
		self.matrix[Int(coordinatsTarget.x)][Int(coordinatsTarget.y)] = number
		self.coordinats[number] = coordinatsTarget
		self.coordinats[target] = coordinatsNumber
	}
		
	/// Возвращает номера соседних ячеек.
	public func getNeighbors(number: MatrixElement) -> [MatrixElement]? {
		var result = [MatrixElement]()
		guard let coordinats = self.coordinats[number] else { return nil }
		let x = Int(coordinats.x)
		let y = Int(coordinats.y)
		if coordinats.y - 1 >= 0 {
			result.append(matrix[x][y - 1])
		}
		if coordinats.x - 1 >= 0 {
			result.append(matrix[x - 1][y])
		}
		if coordinats.y + 1 < self.size {
			result.append(matrix[x][y + 1])
		}
		if coordinats.x + 1 < self.size {
			result.append(matrix[x + 1][y])
		}
		return result
	}
	
	/// Определяет, являются ли два номера соседними
	public func isNeighbors(one: MatrixElement, two: MatrixElement) -> Bool? {
		if self.coordinats[one] == nil || self.coordinats[two] == nil { return nil }
		let neighbors = getNeighbors(number: one)
		return neighbors?.contains(two)
	}
	
	public func getNumber(for compass: Compass) -> MatrixElement? {
		guard let zero = self.coordinats[0] else { return nil }
		let x = Int(zero.x)
		let y = Int(zero.y)
		switch compass {
		case .west:
			return isInsidea(x: x, y: y + 1) ? self.matrix[x][y + 1] : nil
		case .east:
			return isInsidea(x: x, y: y - 1) ? self.matrix[x][y - 1] : nil
		case .north:
			return isInsidea(x: x - 1, y: y) ? self.matrix[x - 1][y] : nil
		case .south:
			return isInsidea(x: x + 1, y: y) ? self.matrix[x + 1][y] : nil
		case .needle:
			return nil
		}
	}
	
	/// Позвращает направление от нуля до номера number, если они являются соседями
	public func getCompass(for number: MatrixElement) -> Compass? {
		return getCompass(from: 0, to: number)
	}
	
	/// Возвращает компас от элемента from до элемента to, если они являются соседями
	public func getCompass(from: MatrixElement, to: MatrixElement) -> Compass? {
		guard isNeighbors(one: from, two: to) == true else { return nil }
		let startPoint = getPoint(number: to)
		let endPoint = getPoint(number: from)
		return Compass.calculateCompass(endPoint: endPoint, startPoint: startPoint)
	}
	
	/// Проверяет, находятся ли координаты внутри матрицы
	public func isInsidea(x: Int, y: Int) -> Bool {
		return x < self.size && x >= 0 && y < self.size && y >= 0
	}
	
	/// Проверяет, находятся ли координаты внутри матрицы
	public func isInsidea(point: GridPoint) -> Bool {
		let x = Int(point.x)
		let y = Int(point.y)
		return isInsidea(x: x, y: y)
	}
}

extension Grid: Equatable {
	
	public static func == (left: Grid, right: Grid) -> Bool {
		return left.matrix == right.matrix
	}
	
	public static func != (left: Grid, right: Grid) -> Bool {
		return !(left == right)
	}
}
