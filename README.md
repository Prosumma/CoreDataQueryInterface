![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability. If you've worked with LINQ in the C# world, CDQI is a bit like LINQ.

## Swift 2.0

Due to the recent announcement of Swift 2.0, all work on this version of CDQI is suspended. If you want to see my progress on the new CDQI, check out the `swift2.0` branch.

## Advantages

The best way to understand the advantages of CDQI is to see an example. (Be sure to scroll right to see the entire example).

```swift
// Iteration causes the query to execute, though there are other ways
for employee in managedObjectContext.from(Employee).filter({$0.salary > 70000 && $0.department.name == "Engineering"}).order(descending: {$0.lastName}, {$0.firstName}) {
  debugPrintln("\(employee.lastName), \(employee.firstName)")
}
```

Now compare this to vanilla Core Data:

```swift
let fetchRequest = NSFetchRequest(entityName: "Employee")
fetchRequest.predicate = NSPredicate(format: "salary > %ld && department.name == %@", 70000, "Engineering")
fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: false), NSSortDescriptor(key: "firstName", ascending: false)]
for employee in managedObjectContext.executeFetchRequest(fetchRequest, error: nil)! as! [Employee] {
  debugPrintln("\(employee.lastName), \(employee.firstName)")
}
```

Compare the quantity and readability of the code in the two examples. Which would you rather write?

## Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface)
- [x] Large number of overloads
- [x] Type-safety
- [x] Lazy execution
- [x] Three main query types: Entity, ManagedObjectID, and Dictionary (called "Expression" in CDQI)
- [x] Grouping, sorting, counts, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS and OS X

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

### Manually

CoreDataQueryInterface is a perfectly ordinary Xcode framework project with support for both iOS and OS X. Integrate as you normally would any other framework.

## Usage

### Integration

In order to use CoreDataQueryInterface with your models, they must implement the `ManagedObjectType` protocol:

```swift
class Department : NSManagedObject, ManagedObjectType {
  @NSManaged var name: String
}

class Employee : NSManagedObject, ManagedObjectType {
  @NSManaged var department: Department
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var salary: Int
}
```

#### Attributes

In order to use CoreDataQueryInterface's support for sorting, filtering, and the like without magic strings, you have to do a little more work. _This is completely optional but highly recommended._

```swift
class Department : NSManagedObject, ManagedObjectType {
  typealias ManagedObjectAttributeType = DepartmentAttribute
  @NSManaged var name: String
}

class DepartmentAttribute : Attribute {
  var name: Attribute { return Attribute("name", parent: self) }
}

class Employee : NSManagedObject, ManagedObjectType {
  typealias ManagedObjectAttributeType = EmployeeAttribute
  @NSManaged var department: Department
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var salary: Int
}

class EmployeeAttribute : Attribute {
  var department: DepartmentAttribute { return DepartmentAttribute("department", parent: self) }
  var firstName: Attribute { return Attribute("firstName", parent: self) }
  var lastName: Attribute { return Attribute("lastName", parent: self) }
  var salary: Attribute { return Attribute("salary", parent: self) }
}
```

### Starting a Query

There are three query types.

- `EntityQuery` This query requests entities, i.e., `NSManagedObject` subclasses, as the result.
- `ExpressionQuery` This query requests dictionaries as a result. It's called `ExpressionQuery` because typically this query is used when you want to perform some kind of calculation.
- `ManagedObjectIDQuery` This query requests an array of `NSManagedObjectID` as the result.

You can start a query using the static `from` method, either from one of the query types or from `NSManagedObjectContext`. If you start with a context, it's automatically an `EntityQuery`.

```swift
managedObjectContext.from(Employee) // Starts an EntityQuery
EntityQuery.from(Employee)
ExpressionQuery.from(Employee)
ManagedObjectIDQuery.from(Employee)
```

The first way, starting from a context, is the most common. If you start from `EntityQuery`, `ExpressionQuery`, or `ManagedObjectIDQuery`, no context is associated, so you will have to specify one later in the chain. If you start with an `EntityQuery`, there are very simple ways to turn the query into one of the other types.

### Specifying a Managed Object Context

If you start with a context and use `from`, a context has already been specified. If you start with `EntityQuery` and the like, you must specify a context. One way to do this is with the `context` method:

```swift
let query = EntityQuery.from(Employee).filter() { $0.department.name == "Sales" }
query.context(managedObjectContext)
```

There are other ways, as will be discussed below.

### Filtering

Filtering uses the `filter` method. There are a large number of overloads to support such things as `NSPredicate`, string-based queries, `Attribute`-based queries, etc. In general, the `Attribute`-based queries are recommended.

```swift
let employees = managedObjectContext.from(Employee)
employees.filter() { $0.department.name == "Sales" } // Attribute query. Recommended.
employees.filter(NSPredicate(format: "department.name == %@", "Sales"))
employees.filter("department.name == %@", "Sales"))
```

When filters are chained, the result is as if they were joined with `&&`. The following two filters are equivalent:

```swift
let employees = managedObjectContext.from(Employee)
employees.filter({ $0.department.name == "Sales" }).filter({ $0.lastName = "Smith" })
employees.filter({ $0.department.name == "Sales" && $0.lastName == "Smith" })
```

#### Filtering With Nil

When using `nil`, it's necessary to cast `nil` so that Swift knows which of the many operator overloads to call, e.g.,

```swift
employees.filter({ $0.department.name == nil as String? })
```

### Sorting

Sorting uses the `order` method. Its overloads are very similar to those of `filter`, except that each overload has a `descending:` variant.

```swift
let employees = managedObjectContext.from(Employee)
employees.order(descending: {$0.lastName}).order({$0.firstName})
employees.order({$0.lastName},{$0.firstName})
employees.order({e in [e.lastName, e.firstName]})
employees.order("lastName", "firstName")
```

When subsequent `order` methods are chained, the result is cumulative.

### Executing Queries

An ordinary query chain does not actually execute anything.

```swift
// A query to get all the Sales people
let query = EntityQuery.from(Employee).filter() { employee in employee.department.name == "Sales" }
let sortedQuery: EntityQuery<Employee> = query.order(descending: {$0.lastName}).order({$0.firstName})
```

The variables `query` and `sortedQuery` are not the executed results of these expressions. In other words, they're not arrays of `Employee` entities. They are the queries themselves. This is illustrated by the fact that `sortedQuery` is constructed from `query` and the (completely optional) type annotation added to `sortedQuery`. _This action is free of side-effects._ The `query` variable is unaffected by the creation of `sortedQuery`. (Note also that neither of these queries has an assigned managed object context.)

The simplest way to execute a query is to iterate over it.

```swift
let query = EntityQuery.from(Employee).filter() { employee in employee.department.name == "Sales" }
for employee in query.context(moc) {
  debugPrintln(employee)
}
```

Iteration swallows errors and simply does not iterate if an error occurs. A more sophisticated way is to use one of the _query execution methods_, such as `all`.

```swift
let query = EntityQuery.from(Employee).filter() { employee in employee.department.name == "Sales" }
var error: NSError?
let salesPeople = query.context(moc).all()!
let salesPeople = query.all(managedObjectContext: moc)!
let salesPeople = query.context(moc).all(error: &error)!
```

Here you can see the many possible variants. The `all` method returns `nil` if an error occurs. What exactly `all` returns depends on the type of query. For `EntityQuery`, it's an array of `NSManagedObject`s. For `ExpressionQuery`, it's `[[String: AnyObject]]`. For `ManagedObjectIDQuery` it's obviously `[NSManagedObjectID]`.

There are four other query execution methods: `first` and `count`, which are available on all query types, and `value` and `pluck`, which are not available on `ManagedObjectIDQuery`. `value` and `pluck` will be discussed in the as-yet-unwritten Advanced Usage section.

Examples of `first` and `count`:

```swift
var error: NSError?
let topPaidSalesPerson = moc.from(Employee).filter({ e in e.department.name == "Sales" }).order(descending: {$0.salary}).first(error: &error)!
let numberOfEngineers = moc.from(Employee).filter({ $0.department.name == "Engineering" }).count()!
```

