//
//  Board.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import Foundation

struct BoardPoint: Equatable {
	let x: Int8
	let y: Int8
}

final class Board {
	private(set) var f: Int
	private(set) var size: Int
	private(set) var lavel: Int
	private(set) var matrix: Matrix
	private(set) var parent: Board?
	private(set) var coordinats = [UInt8: BoardPoint]()
	
	/// Создание доски на основе матрицы и размера
	init(matrix: Matrix) {
		self.size = matrix.count
		self.matrix = matrix
		self.f = 0
		self.lavel = 0
		setCoordinats()
	}
	
	/// Конструктор копирования.
	init(board: Board) {
		self.size = board.size
		self.matrix = board.matrix
		self.f = board.f
		self.lavel = board.lavel + 1
		self.parent = board
		self.coordinats = board.coordinats
	}
	
	/// Устанавливает значение f
	func setF(heuristic: Int) {
		if self.size == 3 {
			self.f = self.lavel + heuristic
		} else {
			self.f = heuristic
		}
	}
	
	/// Возвращает координаты ячейки с номером.
	func getCoordinatsNumber(number: UInt8) -> BoardPoint? {
		return self.coordinats[number]
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
	
	/// Возвращает список смежных состояний. Состояний, в которые можно перейти
	func getChildrens() -> [Board]? {
		guard let neighbors = getNeighbors() else { return nil }
		var childrens = [Board]()
		for number in neighbors {
			let newBoard = Board(board: self)
			newBoard.swapNumber(number: number)
			childrens.append(newBoard)
		}
		return childrens
	}
	
	/// Печатает доску.
	func print() {
		Swift.print("State: ", self.lavel)
		Swift.print("Weight:", self.f)
		for row in matrix {
			var line = String()
			for col in row {
				line.append(String(format: "%02d ", col))
			}
			Swift.print(line)
		}
		Swift.print()
	}
	
	/// Возврат словаря с координатами ячеек. Используется с для матрицы содержащей ответ.
	private func setCoordinats() {
		for (i, row) in self.matrix.enumerated() {
			for (j, element) in row.enumerated() {
				self.coordinats[element] = BoardPoint(x: Int8(i), y: Int8(j))
			}
		}
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
}

extension Board: Equatable {
	
	static func == (left: Board, right: Board) -> Bool {
		return left.matrix == right.matrix
	}
	
	static func != (left: Board, right: Board) -> Bool {
		return !(left == right)
	}
}
