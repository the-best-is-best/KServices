// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "KServices",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "KServices",
            targets: ["KServices"]),
    ],
    targets: [
        .target(
            name: "KServices",
            dependencies: []),
        .testTarget(
            name: "KServicesTests",
            dependencies: ["KServices",]
          
        ),
    ]
)
