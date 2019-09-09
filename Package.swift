// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Anchorage",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_11),
        .tvOS(.v9),
    ],
    products: [
        .library(
            name: "Anchorage",
            targets: ["Anchorage"]),
    ],
    targets: [
        .target(
            name: "Anchorage",
            dependencies: [],
            path: "Source"),
        .testTarget(
            name: "AnchorageTests",
            dependencies: ["Anchorage"],
            path: "AnchorageTests"),
    ]
)
