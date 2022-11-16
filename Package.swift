// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VHLoading",
    platforms: [.iOS("12")],
    products: [
        .library(
            name: "VHLoading",
            targets: ["VHLoading"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "VHLoading",
            dependencies: [],
            path: "VHLoading",
            exclude: ["SupportingFiles"]
        )
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
