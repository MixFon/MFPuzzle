//
//  Checker.swift
//
//
//  Created by Михаил Фокин on 28.01.2024.
//

import Foundation

public protocol _Checker {
	func checkUniqueElementsMatrix(matrix: Matrix) -> Bool
	/// Определяет является ли матрица квадратной
	func isSquereMatrix(matrix: Matrix) -> Bool
	func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool
}

open class Checker: _Checker {
	
	public init() { }
	
	/// Производит проверку доски. Элементы должны быть уникальны.
	public func checkUniqueElementsMatrix(matrix: Matrix) -> Bool {
		let arr = matrix.flatMap({$0})
		let elementsMatrix = Set<MatrixElement>(arr)
		var maxElem: MatrixElement = 0
		for elem in elementsMatrix {
			if elem > maxElem { maxElem = elem }
		}
		return elementsMatrix.count == arr.count && (maxElem == arr.count - 1)
	}
	
	/// Проверяет существет ли решение головоломки.
	public func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool {
		let summa = getSummInversion(matrix: matrix)
		let summaTarget = getSummInversion(matrix: matrixTarget)
		return summa % 2 == summaTarget % 2
	}
	
	public func isSquereMatrix(matrix: Matrix) -> Bool {
		if matrix.isEmpty { return false }
		let count = matrix.count
		for row in matrix {
			if row.count != count {
				return false
			}
		}
		return true
	}
	
	/// Возвращает количество инвариантов.
	func getSummInversion(matrix: Matrix) -> Int {
		var summ = 0
		var arry = [MatrixElement]()
		for (i, line) in matrix.enumerated() {
			if i % 2 == 0 {
				arry.append(contentsOf: line)
			} else {
				arry.append(contentsOf: line.reversed())
			}
		}
		arry.removeAll(where: { $0 == 0 })
		for (i, elem) in arry.enumerated() {
			for elemIter in arry[(i + 1)...] {
				if elem > elemIter {
					summ += 1
				}
			}
		}
		return summ
	}
	
	/// Возвращает коодинату x у нуля
	func getCoordinateXZero(matrix: Matrix) -> Int? {
		for row in matrix {
			for (j, element) in row.enumerated() {
				if element == 0 { return j }
			}
		}
		return nil
	}
}
