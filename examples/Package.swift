// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tensorflow-handbook-swift",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "..", from: "0.4.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "s4tf",
            dependencies: ["MNIST"]),
        .testTarget(
            name: "s4tfTests",
            dependencies: ["s4tf"]),
    ]
)
