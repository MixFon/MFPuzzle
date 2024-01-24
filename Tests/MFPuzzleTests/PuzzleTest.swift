//
//  PuzzleTest.swift
//  
//
//  Created by Михаил Фокин on 24.01.2024.
//

import XCTest
@testable import MFPuzzle

final class PuzzleTest: XCTestCase {
	
	private var puzzle: Puzzle?

    override func setUpWithError() throws {
		self.puzzle = Puzzle()
    }

    override func tearDownWithError() throws {
		self.puzzle = nil
    }

	func testCreateMatrix3x3() throws {
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		6 2 1
		4 0 5
		7 3 8
		"""
		let matrix = try self.puzzle?.creationMatrix(text: matrix3x3)
		XCTAssertEqual(matrix?.count, 3)
		XCTAssertEqual(matrix?[0][0], 6)
		XCTAssertEqual(matrix?[0][1], 2)
		XCTAssertEqual(matrix?[0][2], 1)
		XCTAssertEqual(matrix?[1][0], 4)
		XCTAssertEqual(matrix?[1][1], 0)
		XCTAssertEqual(matrix?[1][2], 5)
		XCTAssertEqual(matrix?[2][0], 7)
		XCTAssertEqual(matrix?[2][1], 3)
		XCTAssertEqual(matrix?[2][2], 8)
		
    }
	
	func testCreateMatrix4x4() throws {
		let matrix4x4 =
		"""
		# This puzzle is solvable
		4
		8 15  6  5
		2  9  3 10
		14 11  4  7
		12  1  0 13
		"""
		let uint8Matrix4x4: [[UInt8]] =
		[[8, 15,  6,  5],
		[2,   9,  3, 10],
		[14, 11,  4,  7],
		[12,  1,  0, 13]]
		let newMatrix4x4 = try self.puzzle?.creationMatrix(text: matrix4x4)
		XCTAssertEqual(uint8Matrix4x4, newMatrix4x4)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
