// swift-tools-version: 6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

fileprivate let packageName = "MFPuzzle"
fileprivate let testTarget = packageName + "Tests"
fileprivate let swiftSettings = packageName + "_SPM"

let package = Package(
	name: packageName,
	defaultLocalization: "ru",
	platforms: [
		.iOS(.v13),
		.macOS(.v11)
	],
	products: [
		.library(
			name: packageName,
			targets: [packageName]),
	],
	dependencies: [
		.package(url: "git@github.com:MixFon/MFStructs.git", from: "0.0.1")
	],
	targets: [
		.target(
			name: packageName,
			dependencies: [
				.product(name: "MFStructs", package: "mfstructs"),
			],
			//resources: [.process("Resources")],
			swiftSettings: [.define(swiftSettings)]),
		.testTarget(
			name: testTarget,
			dependencies: [.init(stringLiteral: packageName)]),
	]
)

