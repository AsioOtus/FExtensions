// swift-tools-version:5.5

import PackageDescription

let package = Package(
	name: "AFExtensions",
  platforms: [.macOS(.v12), .iOS(.v13)],
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
	targets: [
		.target(
			name: "CombineExtensions",
			path: "CombineExtensions/Source"
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
