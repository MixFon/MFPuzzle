//
//  File.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 05.04.2025.
//

import Foundation

public extension Grid3DPoint {
	
	/// Возвращает точку по направдлению сприбавляя с себе 
	func getByAdding(from direction: Direction) -> Grid3DPoint {
		return switch direction {
		case .up:
			self + Grid3DPoint(x: 0, y: 0, z: -1)
		case .down:
			self + Grid3DPoint(x: 0, y: 0, z: 1)
		case .north:
			self + Grid3DPoint(x: -1, y: 0, z: 0)
		case .south:
			self + Grid3DPoint(x: 1, y: 0, z: 0)
		case .west:
			self + Grid3DPoint(x: 0, y: -1, z: 0)
		case .east:
			self + Grid3DPoint(x: 0, y: 1, z: 0)
		case .pause:
			self + Grid3DPoint(x: 0, y: 0, z: 0)
		}
	}
}
