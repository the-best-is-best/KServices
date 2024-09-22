// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "KServices",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14), // Specify the minimum macOS version

    ],
    products: [
        .library(
            name: "KServices",
            targets: ["KServices"]),
    ],
    dependencies: [
        // Add any dependencies here, if needed
    ],
    targets: [
        .target(
            name: "KServices",
            dependencies: [],
            path: "Sources/KServices"), // Specify the source path
        .testTarget(
            name: "KServicesTests",
            dependencies: ["KServices"],
            path: "Tests/KServicesTests"), // Specify the test path
    ]
)
