// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EasyHTML",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "EasyHTML", targets: ["EasyHTML"]),
    ],
    targets: [
        .target(name: "EasyHTML", path: "Sources/EasyHTML"),
        .testTarget(name: "EasyHTMLTests", dependencies: ["EasyHTML"], path: "Tests/EasyHTMLTests"),
    ]
)
