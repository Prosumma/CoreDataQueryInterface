![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Swift-2.2-orange.svg)](http://swift.org)
![Platforms](https://img.shields.io/cocoapods/p/CoreDataQueryInterface.svg)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. CDQI is a bit like jQuery or LINQ, but for Core Data.

### Swift 3

This is a placeholder for the Swift 3 documentation for CDQI v5. CDQI v5 for Swift 3 is **usable right now** with some caveats:

- Only the _very latest_ versions of each Apple operating system are supported. This is because I used the new `entity()` method of `NSManagedObject`, which is not supported on earlier operating systems. Previous versions of CDQI used a workaround, and I will be porting this to CDQI v5 with conditional compilation in order to support iOS 9.0+, macOS 10.11+, tvOS 9.0+ and watchOS 2.0+.
- There is **absolutely no** documentation, and things have changed. The unit tests are your friends. Look at them. Documentation&mdash;both here and inline&mdash;is coming.
- Because all of the unit tests pass, it is highly likely that the API will remain stable, but small tweaks are possible, particularly when it comes to Swift 3's new access modifiers.
- The `cdqi` tool used to generate attribute classes has not been updated. This is coming, but for now you will have to write your own attribute classes. See the unit tests for examples. Attribute classes are now much simpler to write due to underlying changes in CDQI, so this isn't much of a burden.
- Core Data inheritance is still not supported. I currently have no plans to do so, but there are workarounds.

As always, if you find a bug or have a feature request, open an issue.
