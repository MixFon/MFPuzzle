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
			// Arrange
			let n = size * size - 1
			let summ = n * (n + 1) / 2
			
			// Act
			let matrixOne = matrixWorker.createMatrixRandom(size: size)
			let matrixTwo = matrixWorker.createMatrixRandom(size: size)
			
			let setOne = Set<MatrixElement>(matrixOne.flatMap({$0}))
			let setTwo = Set<MatrixElement>(matrixTwo.flatMap({$0}))
			
			let summOne = setOne.reduce(0, {Int($0) + Int($1)})
			let summTwo = setTwo.reduce(0, {Int($0) + Int($1)})
			
			// Assert
			XCTAssertEqual(setOne.count, size * size)
			XCTAssertEqual(setTwo.count, size * size)
			XCTAssertEqual(summOne, summ)
			XCTAssertEqual(summTwo, summ)
			XCTAssertNotEqual(matrixOne, matrixTwo)
		}
	}
	
	func testIsSquereMatrix() {
		// Arrange
		let matrixWorker = MatrixWorker()
		let matrix1: [[MatrixElement]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		let matrix2: [[MatrixElement]] = [[1, 2, 3], [4, 5], [7, 8, 9]]
		let matrix3: [[MatrixElement]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]
		let matrix4: [[MatrixElement]] = [[]]
		let matrix5: [[MatrixElement]] = []
		
		// Act
		let result1 = matrixWorker.isSquereMatrix(matrix: matrix1)
		let result2 = matrixWorker.isSquereMatrix(matrix: matrix2)
		let result3 = matrixWorker.isSquereMatrix(matrix: matrix3)
		let result4 = matrixWorker.isSquereMatrix(matrix: matrix4)
		let result5 = matrixWorker.isSquereMatrix(matrix: matrix5)
		
		// Assert
		XCTAssertEqual(result1, true)
		XCTAssertEqual(result2, false)
		XCTAssertEqual(result3, false)
		XCTAssertEqual(result4, false)
		XCTAssertEqual(result5, false)
	}
	
	func testChangesParityInvariant() {
		// Arrange
		let matrixWorker = MatrixWorker()
		var matrix1: [[MatrixElement]] = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		var matrix2: [[MatrixElement]] = [[0, 2, 3], [4, 5, 6], [7, 8, 9]]
		var matrix3: [[MatrixElement]] = [[1, 2, 3], [0, 5, 6], [7, 8, 9]]
		var matrix4: [[MatrixElement]] = []
		var matrix5: [[MatrixElement]] = [[1, 2, 3], [0, 5, 6]]
		var matrix6: [[MatrixElement]] = [[1, 2, 3], [0, 5, 6], [7, 8, 9], [7, 8, 9]]
		
		// Act
		matrixWorker.changesParityInvariant(matrix: &matrix1)
		matrixWorker.changesParityInvariant(matrix: &matrix2)
		matrixWorker.changesParityInvariant(matrix: &matrix3)
		matrixWorker.changesParityInvariant(matrix: &matrix4)
		matrixWorker.changesParityInvariant(matrix: &matrix5)
		matrixWorker.changesParityInvariant(matrix: &matrix6)
		
		// Assert
		XCTAssertEqual(matrix1[0][0], 4)
		XCTAssertEqual(matrix1[1][0], 1)
		
		XCTAssertEqual(matrix2[1][1], 8)
		XCTAssertEqual(matrix2[2][1], 5)
		
		XCTAssertEqual(matrix3[1][1], 8)
		XCTAssertEqual(matrix3[2][1], 5)
		
		XCTAssertEqual(matrix4.isEmpty, true)
		
		XCTAssertEqual(matrix5[0][0], 1)
		XCTAssertEqual(matrix5[1][0], 0)
		
		XCTAssertEqual(matrix5[0][0], 1)
		XCTAssertEqual(matrix5[1][0], 0)
	}

}
