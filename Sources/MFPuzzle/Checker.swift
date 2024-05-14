//
//  Checker.swift
//
//
//  Created by Михаил Фокин on 28.01.2024.
//

import Foundation

protocol _Checker {
	func checkUniqueElementsMatrix(matrix: Matrix) -> Bool
	func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool
}

final class Checker: _Checker {
	
	/// Производит проверку доски. Элементы должны быть уникальны.
	func checkUniqueElementsMatrix(matrix: Matrix) -> Bool {
		let arr = matrix.flatMap({$0})
		let elementsMatrix = Set<MatrixElement>(arr)
		var maxElem: MatrixElement = 0
		for elem in elementsMatrix {
			if elem > maxElem { maxElem = elem }
		}
		return elementsMatrix.count == arr.count && (maxElem == arr.count - 1)
	}
	
	/// Проверяет существет ли решение головоломки.
	func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool {
		let summa = getSummInversion(matrix: matrix)
		let summaTarget = getSummInversion(matrix: matrixTarget)
		let coordinateZeroBoard = getCoordinateXZero(matrix: matrix)! + summa + 1
		let coordinateZeroBoardTarget = getCoordinateXZero(matrix: matrixTarget)! + summaTarget + 1
		if matrix.count % 2 == 0 {
			return coordinateZeroBoard % 2 == coordinateZeroBoardTarget % 2
		} else {
			return summa % 2 == summaTarget % 2
		}
	}
	
	/// Возвращает количество инвариантов.
	func getSummInversion(matrix: Matrix) -> Int {
		var summ = 0
		var arry = [MatrixElement]()
		for row in matrix {
			for elem in row {
				if elem != 0 {
					arry.append(elem)
				}
			}
		}
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
