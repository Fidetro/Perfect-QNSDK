import PackageDescription

let package = Package(
	name: "Perfect-QNSDK",
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Crypto", majorVersion: 3)
	],
	exclude:[])
