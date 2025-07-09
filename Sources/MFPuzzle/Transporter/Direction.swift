//
//  Direction.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 09.05.2025.
//

import Foundation

/// Описывает возможные пути перемещения в 3-х мерном массве
public indirect enum Direction: Hashable, Sendable {
	/// Направдление на уровень выше текущего
	case up(Direction?)
	/// Направлнение на уровень ниже текущего
	case down(Direction?)
	/// Направлнение влево (запад)
	case west
	/// Направлнение вправо (восток)
	case east
	/// Направлнение ввех (север)
	case north
	/// Направлнение вниз (юг)
	case south
	/// Направление прокускается
	case pause
}
