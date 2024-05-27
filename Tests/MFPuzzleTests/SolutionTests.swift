//
//  SolutionTests.swift
//  
//
//  Created by Михаил Фокин on 27.05.2024.
//

import XCTest
@testable import MFPuzzle

final class SolutionTests: XCTestCase {

	func testSolutionDescription() {
		// Arrange
		let solutionSnail = Solution.snail
		let solutionClassic = Solution.classic
		let solutionBoustrophedon = Solution.boustrophedon
	
		// Act
		let solutionSnailDescription = solutionSnail.description
		let solutionClassicDescription = solutionClassic.description
		let solutionBoustrophedonDescription = solutionBoustrophedon.description
		
		// Assert
		XCTAssertEqual(solutionSnailDescription, "Snail")
		XCTAssertEqual(solutionClassicDescription, "Classic")
		XCTAssertEqual(solutionBoustrophedonDescription, "Boustrophedon")
	}

}
