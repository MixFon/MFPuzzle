//
//  MatrixWorker.swift
//
//
//  Created by Михаил Фокин on 24.02.2024.
//

public typealias Matrix = [[MatrixElement]]
public typealias MatrixElement = UInt8

public protocol _MatrixWorker {
    func creationMatrix(text: String) throws -> Matrix
	/// Заполнение матрицы по спирали
    func fillBoardInSpiral(matrix: inout Matrix)
	/// Создание матрицы улиткой, по спирали
    func createMatrixSnail(size: Int) -> Matrix
	/// Создание матрицы случайных элементов размерности size
    func createMatrixRandom(size: Int) -> Matrix
	/// Создание классической игры. Каждый ряд начинается слева
    func createMatrixClassic(size: Int) -> Matrix
	/// Изменяет четность инварианта. Меняет метами 2-е соседние ячеки
	func changesParityInvariant(matrix: inout Matrix)
	/// Создание S-образной матрицы
    func createMatrixBoustrophedon(size: Int) -> Matrix
}

open class MatrixWorker: _MatrixWorker {
	
	private let checker: _Checker
    
	public init(checker: _Checker) {
		self.checker = checker
	}
    
    /// Создание матрицы результата
    public func createMatrixSnail(size: Int) -> Matrix {
        var matrix = Array(repeating: Array(repeating: MatrixElement(0), count: size), count: size)
        fillBoardInSpiral(matrix: &matrix)
        return matrix
    }
    
    /// Заполняет доску по спирали.
    public func fillBoardInSpiral(matrix: inout Matrix) {
        var filler: MatrixElement = 1
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
    private func fillSquare(filler: MatrixElement, matrix: inout Matrix) {
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
    
    /// Создает начальное состояние пазлов на основе строки данных.
    public func creationMatrix(text: String) throws -> Matrix {
        let lines = text.split() { $0 == "\n" }.map{ String($0) }
        var size: Int?
        var matrix = [[MatrixElement]]()
        for line in lines {
            let data = getData(line: line)
            guard let words = try getWords(data: data) else { continue }
            switch words.count {
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
	
	public func createMatrixRandom(size: Int) -> Matrix {
		var elements = (0..<(size * size)).map({ MatrixElement($0) })
		var matrix = Array(repeating: Array(repeating: MatrixElement(0), count: size), count: size)
		for i in 0..<size {
			for j in 0..<size {
				let randomIndex = Int.random(in: 0..<elements.count)
				let element = elements.remove(at: randomIndex)
				matrix[i][j] = element
			}
		}
		return matrix
	}
	
	public func changesParityInvariant(matrix: inout Matrix) {
		if matrix.count < 3 { return }
		if !self.checker.isSquereMatrix(matrix: matrix) { return }
		if matrix[0][0] != 0 && matrix[1][0] != 0 {
			(matrix[0][0], matrix[1][0]) = (matrix[1][0], matrix[0][0])
		} else {
			(matrix[1][1], matrix[2][1]) = (matrix[2][1], matrix[1][1])
		}
	}
	
	public func createMatrixClassic(size: Int) -> Matrix {
		var matrix = Array(repeating: Array(repeating: MatrixElement(0), count: size), count: size)
		var elem: MatrixElement = 1
		for i in 0..<size {
			for j in 0..<size {
				matrix[i][j] = elem
				elem += 1
			}
		}
		matrix[size - 1][size - 1] = 0
		return matrix
	}
	
	public func createMatrixBoustrophedon(size: Int) -> Matrix {
		var matrix = Array(repeating: Array(repeating: MatrixElement(0), count: size), count: size)
		var elem: MatrixElement = 1
		for i in 0..<size {
			for j in 0..<size {
				let k = i % 2 == 0 ? j : size - j - 1
				matrix[i][k] = elem
				elem += 1
			}
		}
		let k = size % 2 == 0 ? 0 : size - 1
		matrix[size - 1][k] = 0
		return matrix
	}
    
    /// Создает на основе строки массив целочисленных элементов.
    private func getWords(data: String) throws -> [MatrixElement]? {
        let words = data.split() { $0 == " "}.map { String($0) }
        if words.isEmpty {
            return nil
        }
        var numbers = [MatrixElement]()
        for word in words {
            guard let number = MatrixElement(word) else {
                throw Exception(massage: "The number \(word) does not match the size of MatrixElement.")
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
}
