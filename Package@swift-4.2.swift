// swift-tools-version:4.2
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
    targets: [
        .target(
            name: "TeslaKit",
            path: "Source")
    ],
    swiftLanguageVersions: [.v3, .v4]
)
