//
//  Box.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 09.05.2025.
//

import Foundation

final class Box {
	/// Номер коробки
	let number: Int
	/// Полный путь до цели. Содержит переходы на другие уровни
	var path: [Direction] = []
	/// Короткий путь. Содержить только движения вдоль среднего уровня
	var shortestPath: [Direction]
	
	init(number: Int, shortestPath: [Direction]) {
		self.number = number
		self.shortestPath = shortestPath
	}
	
	/// Возвращает доступные координаты для следующего хода
	var availableDirections: [Direction] {
		// Создаем элементы только определенного направления, не перебирам все элементы.
		Array(Set(self.shortestPath))
	}
	
	func deleteDirectionForShortPath(_ direction: Direction) {
		if let index = self.shortestPath.firstIndex(of: direction) {
			self.shortestPath.remove(at: index)
		}
	}
}
