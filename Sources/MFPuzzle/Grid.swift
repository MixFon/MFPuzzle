//
//  Grid.swift
//  
//
//  Created by Михаил Фокин on 28.02.2024.
//

import Foundation

struct GridPoint: Equatable {
	let x: Int8
	let y: Int8
}

/// Класс для работы с матрицей
final class Grid {
	private var matrix: Matrix
	private(set) var size: Int
	private(set) var coordinats = [UInt8: GridPoint]()
	
	var hashValue: Int {
		self.matrix.hashValue
	}
	
	/// Создание доски на основе матрицы и размера
	init(matrix: Matrix) {
		self.size = matrix.count
		self.matrix = matrix
		setCoordinats()
	}
	
	/// Конструктор копирования
	init(from: Grid) {
		self.size = from.size
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
	func getCoordinatsNumber(number: UInt8) -> GridPoint? {
		return self.coordinats[number]
	}
	
	/// Меняет местами номер и пустую клетку местами.
	func swapNumber(number: UInt8) {
		guard let coordinatsNumber = getCoordinatsNumber(number: number) else { return }
		guard let coordinatsZero = getCoordinatsNumber(number: 0) else { return }
		self.matrix[Int(coordinatsNumber.x)][Int(coordinatsNumber.y)] = 0
		self.matrix[Int(coordinatsZero.x)][Int(coordinatsZero.y)] = number
		self.coordinats[number] = coordinatsZero
		self.coordinats[0] = coordinatsNumber
	}
	
	/// Возвращает номера соседних ячеек с нулевой.
	func getNeighbors() -> [UInt8]? {
		var result = [UInt8]()
		guard let coordinats = self.coordinats[0] else { return nil }
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
}

extension Grid: Equatable {
	
	static func == (left: Grid, right: Grid) -> Bool {
		return left.matrix == right.matrix
	}
	
	static func != (left: Grid, right: Grid) -> Bool {
		return !(left == right)
	}
}
