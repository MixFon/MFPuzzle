//
//  GridPoint.swift
//  
//
//  Created by Михаил Фокин on 31.05.2024.
//

import Foundation

public struct GridPoint: Equatable {
	public let x: Int8
	public let y: Int8
}

extension GridPoint {
	
	public static func - (lhs: GridPoint, rhs: GridPoint) -> GridPoint {
		return GridPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}
	
	public static func + (lhs: GridPoint, rhs: GridPoint) -> GridPoint {
		return GridPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}
}
