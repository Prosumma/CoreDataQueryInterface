![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Language](https://img.shields.io/badge/Swift-5.7-blue.svg)](http://swift.org)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability and refactoring by allowing method chaining and by eliminating magic strings.

CDQI uses the [PredicateQI](https://github.com/prosumma/PredicateQI) (PQI) package. PQI provides a type-safe Swift interface on top of Apple's `NSPredicate` language. CDQI adds the machinery needed to make PQI work with Core Data. 

## Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety in filter comparisons.
- [x] Filtering, sorting, grouping, aggregate expressions, limits, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] TODO: minimum OS support
- [x] Swift 5.7

## Overview

The best way to understand how to use CDQI is to look at the unit tests, but an example will make things clear.

First, let's start with the following data model:

```swift
class Language: NSManagedObject {
  @NSManaged var name: String
  @NSManaged var developers: Set<Developer>
}

class Developer: NSManagedObject {
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var languages: Set<Language>
}
```

Given this data model, we can start making some queries:

```swift
// Which languages are known by at least two of the developers?
// developers.@count >= 2
Query(Language.self).filter { $0.developers.pqiCount >= 2 }

// Which languages are known by developers whose name contains 's'? 
// ANY developers.lastname LIKE[c] '*s*'
Query(Language.self).filter { any(ci($0.developers.lastName %* "*s*")) }
```

We can get the `NSFetchRequest` produced by the query by asking for its `fetchRequest` property. But it's usually easier just to execute the fetch request directly:

```swift
let cooldevs = try Query(Developer.self)
    .filter { 
      // ANY languages.name IN {"Rust","Haskell"}
      any($0.languages.name <~| ["Rust", "Haskell"])
    }
    .fetch(moc)
```
