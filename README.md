![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Swift-5.1-orange.svg)](http://swift.org)
![Platforms](https://img.shields.io/cocoapods/p/CoreDataQueryInterface.svg)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. CDQI is a bit like jQuery or LINQ, but for Core Data.

NOTE: The `cdqi` tool used to generate attribute proxies is deprecated. Bug fixes and changes in Swift make it very simple to hand-code attribute proxies, so the `cdqi` tool is no longer necessary.

### Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety in filter comparisons.
- [x] Filtering, sorting, grouping, aggregate expressions, limits, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS 9+, macOS 10.11+, tvOS 9+, and watchOS 2+.
- [x] Swift 5 

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

### Attribute And Model Proxies

CDQI works through the use of _attribute and model proxies_. In CDQI, a proxy is a type that stands in for a Core Data model or attribute. There are built-in proxies for all the Core Data attribute types, e.g., `Int32Attribute`, `StringAttribute` and so on. For your own Core Data models, you will need to create your own proxies, which is very simple to do. Imagine we have two Core Data models, `Employee` and `Department`. There is a many-to-one relationship in Core Data between these models. To keep things simple, each has a simple `name` attribute of type `String`:

```swift
class Employee: NSManagedObjectModel {
    @NSManaged var name: String
    @NSManaged var department: Department
}

class Department: NSManagedObjectModel {
    @NSManaged var name: String
    @NSManaged var employees: Set<Employee>
}
```

The proxy classes for these should look like this:

```swift
class EmployeeAttribute: EntityAttribute, Subqueryable {
    public private(set) lazy var name = StringAttribute(key: "name", parent: self)
    public private(set) lazy var department = DepartmentAttribute(key: "department", parent: self)
}

extension Employee: Entity {
    public typealias CDQIEntityAttribute = EmployeeAttribute
}

class DepartmentAttribute: EntityAttribute, Subqueryable {
    public private(set) lazy var name = StringAttribute(key: "name", parent: self)
    public private(set) lazy var employees: EmployeeAttribute(key: "employees", parent: self)    
}

extension Department: Entity {
    public typealias CDQIEntityAttribute = DepartmentAttribute
}
```

Once this is done, CDQI can do its magic.

### Starting a Query

A CDQI query is a chain of methods that build an `NSFetchRequest`. Almost all of the `NSFetchRequest`'s functionality is supported, such as choosing the result type, limiting the number of records fetched, filtering, sorting, etc.

A query is started by creating an instance of `Query`, which takes two generic type parameters. The first one tells us which `NSManagedObject` subclass is the target of our query. The second tells us what the result of the query should be: Either the same `NSManagedObject` subclass or an `NSDictionary`.

```swift
let developerQuery = Query<Developer, Developer>()
let developerDictionaryQuery = Query<Developer, NSDictionary>()
```

Most `Query` instances are of the form `Query<M, M>` where `M` is an `NSManagedObject`. A perhaps better way to start a query is…

```swift
let developerQuery = Developer.cdqiQuery
```

Queries started with `Query<Developer, Developer>` or `Developer.cdqiQuery` have no implicit `NSManagedObjectContext`, so one must be passed when executing a query.

```swift
try Developer.cdqiQuery.order(by: Developer.e.lastName).all(managedObjectContext: moc)
try Developer.cdqiQuery,order(by: Developer.e.lastName).context(moc).all()
```

This pattern is so common that a convenience method exists on `NSManagedObjectContext`.

```swift
try moc.from(Developer.self).order(by: Developer.e.lastName).all()
```

### Filtering

Filtering in Core Data requires an `NSPredicate`. CDQI has overloads of many of the built-in operators. These overloads generate Core Data friendly `NSPredicate`s instead of `Bool`s. They are carefully designed so as not to conflict with the ordinary operators.

| Swift | `NSPredicate` |
| --- | --- |
| `Developer.e.lastName == "Li"` | `"lastName == 'Li'"` |
| `Person.e.age >= 18` | `"age >= 18"` |
| `21...55 ~= Person.e.age` | `"age BETWEEN 21 AND 55"` |
| `Person.e.firstName == "Friedrich"  && Person.e.lastName == "Hayek"` | `"firstName == 'Friedrich' AND lastName == 'Hayek'"` |