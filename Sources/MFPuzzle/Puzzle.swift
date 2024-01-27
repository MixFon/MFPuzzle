//
//  Pazzle.swift
//  N_Puzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import MFStructs
import Foundation

final class Puzzle {
	typealias Matrix = [[UInt8]]
    
	private var heuristic: Heuristic = .manhattan
    
    func run() {
        do {
            let terminalWorker = try TerminalWorker()
			let text = try terminalWorker.textBoard
            let matrix = try creationMatrix(text: text)
			if !checkUniqueElementsMatrix(matrix: matrix) { return }
			let matrixTarget = createMatrixTarget(size: matrix.count)
			if !checkSolution(matrix: matrix, matrixTarget: matrixTarget) { return }
			let board = Board(matrix: matrix)
			let boardTarget = Board(matrix: matrixTarget)
            try searchSolutionWithHeap(board: board, boardTarget: boardTarget)
        } catch let exception as Exception {
            systemError(massage: exception.massage)
        } catch {
            systemError(massage: "Unknown error.")
        }
    }
    
    /// Поиск решения, используя алгоритм A*
	@discardableResult
	func searchSolutionWithHeap(board: Board, boardTarget: Board) throws -> Board {
		let heap = MFHeap<Board>(priorityFunction: {$0.f < $1.f})
        board.setF(heuristic: self.heuristic.getHeuristic(coordinats: board.coordinats, coordinatsTarget: boardTarget.coordinats))
		heap.insert(board)
		var visited = Set<Int>()
		while let board = heap.extract() {
            if board == boardTarget {
                return board
            }
			let children = board.getChildrens()
            for board in children {
				if !visited.contains(board.matrix.hashValue) {
					let heuristic = self.heuristic.getHeuristic(coordinats: board.coordinats, coordinatsTarget: boardTarget.coordinats)
					board.setF(heuristic: heuristic)
					heap.insert(board)
				}
            }
            visited.insert(board.matrix.hashValue)
        }
		throw Exception(massage: "The Pazzle has no solution.")
    }
    
    /// Проверяет существет ли решение головоломки.
	func checkSolution(matrix: Matrix, matrixTarget: Matrix) -> Bool {
		let summa = getSummInversion(matrix: matrix)
		let summaTarget = getSummInversion(matrix: matrixTarget)
        let coordinateZeroBoard = getCoordinateXZero(matrix: matrix)! + summa + 1
        let coordinateZeroBoardTarget = getCoordinateXZero(matrix: matrixTarget)! + summaTarget + 1
        if matrix.count % 2 == 0 {
			return coordinateZeroBoard % 2 == coordinateZeroBoardTarget % 2
        } else {
			return summa % 2 == summaTarget % 2
        }
    }
	
	func getCoordinateXZero(matrix: Matrix) -> Int? {
		for row in matrix {
			for (j, element) in row.enumerated() {
				if element == 0 { return j }
			}
		}
		return nil
	}
	
	/// Возвращает количество инвариантов.
	func getSummInversion(matrix: Matrix) -> Int {
		var summ = 0
		var arry = [UInt8]()
		for row in matrix {
			for elem in row {
				if elem != 0 {
					arry.append(elem)
				}
			}
		}
		for (i, elem) in arry.enumerated() {
			for elemIter in arry[(i + 1)...] {
				if elem > elemIter {
					summ += 1
				}
			}
		}
		return summ
	}
	
	/// Создание матрицы результата
	func createMatrixTarget(size: Int) -> Matrix {
		var matrix = Array(repeating: Array(repeating: UInt8(0), count: size), count: size)
		fillBoardInSpiral(matrix: &matrix)
		return matrix
	}
	
	/// Заполняет доску по спирали.
	func fillBoardInSpiral(matrix: inout Matrix) {
		var filler: UInt8 = 1
		let size = matrix.count
		for i in 0..<size {
		matrix[0][i] = filler
			filler += 1
		}
		for i in 1..<size {
			matrix[i][size - 1] = filler
			filler += 1
		}
		var y = size - 2
		while y >= 0 {
			matrix[size - 1][y] = filler
			filler += 1
			y -= 1
		}
		var x = size - 2
		while x > 0 {
			matrix[x][0] = filler
			filler += 1
			x -= 1
		}
		fillSquare(filler: filler, matrix: &matrix)
	}
	
	/// Заполняет внутренюю часть квадрата.
	private func fillSquare(filler: UInt8, matrix: inout Matrix) {
		let size = matrix.count
		var filler = filler
		let end = size * size
		var x = 1
		var y = 1
		while filler < end {
			while matrix[x][y + 1] == 0 {
				matrix[x][y] = filler
				y += 1
				filler += 1
			}
			while matrix[x + 1][y] == 0 {
				matrix[x][y] = filler
				x += 1
				filler += 1
			}
			while matrix[x - 1][y] == 0 {
				matrix[x][y] = filler
				x -= 1
				filler += 1
			}
			while matrix[x][y - 1] == 0 {
				matrix[x][y] = filler
				y -= 1
				filler += 1
			}
		}
	}
	
	/// Производит проверку доски. Элементы должны быть уникальны.
	func checkUniqueElementsMatrix(matrix: [[UInt8]]) -> Bool {
		let arr = matrix.flatMap({$0})
		let elementsMatrix = Set<UInt8>(arr)
		return elementsMatrix.count != arr.count
	}
    
    private func printPath(board: Board) {
        var next: Board? = board
        while next != nil {
            next?.print()
            next = next?.parent
        }
    }
    
    /// Создает начальное состояние пазлов на основе строки данных.
    func creationMatrix(text: String) throws -> [[UInt8]] {
        let lines = text.split() { $0 == "\n" }.map{ String($0) }
        var size: Int?
        var matrix = [[UInt8]]()
        for line in lines {
            let data = getData(line: line)
            let words = try getWords(data: data)
            switch words.count {
            case 0:
                break
            case 1 where size == nil:
                size = Int(words[0])
            case 2... where words.count == size:
                matrix.append(words)
            default:
                throw Exception(massage: "Invalid data: \(line)")
            }
        }
        guard let sizeBoard = size else {
            throw Exception(massage: "Invalid data.")
        }
        if matrix.count != sizeBoard || matrix.count <= 2 {
            throw Exception(massage: "The board size is set incorrectly.")
        }
		return matrix
    }
    
    /// Создает на основе строки массив целочисленных элементов.
    private func getWords(data: String) throws -> [UInt8] {
        let words = data.split() { $0 == " "}.map { String($0) }
        if words.isEmpty {
            return [UInt8]()
        }
        var numbers = [UInt8]()
        for word in words {
            guard let number = UInt8(word) else {
                throw Exception(massage: "Invalid data: \(word)")
            }
            numbers.append(number)
        }
        return numbers
    }
    
    /// Возвращает строку без комментария.
    private func getData(line: String) -> String {
        var data = String()
        for char in line {
            if char == "#" {
                return data
            } else {
                data.append(char)
            }
        }
        return data
    }
    
    /// Вывод сообщения об ошибке в поток ошибок
    private func systemError(massage: String) {
        fputs(massage + "\n", stderr)
        exit(-1)
    }

}
