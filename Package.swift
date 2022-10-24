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
    .package(url: "https://github.com/prosumma/PredicateQI", exact: "0.3.1")
  ],
  targets: [
    .target(
      name: "CoreDataQueryInterface",
      dependencies: ["PredicateQI"],
      exclude: [
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
