//
//  TerminalWorker.swift
//
//
//  Created by Михаил Фокин on 23.01.2024.
//

import Foundation

/// Воркер предназначенный для работы с консольным ссодом на MacOS.
@available(macOS 11, *)
final class TerminalWorker {
	private var fileName: String?
	var heuristic: Heuristic = .manhattan
	
	/// Доска с числами в виде сроки. Считывается или из файла или из потока ввода
	var textBoard: String {
		get throws {
			let textBoard: String
			if let fileName = self.fileName {
				textBoard = try readFile(fileName: fileName)
			} else {
				textBoard = readOutput()
			}
			return textBoard
		}
	}
	
	init() throws {
		try workingArguments()
	}
	
	/// Обработка аргументов.
	private func workingArguments() throws {
		for argument in CommandLine.arguments[1...] {
			guard let firstCaracter = argument.first else { continue }
			if firstCaracter == "-" {
				switch argument {
				case "-m":
					self.heuristic = .manhattan
				case "-ch":
					self.heuristic = .chebyshev
				case "-eu":
					self.heuristic = .euclidean
				case "-s":
					self.heuristic = .simple
				default:
					throw Exception(massage: "Invalid agument: \(argument)")
				}
			} else {
				if self.fileName == nil {
					self.fileName = argument
				} else {
					throw Exception(massage: "Invalid agument: \(argument)")
				}
			}
		}
	}
	
	/// Чтение файла из файла.
	private func readFile(fileName: String) throws -> String {
		let manager = FileManager.default
		let currentDirURL = URL(fileURLWithPath: manager.currentDirectoryPath)
		let fileURL = currentDirURL.appendingPathComponent(fileName)
		return try String(contentsOf: fileURL)
	}
	
	/// Чтение файла из стандарного потока ввода.
	private func readOutput() -> String {
		var text = String()
		while let line = readLine() {
			text.append("\(line)\n")
		}
		return text
	}
}
