// swift-tools-version:5
//
//  Package.swift
//

import PackageDescription

let package = Package(
    name: "TeslaKit",
    products: [
        .library(
            name: "TeslaKit",
            targets: ["TeslaKit"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TeslaKit",
            dependencies: []
            path: "Source")
    ],
    swiftLanguageVersions: [.v5]
)
