// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NotationKit",
    products: [
        .library(
            name: "NotationKit",
            targets: ["NotationKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/undevts/CoreSwift.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "NotationKit",
            dependencies: [
                "JSONKit"
            ]),
        .target(
            name: "JSONKit",
            dependencies: []),
        .testTarget(
            name: "NotationKitTests",
            dependencies: ["NotationKit"]),
    ]
)
