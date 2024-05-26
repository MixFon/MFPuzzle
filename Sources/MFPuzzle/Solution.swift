//
//  Solution.swift
//  
//
//  Created by Михаил Фокин on 26.05.2024.
//

import Foundation

/// Возможные решения головоломки
/// - snail: решение в виде спирали, закрученной по часовой стрелке
/// - classic: решение про котором номера идут слева направо, как при обычном писме
/// - boustrophedon: решение при котором числа идут слева направа, а на следующей в обратную сторону справа налево
public enum Solution: String, CaseIterable, CustomStringConvertible {
	case snail
	case classic
	case boustrophedon
	
	public var description: String {
		self.rawValue.capitalized
	}
}
