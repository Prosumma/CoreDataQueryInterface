![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Swift-4.0-orange.svg)](http://swift.org)
![Platforms](https://img.shields.io/cocoapods/p/CoreDataQueryInterface.svg)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. CDQI is a bit like jQuery or LINQ, but for Core Data.

### Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety in filter comparisons.
- [x] Filtering, sorting, grouping, aggregate expressions, limits, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS 9+, macOS 10.11+, tvOS 9+, and watchOS 2+.
- [x] Swift 4

### Overview

In essence, CDQI is a tool that allows the creation (and execution) of fetch requests using a fluent syntax. In most cases, this can reduce many lines of code to a single (but still highly readable) line.

```swift
let swiftDevelopers = managedObjectContext.from(Developer.self).
                      filter(any(Developer.e.languages.name == "Swift"))
                      orderDesc(by: Developer.e.lastName)
                      .limit(5)
                      .all()
```

### Integration

#### Carthage

In your `Cartfile`, add the following line:

```ruby
github "prosumma/CoreDataQueryInterface" ~> 7.0
```

#### CocoaPods

Add the following to your `Podfile`. If it isn't already present, you will have to add `use_frameworks!` as well.

```ruby
pod 'CoreDataQueryInterface', '~> 7.0'
```

### Attribute Proxies

TODO: Talk about attribute proxies

### Starting a Query

A CDQI query is a chain of methods that build an `NSFetchRequest`. Almost all of the `NSFetchRequest`'s functionality is supported, such as choosing the result type, limiting the number of records fetched, filtering, sorting, etc.

A query is started by creating an instance of `Query`, which takes two generic type parameters. The first one tells us which `NSManagedObject` subclass is the target of our query. The second tells us what the result of the query should be: Either the same `NSManagedObject` subclass or an `NSDictionary`.

```swift
let developerQuery = Query<Developer, Developer>()
let developerDictionaryQuery = Query<Developer, NSDictionary>()
```

### Filtering

One of the most common operations performed in Core Data is filtering using `NSPredicate`. While it is possible to use `NSPredicate` directly with CDQI, this is not recommended. Instead, the generated attribute proxies should be used. These are accessed by the static `e` property that is added to every `NSManagedObject` subclass by the `cdqi` tool.

```swift
let query = Query<Developer, Developer>().filter(Developer.e.lastName == "Higley")
```

The expression `Developer.e.lastName == "Higley"` actually generates an `NSPredicate` rather than `Bool`. CDQI has clever overloads of the basic operators that work with the attribute proxies and a few other types that implement the `Inconstant` protocol. These overloads are designed to prevent collisions with the ordinary functions of the built-in operators.

#### Comparisons

CDQI has comparison operators, comparison methods, and comparison functions. Only the operators and methods will be covered here. See the source code for the functions.

The operators all perform _case-insensitive_ operations, which is the default for Core Data (and `NSPredicate`). The methods take an `options` parameter of type `NSComparisonPredicate.Options` that allows for case- and diacritic-insensitivity if desired.

Operator | Method | Examples and Description
:---: | --- | ---
`==` | `cdqiEqualTo` | `Person.e.firstName == "Robert"` or `Person.e.firstName.cdqiEqualTo("Robert")`.
`==` | `cdqiIn` | `Person.e.lastName == ["Smith", "Hayek"]` or `Person.e.lastName.cdqiIn("Smith", "Hayek")`.
`!=` | `cdqiNotEqualTo` | `Person.e.age != 47` or `Person.e.age.cdqiNotEqualTo(47)`.
`!=` | &nbsp; | `Person.e.age != [18, 44, 99]` or `!Person.e.age.cdqiIn(18, 44, 99)`.
`>` | `cdqiGreaterThan` | `Person.e.age > 42` or `Person.e.age.cdqiGreaterThan(42)`.
`>=` | `cdqiGreaterThanOrEqualTo` | `Person.e.age >= 18` or `Person.e.age.greaterThanOrEqualTo(18)`.
`<` | `cdqiLessThan` | `Soldier.e.rank < Rank.lieutenant` or `Soldier.e.rank.cdqiLessThan(Rank.lieutenant)`.
`<=` | `cdqiLessThanOrEqualTo` | `Soldier.e.rank <= Rank.colonel` or `Soldier.e.rank.cdqiLessThanOrEqualTo(Rank.colonel)`.
`~=` | `cdqiLike` | `"*obert*" ~= Person.e.firstName` or `Person.e.firstName.cdqiLike("*obert*")`.
`~=` | `cdqiMatches` | `/"^[Rr]ob" ~= Person.e.firstName` or `Person.e.firstName.cdqiMatches("^[Rr]ob")`. Note the `/` before `"^[Rr]ob"`. This turns it into a CDQI `Regex`. Otherwise `~=` is the `LIKE` operator. When using the method `cdqiMatches`, the argument can be a `String` or `Regex`.
&nbsp; | `cdqiContains` | `Person.e.lastName.cdqiContains("von", options: .caseInsensitive)`.
&nbsp; | `cdqiBeginsWith` | `Person.e.lastName.cdqiBeginsWith("X")`.
&nbsp; | `cdqiEndsWith` | `Person.e.firstName.cdqiEndsWith("n", options: .caseInsensitive)`.
