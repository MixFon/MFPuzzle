//
//  Grid3DPoint.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

import Foundation

public struct Grid3DPoint: Equatable {
	public let x: Int8
	public let y: Int8
	public let z: Int8
	
	public init(x: Int8, y: Int8, z: Int8) {
		self.x = x
		self.y = y
		self.z = z
	}
}

extension Grid3DPoint {
	
	public static func - (lhs: Grid3DPoint, rhs: Grid3DPoint) -> Grid3DPoint {
		return Grid3DPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
	}
	
	public static func + (lhs: Grid3DPoint, rhs: Grid3DPoint) -> Grid3DPoint {
		return Grid3DPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
	}
}
