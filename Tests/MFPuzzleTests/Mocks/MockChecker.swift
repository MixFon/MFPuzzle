//
//  MockChecker.swift
//
//
//  Created by Михаил Фокин on 31.05.2024.
//

import Foundation
import MFPuzzle

final class MockChecker: _Checker {
	func getCoupleInversion(matrix: Matrix) -> [(GridPoint, GridPoint)] {
		[]
	}
	
	func checkUniqueElementsMatrix(matrix: Matrix) -> Bool {
		true
	}
	
	func isSquereMatrix(matrix: Matrix) -> Bool {
		true
	}
	
	func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool {
		true
	}
}
