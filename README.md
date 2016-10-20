![CoreDataQueryInterface](CoreDataQueryInterface.png)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. CDQI is a bit like jQuery or LINQ, but for Core Data.

### Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety in filter comparisons.
- [x] Filtering, sorting, grouping, aggregate expressions, limits, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS 9+, macOS 10.11+, tvOS 9+, and watchOS 2+.
- [x] Swift 3 (for Swift 2.2, use v4.0)

### Overview

In essence, CDQI is a tool that allows the creation (and execution) of fetch requests using a fluent syntax. In most cases, this can reduce many lines of code to a single (but still highly readable) line.

```swift
let swiftDevelopers = managedObjectContext.from(Developer.self).
                      filter{ any($0.languages.name == "Swift") }.
                      order(ascending: false, {$0.lastName})
                      .limit(5)
                      .all()
```

### Integration

#### Carthage

In your `Cartfile`, add the following line:

```ruby
github "prosumma/CoreDataQueryInterface" ~> 5.0
```

#### CocoaPods

Add the following to your `Podfile`. If it isn't already present, you will have to add `use_frameworks!` as well.

```ruby
pod 'CoreDataQueryInterface', '~> 5.0'
```

### Changes From Previous Versions

The overall syntax of CDQI is unchanged from previous versions, as the examples in this document show. But there are small changes.

First, `EntityQuery`, `ExpressionQuery` and the like are gone, replaced by a single type `Query<M, R>`. The first generic parameter is the type of managed object model to work with. The second parameter is the result type, which must conform to the `NSFetchResultType` protocol. So instead of saying `EntityQuery.from(Project.self)`, just create an instance with `Query<Project, NSDictionary>()`.

The second major difference is the use of prefixes on methods, properties, and type aliases. CDQI extends common types like `String`, `NSExpression`, and so on. Previous versions of CDQI added method and property names that had a higher likelihood of conflict with other frameworks or future changes by Apple. To mitigate this, methods, properties, and associated types that may be added to arbitrary types use the `cdqi` or `CDQI` prefix as appropriate. For example:

```swift
public protocol ExpressionConvertible {
  var cdqiExpression: NSExpression { get }
}

public protocol TypedExpressionConvertible: ExpressionConvertible, Typed {
    associatedtype CDQIComparisonType: Typed
}
```

### Attribute Proxies

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
    public typealias CDQIComparisonType = String
    public static let cdqiStaticType = NSAttributeType.stringAttributeType
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}
```

By implementing the `TypedExpressionConvertible` protocol and defining its `CDQIComparisonType` `typealias` as `String`, a type can be made to participate in CDQI string comparisons. To participate in numeric comparisons, `CDQIComparisonType` should be `NSNumber`.

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
    public typealias CDQIComparisonType = NSNumber
    public static let cdqiStaticType = NSAttributeType.integer32AttributeType
    public var cdqiExpression: NSExpression {
        return NSExpression(forConstantValue: NSNumber(value: rawValue))
    }
}
```

Now we can say `$0.weekday == Weekday.Monday`. Any type can be made to participate in CDQI filter comparisons using this technique.

### Query Reuse

CDQI uses value types wherever possible. Most CDQI methods such as `filter`, `order`, and so on return the value type `Query<M, R>`. This allows techniques such as the following:

```swift
let projectQuery = Query<Project, Project>()
let swiftProjectQuery = projectQuery.filter{ any($0.languages.name == "Swift") }
```

The second statement causes no side effects on the first one.

### Examples

A great number of examples can be found in the unit tests and the "Top Hits" example app in the `Examples` folder, but here are a few at a glance.

```swift
let developerQuery = managedObjectContext.from(Developer.self)
// predicate: languages.@count == 3 AND ANY languages.name == "Rust"
// developersWhoKnowThreeLanguagesIncludingRust is an array of Developer entities
let developersWhoKnowThreeLanguagesIncludingRust = developerQuery.filter{ $0.languages.cdqiCount() == 3 &&
                                                   any($0.languages.name == "Rust") }.all()

// predicate: ANY languages.name == "Haskell"
// haskellDevelopers is an array of dictionaries, e.g., [["firstName": "Haskell", "lastName": "Curry"]]
let haskellDevelopers = developerQuery.
                        filter{ developer in any(developer.languages.name == "Haskell") }.
                        select{ developer in [developer.firstName, developer.lastName] }.all()

// Instead of using $0, we can create a proxy up front.
let project = Project.CDQIAttribute()

// We can do a query in a single line
var swiftProjectNames: [String] = managedObjectContext.from(Project.self).
                                  filter(any(project.languages.name == "Swift")).
                                  order(project.name).array(project.name)

// Or we can build it up in multiple lines
var projectQuery = managedObjectContext.from(Project.self)
projectQuery = projectQuery.filter(any(project.languages.name == "Swift"))
projectQuery = projectQuery.order(project.name)
swiftProjectNames = projectQuery.array(project.name)
