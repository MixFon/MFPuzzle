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

	
	// MARK: Test create matrix.
	func testCreateMatrix3x3() throws {
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		6 2 1
		4 0 5
		7 3 8
		"""
		let uint8Matrix3x3: [[UInt8]] =
		[[6, 2, 1],
		[4, 0, 5],
		[7, 3, 8]]
		let newMatrix3x3 = try self.puzzle?.creationMatrix(text: matrix3x3)
		XCTAssertEqual(uint8Matrix3x3, newMatrix3x3)
		
    }
	
	func testErrorNumberCreateMatrix3x3() throws {
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		a6 2 1
		4 0 5
		7 3 8
		"""
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: matrix3x3)) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "Invalid data: a6"))
		}
	}
	
	func testErrorSizeCreateMatrix3x3() throws {
		let matrix3x3 =
		"""
		# This puzzle is solvable
		3
		6 2 1
		4 0 5
		"""
		XCTAssertThrowsError(try self.puzzle?.creationMatrix(text: matrix3x3)) { error in
			XCTAssertEqual(error as! Exception, Exception(massage: "The board size is set incorrectly."))
		}
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
		[[8, 15, 6, 5],
		[2, 9, 3, 10],
		[14, 11, 4, 7],
		[12, 1, 0, 13]]
		let newMatrix4x4 = try self.puzzle?.creationMatrix(text: matrix4x4)
		XCTAssertEqual(uint8Matrix4x4, newMatrix4x4)
	}
	
	func testCreateMatrix5x5() throws {
		let matrix4x4 =
		"""
		# This puzzle is solvable
		5
		22 16 19 18 12
		 1  3  4 14 15
		 6 23  0 11 24
		 2 13 17 20 21
		 7 10  5  8  9
		"""
		let uint8Matrix5x5: [[UInt8]] = [
			[22, 16, 19, 18, 12],
			[1, 3, 4, 14, 15],
			[6, 23, 0, 11, 24],
			[2, 13, 17, 20, 21],
			[7, 10, 5, 8, 9]
		]
		let newMatrix5x5 = try self.puzzle?.creationMatrix(text: matrix4x4)
		XCTAssertEqual(uint8Matrix5x5, newMatrix5x5)
	}
	
	// MARK: Test check solution.
	
	func testCheckSolution() throws {
		let matrix3x3: [[UInt8]] =
		[[6, 3, 4],
		 [5, 1, 2],
		 [7, 8, 0]]
		XCTAssertTrue(self.puzzle?.checkSolution(matrix: matrix3x3) == true)
	}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
