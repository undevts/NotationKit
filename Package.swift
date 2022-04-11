// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "NotationKit",
    products: [
        .library(
            name: "NotationKit",
            targets: ["NotationKit"]),
        .library(
            name: "JSONKit",
            targets: ["JSONKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/undevts/CoreSwift.git", from: "0.1.1"),
    ],
    targets: [
        .target(
            name: "NotationCore",
            dependencies: []),
        .target(
            name: "NotationKit",
            dependencies: [
                "JSONKit",
            ]),
        .target(
            name: "JSONCore",
            dependencies: [
                .product(name: "CoreCxx", package: "CoreSwift"),
            ]),
        .target(
            name: "JSONSimd",
            dependencies: [
                "JSONCore",
            ]),
        .target(
            name: "JSONKit",
            dependencies: [
                "NotationCore",
                "JSONCore",
                "JSONSimd",
            ],
            exclude: [
                "JSON+Decoded.swift.gyb",
                "JSONStream+Write.swift.gyb",
            ]),
        .testTarget(
            name: "JSONKitTests",
            dependencies: ["JSONKit"]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx17
)
