// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "AFExtensions",
	products: [
		.library(
			name: "CombineExtensions",
			targets: ["CombineExtensions"]
		),
		.library(
			name: "SwiftUIExtensions",
			targets: ["SwiftUIExtensions"]
		),
		.library(
			name: "UIKitExtensions",
			targets: ["UIKitExtensions"]
		),
	],
	dependencies: [],
	targets: [
		.target(
			name: "CombineExtensions",
			path: "CombineExtensions/Source"
		),
		.executableTarget(
			name: "CombineExtensionsTestground",
			path: "CombineExtensions/Testground"
		),
		.target(
			name: "SwiftUIExtensions",
			path: "SwiftUIExtensions/Source"
		),
		.target(
			name: "UIKitExtensions",
			path: "UIKitExtensions/Source"
		)
	]
)
