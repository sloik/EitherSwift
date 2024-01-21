// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EitherSwift",
    products: [
        .library(
            name: "EitherSwift",
            type: .dynamic,
            targets: ["EitherSwift"]
        ),
    ],

    dependencies: [
    ],

    targets: [
        .target(
            name: "EitherSwift",
            dependencies: [
            ]
        ),

        .testTarget(
            name: "EitherSwiftTests",
            dependencies: ["EitherSwift"]
        ),
    ]
)
