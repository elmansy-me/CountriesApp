// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CountryDataService",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CountryDataService",
            targets: ["CountryDataService"]
        ),
    ],
    dependencies: [
        .package(name: "NetworkLayer", path: "../NetworkLayer"),
        .package(name: "DatabaseKit", path: "../DatabaseKit"),
        .package(url: "https://github.com/ashleymills/Reachability.swift", from: "5.2.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CountryDataService",
            dependencies: [
                "NetworkLayer",
                "DatabaseKit",
                .product(name: "Reachability", package: "reachability.swift")
            ]
        ),
        .testTarget(
            name: "CountryDataServiceTests",
            dependencies: ["CountryDataService"]
        ),
    ]
)
