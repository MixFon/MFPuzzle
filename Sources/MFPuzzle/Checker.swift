//
//  Checker.swift
//
//
//  Created by Михаил Фокин on 28.01.2024.
//

import Foundation

public protocol _Checker {
	func checkUniqueElementsMatrix(matrix: Matrix) -> Bool
	func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool
	/// Возвращает пары координат инверсий
	func getCoupleInversion(matrix: Matrix) -> [(GridPoint, GridPoint)]
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
	
	/// Возвращает количество инвариантов.
	func getSummInversion(matrix: Matrix) -> Int {
		return getCoupleInversion(matrix: matrix).count
	}
	
	/// Возвращает количество инвариантов.
	public func getCoupleInversion(matrix: Matrix) -> [(GridPoint, GridPoint)] {
		var arry = [MatrixElement]()
		for (i, line) in matrix.enumerated() {
			if i % 2 == 0 {
				arry.append(contentsOf: line)
			} else {
				arry.append(contentsOf: line.reversed())
			}
		}
		arry.removeAll(where: { $0 == 0 })
		var resultMatrixElement: [(MatrixElement, MatrixElement)] = []
		for (i, elem) in arry.enumerated() {
			for elemIter in arry[(i + 1)...] {
				if elem > elemIter {
					resultMatrixElement.append((elem, elemIter))
				}
			}
		}
		var result: [(GridPoint, GridPoint)] = []
		for pair in resultMatrixElement {
			if let point1 = getGridPoint(matrix: matrix, element: pair.0),
			   let point2 = getGridPoint(matrix: matrix, element: pair.1) {
				result.append((point1, point2))
			}
		}
		return result
	}
	
	func getGridPoint(matrix: Matrix, element: MatrixElement) -> GridPoint? {
		for (i, row) in matrix.enumerated() {
			for (j, elem) in row.enumerated() {
				if elem == element {
					return GridPoint(x: Int8(i), y: Int8(j))
				}
			}
		}
		return nil
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
