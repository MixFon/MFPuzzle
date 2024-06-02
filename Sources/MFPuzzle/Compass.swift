//
//  Compass.swift
//
//
//  Created by Михаил Фокин on 31.05.2024.
//

import Foundation

/// Перечисление, которое определяет в какое направление будет перемещен ноль.
public enum Compass {
	case west
	case east
	case north
	case south
	
	public var opposite: Compass {
		switch self {
		case .west:
			return .east
		case .east:
			return .west
		case .north:
			return .south
		case .south:
			return .north
		}
	}
}
