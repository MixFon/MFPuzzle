//
//  MatrixWorker.swift
//  
//
//  Created by Михаил Фокин on 24.02.2024.
//

import XCTest
@testable import MFPuzzle

final class MatrixWorkerTests: XCTestCase {

    private var worker: MatrixWorker?

    override func setUpWithError() throws {
        self.worker = MatrixWorker()
    }

    override func tearDownWithError() throws {
        self.worker = nil
    }
    
    // MARK: Test create matrix.

    func testCreateMatrix3x3() throws {
        // Arrange
        let matrix3x3 =
        """
        # This puzzle is solvable
        3
        6 2 1
        4 0 5
        7 3 8
        """
        let MatrixElementMatrix3x3: Matrix =
        [[6, 2, 1],
        [4, 0, 5],
        [7, 3, 8]]
        
        // Act
        let newMatrix3x3 = try self.worker?.creationMatrix(text: matrix3x3)
        
        // Assert
        XCTAssertEqual(MatrixElementMatrix3x3, newMatrix3x3)
    }
    
    func testErrorNumberCreateMatrix3x3() throws {
        // Arrange
        let matrix3x3 =
        """
        # This puzzle is solvable
        3
        a6 2 1
        4 0 5
        7 3 8
        """
        
        // Assert
        XCTAssertThrowsError(try self.worker?.creationMatrix(text: matrix3x3)) { error in
            XCTAssertEqual(error as! Exception, Exception(massage: "The number a6 does not match the size of MatrixElement."))
        }
    }
    
    func testErrorSizeCreateMatrix3x3() throws {
        // Arrange
        var matrix3x3 =
        """
        # This puzzle is solvable
        3
        6 2 1
        4 0 5
        """
        
        // Assert
        XCTAssertThrowsError(try self.worker?.creationMatrix(text: matrix3x3)) { error in
            XCTAssertEqual(error as! Exception, Exception(massage: "The board size is set incorrectly."))
        }
        matrix3x3 =
        """
        3
        3
        """
        XCTAssertThrowsError(try self.worker?.creationMatrix(text: matrix3x3)) { error in
            XCTAssertEqual(error as! Exception, Exception(massage: "Invalid data: 3"))
        }
        XCTAssertThrowsError(try self.worker?.creationMatrix(text: "")) { error in
            XCTAssertEqual(error as! Exception, Exception(massage: "Invalid data."))
        }
    }
    
    func testErrorMatrixElementCreateMatrix3x3() throws {
        // Arrange
        let matrix3x3 =
        """
        # This puzzle is solvable
        3
        6 2 1
        4 0 5
        7 3 512
        """
        
        // Assert
        XCTAssertThrowsError(try self.worker?.creationMatrix(text: matrix3x3)) { error in
            XCTAssertEqual(error as! Exception, Exception(massage: "The number 512 does not match the size of MatrixElement."))
        }
    }
    
    func testCreateMatrix4x4() throws {
        // Arrange
        let matrix4x4 =
        """
        # This puzzle is solvable
        4
         8 15  6  5
         2  9  3 10
        14 11  4  7
        12  1  0 13
        """
        let MatrixElementMatrix4x4: Matrix =
        [[8, 15, 6, 5],
        [ 2, 9, 3, 10],
        [14, 11, 4, 7],
        [12, 1, 0, 13]]
        
        // Act
        let newMatrix4x4 = try self.worker?.creationMatrix(text: matrix4x4)
        
        // Assert
        XCTAssertEqual(MatrixElementMatrix4x4, newMatrix4x4)
    }
    
    func testCreateMatrix5x5() throws {
        // Arrange
        let matrix5x5 =
        """
        # This puzzle is solvable
        5
        22 16 19 18 12
         1  3  4 14 15
         6 23  0 11 24
         2 13 17 20 21
         7 10  5  8  9
        """
        let MatrixElementMatrix5x5: Matrix = [
            [22, 16, 19, 18, 12],
            [ 1,  3,  4, 14, 15],
            [ 6, 23,  0, 11, 24],
            [ 2, 13, 17, 20, 21],
            [ 7, 10,  5,  8,  9]
        ]
        
        // Act
        let newMatrix5x5 = try self.worker?.creationMatrix(text: matrix5x5)
        
        // Assert
        XCTAssertEqual(MatrixElementMatrix5x5, newMatrix5x5)
    }
    
