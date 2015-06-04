![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. If you've worked with LINQ in the C# world, you can think of CDQI as "LINQ for Core Data".

## Advantages

The best way to understand the advantages of CDQI is to see an example.

```swift
for employee in managedObjectContext.from(Employee).filter({$0.salary > 70000 && $0.department == "Engineering"}).order(descending: {$0.lastName}, {$0.firstName}) {
  debugPrintln("\(employee.lastName), \(employee.firstName)")
}
```

Now compare this to vanilla Core Data:

```swift
let fetchRequest = NSFetchRequest(entityName: "Employee")
fetchRequest.predicate = NSPredicate(format: "salary > %ld && department == %@", 70000, "Engineering")
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: false), NSSortDescriptor(key: "firstName", ascending: false)]
for employee in managedObjectContext.executeFetchRequest(fetchRequest, error: nil)! as! [Employee] {
  debugPrintln("\(employee.lastName), \(employee.firstName)")
}
```

Which would you rather write?

## Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface)
- [x] Large number of overloads
- [x] Type-safety
- [x] Three main query types: Entity, ManagedObjectID, and Dictionary (called "Expression" in CDQI)
- [x] Grouping, sorting, counts, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse

## Requirements

- iOS 8.1+ / Mac OS X 10.9+
- Xcode 6.3+

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate CoreDataQueryInterface into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'CoreDataQueryInterface', '~> 1.2'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

Carthage is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate CoreDataQueryInterface into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "Prosumma/CoreDataQueryInterface" >= 1.2
```
