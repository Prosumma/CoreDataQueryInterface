![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Swift-2.2-orange.svg)](http://swift.org)
![Platforms](https://img.shields.io/cocoapods/p/CoreDataQueryInterface.svg)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. CDQI is a bit like jQuery or LINQ, but for Core Data.

### Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety in filter comparisons
- [x] Three main query types: Entity, ManagedObjectID, and Dictionary (called "Expression" in CDQI)
- [x] Filtering, sorting, grouping, aggregate expressions, limits, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS and OS X

### Overview

In essence, CDQI is a tool that allows the creation (and execution) of fetch requests using a fluent syntax. In most cases, this can reduce many lines of code to a single (but still highly readable) line.

```swift
let swiftDevelopers = managedObjectContext.from(Developer).
                      filter{ any($0.languages.name == "Swift") }.
                      order(descending: {$0.lastName}).limit(5).all()
```

### Integration

#### Carthage

In your `Cartfile`, add the following line:

```ruby
github "prosumma/CoreDataQueryInterface" ~> 4.0
```

#### CocoaPods

Add the following to your `Podfile`. If it isn't already present, you will have to add `use_frameworks!` as well.

```ruby
pod 'CoreDataQueryInterface', '~> 4.0'
```

#### ManagedObjectContextType

In many of the examples, CDQI queries are started with an expression such as `managedObjectContext.from`. By default, merely writing `import CoreDataQueryInterface` does not add the `from` method to `NSManagedObjectContext`. To "opt in" to the use of this method, you must, somewhere in your project, place the following code:

`extension NSManagedObjectContext: ManagedObjectContextType {}`

Since it's highly unlikely that any other first- or third-party framework will add a `from` method to `NSManagedObjectContext`, this necessity will be removed in CDQI 5.0.

It is possible to use CDQI without doing implementing `ManagedObjectContextType`:

```swift
let query = EntityQuery.from(Developer).filter{ $0.lastName == "Morrissey" }
let morrissey = query.context(managedObjectContext).first()!
```

In fact, this method is recommended when caching queries to be used with any number of `NSManagedObjectContext` instances.

#### Proxies

In order to use expressions such as `$0.languages.name` as in the example above, proxy objects must be created. In the `bin` folder at the root of the project is a simple tool called `cdqi` that accomplishes this. Before running this tool, make sure that each `NSManagedObject` is represented by a corresponding class in your Swift project.

```sh
cdqi Developers
```

This searches all subdirectories recursively until it finds a managed object model called `Developers.xcdatamodeld`. It then examines the _current version_ of this model and generates proxy classes for each `NSManagedObject`. By default, these proxy classes are placed in the same directory as the managed object model, side by side. `cdqi` has many options to change this behavior if desired, but in most cases the default is what you want. For more options, execute `cdqi --help`.

### Type Safety

CDQI supports type safety in filter expressions. In the expression `$0.languages.name`, the `name` attribute has been defined as a string in the Core Data model, so it can only be compared to strings. The following will not compile:

```swift
$0.languages.name == 4
```

In order to support extensibility, CDQI's type safety is actually more sophisticated than described above. The Swift `String` type is able to participate in comparisons to string attributes because it implements `TypedExpressionConvertible`:

```swift
extension String: TypedExpressionConvertible {
    public typealias ExpressionValueType = String
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}
```

By implementing the `TypedExpressionConvertible` protocol and defining its `ExpressionValueType` `typealias` as `String`, a type can be made to participate in CDQI string comparisons. To participate in numeric comparisons, `ExpressionValueType` should be `NSNumber`.

Imagine a `Weekday` enumeration to which we wish to compare an `Int32` Core Data attribute. Instead of saying `$0.weekday == Weekday.Monday.rawValue`, we can make things a little nicer:

```swift
public enum Weekday: Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7    
}

extension Weekday: TypedExpressionConvertible {
    public typealias ExpressionValueType = NSNumber
    public var expression: NSExpression {
        return NSExpression(forConstantValue: rawValue)
    }
}
```

Now we can say `$0.weekday == Weekday.Monday`. Any type can be made to participate in CDQI filter comparisons using this technique.

### Query Reuse

CDQI uses value types wherever possible. Most CDQI methods such as `filter`, `order`, and so on return value types such as `EntityQuery` or `ExpressionQuery`. This allows techniques such as the following:

```swift
let projectQuery = EntityQuery.from(Project)
let swiftProjectQuery = projectQuery.filter{ any($0.languages.name == "Swift") }
```

The second statement causes no side effects on the first one.

### Examples

A great number of examples can be found in the unit tests, but here are a few at a glance.

```swift
let developerQuery = managedObjectContext.from(Developer)
// predicate: languages.@count == 3 AND ANY languages.name == "Rust"
// developersWhoKnowThreeLanguagesIncludingRust is an array of Developer entities
let developersWhoKnowThreeLanguagesIncludingRust = developerQuery.filter{ $0.languages.count == 3 &&
                                                   any($0.languages.name == "Rust") }.all()

// predicate: ANY languages.name == "Haskell"
// haskellDevelopers is an array of dictionaries, e.g., [["firstName": "Haskell", "lastName": "Curry"]]
let haskellDevelopers = developerQuery.
                        filter{ developer in any(developer.languages.name == "Haskell") }.
                        select{ developer in [developer.firstName, developer.lastName] }.all()

// Instead of using $0, we can create a proxy up front.
let project = Project.EntityAttributeType()

// We can do a query in a single line
var swiftProjectNames: [String] = managedObjectContext.from(Project).
                                  filter(any(project.languages.name == "Swift")).
                                  order(project.name).array(project.name)

// Or we can build it up in multiple lines
var projectQuery = managedObjectContext.from(Project)
projectQuery = projectQuery.filter(any(project.languages.name == "Swift"))
projectQuery = projectQuery.order(project.name)
swiftProjectNames = projectQuery.array(project.name)
```

### Kudos

My thanks to [Pat Goley](https://github.com/patgoley) for providing the impetus for and assistance with type safety in filter expressions.
