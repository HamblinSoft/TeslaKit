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
    dependencies: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "3.3.0"),
    ],
    targets: [
        .target(
            name: "TeslaKit",
            dependencies: [
                "ObjectMapper"
            ]
            path: "Source")
    ]//,swiftLanguageVersions: [.v3, .v4]
)
