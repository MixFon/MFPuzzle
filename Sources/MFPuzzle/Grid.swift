//
//  Grid.swift
//  
//
//  Created by Михаил Фокин on 28.02.2024.
//

import Foundation

public struct GridPoint: Equatable {
	let x: Int8
	let y: Int8
}

/// Класс для работы с матрицей
open class Grid {
	public private(set) var matrix: Matrix
	private(set) var coordinats = [UInt8: GridPoint]()
	
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
	public func getPoint(number: UInt8) -> GridPoint? {
		return self.coordinats[number]
	}
	
	/// Меняет местами номер и пустую клетку местами.
	public func swapNumber(number: UInt8) {
		guard let coordinatsNumber = getPoint(number: number) else { return }
		guard let coordinatsZero = getPoint(number: 0) else { return }
		self.matrix[Int(coordinatsNumber.x)][Int(coordinatsNumber.y)] = 0
		self.matrix[Int(coordinatsZero.x)][Int(coordinatsZero.y)] = number
		self.coordinats[number] = coordinatsZero
		self.coordinats[0] = coordinatsNumber
	}
	
	/// Возвращает номера соседних ячеек.
	public func getNeighbors(number: UInt8) -> [UInt8]? {
		var result = [UInt8]()
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
	public func isNeighbors(one: UInt8, two: UInt8) -> Bool? {
		if self.coordinats[one] == nil || self.coordinats[two] == nil { return nil }
		let neighbors = getNeighbors(number: one)
		return neighbors?.contains(two)
		
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
