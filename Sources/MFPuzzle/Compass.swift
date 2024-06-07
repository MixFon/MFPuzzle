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
	case needle
	
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
		case .needle:
			return .needle
		}
	}
	
	public static func calculateCompass(endPoint: GridPoint?, startPoint: GridPoint?) -> Compass? {
		guard let endPoint, let startPoint else { return nil }
		let diff = endPoint - startPoint
		switch diff {
		case GridPoint(x: 0, y: 1):
			return .east
		case GridPoint(x: 0, y: -1):
			return .west
		case GridPoint(x: 1, y: 0):
			return .north
		case GridPoint(x: -1, y: 0):
			return .south
		default:
			return nil
		}
	}
	
}
