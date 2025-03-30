//
//  Grid3D.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

import Foundation

open class Grid3D<T: Hashable> {
	
	public private(set) var cube: [[[T]]]
	private(set) var coordinats = [T: Grid3DPoint]()
	
	init(cube: [[[T]]]) {
		self.cube = cube
		setCoordinats()
	}
	
	public var size: Int {
		self.cube.count
	}
	
	/// Конструктор копирования
	public init(from: Grid3D) {
		self.cube = from.cube
		self.coordinats = from.coordinats
	}
	
	/// Возврат словаря с координатами ячеек. Используется с для матрицы содержащей ответ.
	private func setCoordinats() {
		for (k, matrix) in self.cube.enumerated() {
			for (i, row) in matrix.enumerated() {
				for (j, element) in row.enumerated() {
					self.coordinats[element] = Grid3DPoint(x: Int8(i), y: Int8(j), z: Int8(k))
				}
			}
		}
	}
	
	/// Возвращает координаты ячейки с номером.
	public func getPoint(number: T) -> Grid3DPoint? {
		return self.coordinats[number]
	}
	
	/// Возвращает номер по координате
	public func getNumber(point: Grid3DPoint) -> T? {
		guard isInsidea(point: point) else { return nil }
		return self.cube[Int(point.z)][Int(point.x)][Int(point.y)]
	}
	
	/// Меняет два номера местами.
	public func swapNumber(number: T, target: T) {
		guard let coordinatsNumber = getPoint(number: number) else { return }
		guard let coordinatsTarget = getPoint(number: target) else { return }
		self.cube[Int(coordinatsNumber.z)][Int(coordinatsNumber.x)][Int(coordinatsNumber.y)] = target
		self.cube[Int(coordinatsTarget.z)][Int(coordinatsTarget.x)][Int(coordinatsTarget.y)] = number
		self.coordinats[number] = coordinatsTarget
		self.coordinats[target] = coordinatsNumber
	}
	
	/// Проверяет, находятся ли координаты внутри квадратной матрицы
	public func isInsidea(x: Int, y: Int, z: Int) -> Bool {
		return x < self.size && x >= 0 && y < self.size && y >= 0 && z < self.size && z >= 0
	}
	
	/// Проверяет, находятся ли координаты внутри матрицы
	public func isInsidea(point: Grid3DPoint) -> Bool {
		let x = Int(point.x)
		let y = Int(point.y)
		let z = Int(point.z)
		return isInsidea(x: x, y: y, z: z)
	}

}
