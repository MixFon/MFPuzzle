//
//  Pazzle.swift
//  N_Puzzle
//
//  Created by Михаил Фокин on 21.04.2021.
//

import MFStructs
import Foundation

final class Puzzle {
    
	private var heuristic: Heuristic = .manhattan
    
    func run() {
        do {
            let terminalWorker = try TerminalWorker()
			let text = try terminalWorker.textBoard
            let matrix = try creationMatrix(text: text)
			let board = try Board(matrix: matrix)
            try checkSolution(board: board)
            try searchSolutionWithHeap(board: board)
        } catch let exception as Exception {
            systemError(massage: exception.massage)
        } catch {
            systemError(massage: "Unknown error.")
        }
    }
    
    /// Поиск решения, используя алгоритм A*
	@discardableResult
	func searchSolutionWithHeap(board: Board) throws -> Board {
		let boardTarget = Board(size: board.size)
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
    func checkSolution(board: Board) throws {
		let summa = board.getSummInversion()
		let boardTarget = Board(size: board.size)
		let summaTarget = boardTarget.getSummInversion()
        let coordinateZeroBoard = Int(board.coordinats[0]!.x) + summa + 1
        let coordinateZeroBoardTarget = Int(boardTarget.coordinats[0]!.x) + summaTarget + 1
        if board.size % 2 == 0 {
            if coordinateZeroBoard % 2 != coordinateZeroBoardTarget % 2 {
                throw Exception(massage: "The Pazzle has no solution.")
            }
        } else {
            if summa % 2 != summaTarget % 2 {
                throw Exception(massage: "The Pazzle has no solution.")
            }
        }
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
                throw Exception(massage: "Invalid data: \(line) in \(lines)")
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