    // MARK: Testing the filling of the board in a spiral.
    
    func testFillBoardSpiral3x3() {
        // Arrange
        let size = 3
        var matrix: Matrix = Array(repeating: Array(repeating: MatrixElement(), count: size), count: size)
        
        // Act
        self.worker?.fillBoardInSpiral(matrix: &matrix)
        
        // Assert
        let matrixSpiral3x3: Matrix =
        [[1, 2, 3],
         [8, 0, 4],
         [7, 6, 5]]
        XCTAssertEqual(matrix, matrixSpiral3x3)
    }
    
    func testFillBoardSpiral4x4() {
        // Arrange
        let size = 4
        var matrix: Matrix = Array(repeating: Array(repeating: MatrixElement(), count: size), count: size)
        
        // Act
        self.worker?.fillBoardInSpiral(matrix: &matrix)
        
        // Assert
        let matrixSpiral4x4: Matrix =
        [[ 1,  2,  3,  4],
         [12, 13, 14,  5],
         [11,  0, 15,  6],
         [10,  9,  8,  7]]
        
        // Assert
        XCTAssertEqual(matrix, matrixSpiral4x4)
    }
    
    func testFillBoardSpiral5x5() {
        // Arrange
        let size = 5
        var matrix: Matrix = Array(repeating: Array(repeating: MatrixElement(), count: size), count: size)
        
        // Act
        self.worker?.fillBoardInSpiral(matrix: &matrix)
        
        // Assert
        let matrixSpiral5x5: Matrix =
        [[ 1,  2,  3,  4,  5],
         [16, 17, 18, 19,  6],
         [15, 24,  0, 20,  7],
         [14, 23, 22, 21,  8],
         [13, 12, 11, 10,  9]]
        XCTAssertEqual(matrix, matrixSpiral5x5)
    }
    
    func testCreateMatrixSpiral3x3() {
        // Arrange
        let size = 3
        let matrix: Matrix?
        let matrixSpiral: Matrix =
        [[1, 2, 3],
         [8, 0, 4],
         [7, 6, 5]]
        
        // Act
        matrix = self.worker?.createMatrixSpiral(size: size)
        
        // Assert
        XCTAssertEqual(matrix, matrixSpiral)
    }
    
    func testCreateMatrixSpiral4x4() {
        // Arrange
        let size = 4
        let matrix: Matrix?
        let matrixSpiral: Matrix =
        [[ 1,  2,  3,  4],
         [12, 13, 14,  5],
         [11,  0, 15,  6],
         [10,  9,  8,  7]]
        
        // Act
        matrix = self.worker?.createMatrixSpiral(size: size)
        
        // Assert
        XCTAssertEqual(matrix, matrixSpiral)
    }
    
    func testCreateMatrixSpiral5x5() {
        // Arrange
        let size = 5
        let matrix: Matrix?
        let matrixSpiral: Matrix =
        [[ 1,  2,  3,  4,  5],
         [16, 17, 18, 19,  6],
         [15, 24,  0, 20,  7],
         [14, 23, 22, 21,  8],
         [13, 12, 11, 10,  9]]
        
        // Act
        matrix = self.worker?.createMatrixSpiral(size: size)
        
        // Assert
        XCTAssertEqual(matrix, matrixSpiral)
    }
    
	// MARK: Test create matrix random
	
	func testCreateMatrixRandom() {
		let matrixWorker = MatrixWorker()
		for size in 3...15 {
			// Act
			let matrixOne = matrixWorker.createMatrixRandom(size: size)
			let matrixTwo = matrixWorker.createMatrixRandom(size: size)
			
			let setOne = Set<MatrixElement>(matrixOne.flatMap({$0}))
			let setTwo = Set<MatrixElement>(matrixTwo.flatMap({$0}))
			
			// Assert
			XCTAssertEqual(setOne.count, size * size)
			XCTAssertEqual(setTwo.count, size * size)
			XCTAssertNotEqual(matrixOne, matrixTwo)
		}
	}

}
