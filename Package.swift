import PackageDescription

let package = Package(
	name: "PerfectQNSDK",
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Crypto.git", majorVersion: 3)
	],
	exclude:[])
