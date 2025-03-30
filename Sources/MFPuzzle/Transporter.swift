//
//  File.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

/// Описывает возможные пути перемещения в 3-х мерном массве
public enum Direction {
	/// Направдление на уровень выше текущего
	case up
	/// Направлнение влево (запад)
	case west
	/// Направлнение вправо (восток)
	case east
	/// Направлнение ввех (север)
	case north
	/// Направлнение вниз (юг)
	case south
	/// Направлнение на уровень ниже текущего
	case down
}

public protocol _Transporter {
	/// Создает для каждого номера массив направлений перемещений до его цели.
	func createDirections(from current: Matrix, to solution: Matrix) -> [MatrixElement : [Direction]]
}

final class Transporter: _Transporter {
	
	func createDirections(from current: Matrix, to solution: Matrix) -> [MatrixElement : [Direction]] {
		return [:]
	}
	
	
}
