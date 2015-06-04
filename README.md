![CoreDataQueryInterface](CoreDataQueryInterface.png)

<!-- [![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface) -->
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Overview

Core Data Query Interface is a type-safe, fluent, intuitive library for working with Core Data in Swift. If you've worked with LINQ in the C# world, you can think of CDQI as "LINQ for Core Data".

The simplicity of the syntax compared to standard Core Data speaks for itself:

```swift
// all() executes the query and returns an array
let employees = moc.from(Employee).filter({$0.salary > 80000}).all()
// value() executes the query and returns the first value in the first row.
let highestPaidEmployeeName = moc.from(Employee).order(descending: {$0.salary}).select({$0.name}).limit(1).value()! as! NSNumber
// The usual aggregates are built in. Other functions can be called with the `function` method.
let highestSalary = moc.from(Employee).max("salary").value()! as! NSNumber
// count() executes the query and returns the number of rows.
let numberOfSmiths = moc.from(Employee).filter({$0.lastName == "Smith"}).count()

// Iteration automatically causes the query to be executed.
for employee in moc.from(Employee).order({$0.startDate}) {
    debugPrintln(employee.firstName)
}

// All of the query execution methods (`all`, `first`, `count`, `pluck`, and `value') have overloads
// that let you specify an `NSError` and/or `NSManagedObjectContext`.
var error: NSError?
let employees = moc.from(Employee).all(error: &error)
```

Core Data is an Objective-C API. Using it in Swift can be painful because of the amount of casting, the number of statements required to do common things, etc. CDQI removes that pain.

CDQI supports all of Core Data's result types: entities, dictionaries, `NSManagedObjectID`s, and (indirectly) counts:

```swift
let employees = moc.from(Employee).all() // entities
let employeeFirstNames = moc.from(Employee).select({$0.firstName}).all() // array of dictionaries
let employeeObjectIDs = moc.from(Employee).ids().all() // object IDs
let numberOfEmployees = moc.from(Employee).count() // count
```

Queries are infinitely reusable. Later parts of a query have no side effects on earlier parts, e.g.,

```swift
let employeeQuery = moc.from(Employee)
let employeeSalaryQuery = employeeQuery.order(descending: {$0.salary})
```

The `employeeQuery` is not affected in any way by the creation of `employeeSalaryQuery`. 

So far in the examples, the queries have always started with an instance of `NSManagedObjectContext`, but this is not necessary:

```swift
let employeeSalaryQuery = EntityQuery.from(Employee).order(descending: {$0.salary})
```

To use such a query, you must specify an `NSManagedObjectContext` at the time the query is executed, e.g.,

```swift
employeeSalaryQuery.context(moc).all()
employeeSalaryQuery.all(managedObjectContext: moc)
employeeSalaryQuery.first(managedObjectContext: moc)
// etc.
```

The ability to store and reuse queries without specifying a managed object context up front is one of the great advantages of CDQI, making it possible to create a library of reusable queries. You can also turn such queries into fetch requests for use with `NSFetchedResultsController`, e.g.,

```swift
let fetchRequest = EntityQuery.from(Employee).order({$0.lastName}).limit(20).request()
```
## How To Use CDQI With Your Managed Objects

Implementation is simple. The minimum requirements are that you use an `NSManagedObject` subclass and that it implements CDQI's `ManagedObjectType` protocol. All managed objects are conformant by default, so in the simplest case, this will do:

```swift
class Employee: NSManagedObject, ManagedObjectType {
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var salary: Int
  @NSManaged var startDate: NSDate
}
```

If you want to participate in type-safe filtering, ordering, and selecting, a little more work is required:

```swift
class Employee: NSManagedObject, ManagedObjectType {
  typealias ManagedObjectAttributeType = EmployeeAttribute
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var salary: Int
  @NSManaged var startDate: NSDate
}

class EmployeeAttribute : Attribute {
  var firstName: Attribute {
    return Attribute("firstName", parent: self)
  }
  var lastName: Attribute {
    return Attribute("lastName", parent: self)
  }
  var salary: Attribute {
    return Attribute("salary", parent: self)
  }
  var startDate: NSDate {
    return Attribute("startDate", parent: self)
  }
}
```

For each attribute of `Employee` that you want to use in a query, you must have a corresponding property of type `Attribute` on the `EmployeeAttribute` type. You must then tell CDQI about the association between these two types with the declaration `typealias ManagedObjectAttributeType = EmployeeAttribute`. You can then say things like…

```swift
moc.from(Employee).filter({$0.salary >= 30000}).order(descending: {$0.lastName}, {$0.firstName}).all()
moc.from(Employee).select({$0.lastName}).pluck() // Gets all the last names as an array.
```

A tool is in the works to generate the `Attribute` classes, but I tend to follow the [YAGNI](http://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it) principle and add attributes only as needed.

It is optional to use the type-safe queries. Queries with strings are also available, and they work just fine:

```swift
moc.from(Employee).filter("salary > %ld", salary).order(descending: "lastName", "firstName").all()
```

## Requirements

CDQI requires Swift >= 1.2 and iOS >= 8.1 or Mac OS X >= 10.10.3. (It may work on earlier minor versions of iOS and Mac OS X, but that has not been tried.)

## Brief Architectural Sketch

At the heart of CDQI are the three query types. They are `EntityQuery`, `ExpressionQuery`, and `ManagedObjectIDQuery`. Each corresponds to one of the possible result types of `NSFetchRequest`, except for `NSCountResultType` which is handled in a different way.  All three are structs.

The fluent, "chainable" CDQI methods return one of these, depending partly on how the query was started and partly on which method is being called. For instance, `filter` simply returns the same query type it was called on, but `select` always returns `ExpressionQuery`, even if it was called on an instance of `EntityQuery`. This is because as soon as `select` has been used, we know we want to return a dictionary result rather than entities. (In other words, we've selected some "expressions" to return, rather than entities.)

