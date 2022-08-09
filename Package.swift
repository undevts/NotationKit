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
        .library(
            name: "AnyNotationKit",
            targets: ["AnyNotationKit"]),
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
                "AnyNotationKit",
            ]),
        .target(
            name: "JSONCore",
            dependencies: [
                .product(name: "CoreCxx", package: "CoreSwift"),
            ],
            exclude: [
                "CMakeLists.txt",
            ]),
        .target(
            name: "JSONSimd",
            dependencies: [
                "JSONCore",
            ],
            exclude: [
                "LICENSE",
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
                "JSON+KeyedDecoded.swift.gyb",
                "JSONStream+Write.swift.gyb",
            ]),
        .target(
            name: "AnyNotationKit",
            dependencies: [
                "NotationCore",
            ]),
        .target(
            name: "AnyNotationKitTestsSupport",
            dependencies: [
                "AnyNotationKit",
            ]),
        .testTarget(
            name: "JSONKitTests",
            dependencies: ["JSONKit"],
            exclude: [
                "JSONStreamTests+Write.swift.gyb",
            ]),
        .testTarget(
            name: "AnyNotationKitTests",
            dependencies: [
                "AnyNotationKit",
                "AnyNotationKitTestsSupport",
            ]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx17
)
