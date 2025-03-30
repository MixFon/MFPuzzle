//
//  Transporter.swift
//  MFPuzzle
//
//  Created by Михаил Фокин on 29.03.2025.
//

import XCTest
@testable import MFPuzzle

final class TransporterTests: XCTestCase {

    override func setUpWithError() throws {
		
    }

    override func tearDownWithError() throws {
		
    }

	func testCreateShortestPath() {
		// Arrange
		let matrix: Matrix =
		[[1, 2, 3],
		 [6, 5, 4],
		 [7, 8, 0]]
		let solution: Matrix =
		[[2, 3, 4],
		 [1, 6, 8],
		 [7, 5, 0]]
		let transporter = TransporterTests()
		
		// Act
		let shortestPath = transporter.cre
		
		// Assert
		<#statements#>
	}
}
