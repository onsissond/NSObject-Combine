// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "NSObject-Combine",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "NSObject-Combine", targets: ["NSObject-Combine"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NSObject-Combine",
            dependencies: [],
            path: ".",
            sources: [
                "NSObject+Combine.swift",
                "HasCancellable.swift",
                "CombineDisposeBag.swift"
            ]
        ),
    ]
)
