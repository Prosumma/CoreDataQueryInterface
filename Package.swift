// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CoreDataQueryInterface",
  platforms: [.macOS(.v12)],
  products: [
    .library(
      name: "CoreDataQueryInterface",
      targets: ["CoreDataQueryInterface"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/prosumma/PredicateQI", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "CoreDataQueryInterface",
      dependencies: ["PredicateQI"],
      exclude: [
        "QueryBuilder+Group.swift.gyb",
        "QueryBuilder+Order.swift.gyb",
        "QueryBuilder+Select.swift.gyb"
      ]
    ),
    .testTarget(
      name: "CoreDataQueryInterfaceTests",
      dependencies: ["CoreDataQueryInterface"],
      resources: [.copy("Developers.xcdatamodeld")]
    ),
  ]
)
