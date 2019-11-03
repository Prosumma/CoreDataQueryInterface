// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CoreDataQueryInterface",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "CoreDataQueryInterface", targets: ["CoreDataQueryInterface"])
    ],
    targets: [
        .target(name: "CoreDataQueryInterface", path: "CoreDataQueryInterface"),
        // The tests have a resource dependency, and so cannot be run on the CLI at this time.
//        .testTarget(name: "CoreDataQueryInterfaceTests", dependencies: ["CoreDataQueryInterface"], path: "CoreDataQueryInterfaceTests")
    ]
)
