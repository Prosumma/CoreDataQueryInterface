## Overview

Core Data Query Interface is a type-safe, fluent library for working with Core Data in Swift. If you've worked with LINQ in the C# world, you can think of CDQI as "LINQ for Core Data", though without the syntactic sugar of the custom operators.

The syntax speaks for itself:

```swift
let employees = moc.from(Employee).filter("salary > 80000").all()
let highestPaidEmployeeName = moc.from(Employee).order(descending: "salary").select("name").first()
let highestSalary: NSNumber = moc.from(Employee).max("salary").value()!
let numberOfSmiths = moc.from(Employee).filter("lastName = %@", "Smith").count()

for employee in moc.from(Employee).order("startDate") {
    debugPrintln(employee.firstName)
}

var error: NSError?
let employees = moc.from(Employee).all(error: &error)
```

Core Data is an Objective-C API. Using it in Swift can be painful because of the amount of casting, the number of statements required to do common things, etc. CDQI removes that pain.

CDQI supports all of Core Data's result types: entities, dictionaries, `NSManagedObjectID`s, and (indirectly) counts:

    let employees = moc.from(Employee).all()
    let employeeFirstNames = moc.from(Employee).select("firstName").all()
    let employeeObjectIDs = moc.from(Employee).ids().all()
    let numberOfEmployees = moc.from(Employee).count()

Queries are infinitely reusable. Later parts of a query have no side effects on earlier parts, e.g.,

    let employeeQuery = moc.from(Employee)
    let employeeSalaryQuery = employeeQuery.order(descending: "salary")

The `employeeQuery` is not affected in any way by the creation of `employeeSalaryQuery`.

So far in the examples, the queries have always started with an instance of `NSManagedObjectContext`, but this is not necessary:

    let employeeSalaryQuery = EntityQuery.from(Employee).order(descending: "salary")

To use such a query, you must specify an `NSManagedObjectContext` at the time the query is executed, e.g.,

    employeeSalaryQuery.context(moc).all()
    employeeSalaryQuery.all(managedObjectContext: moc)
    employeeSalaryQuery.first(managedObjectContext: moc)

The ability to store and reuse queries without specifying a managed object context up front is one of the great advantages of CDQI.

## Status

Dig in. An earlier but similar version of the library has already proven itself in a production project. Everything shown above (and more) works and works well. However, before I can tag a 1.0 release, I want to write documentation and unit tests.

## Requirements

CDQI requires Swift >= 1.2 and iOS >= 8.3 or Mac OS X >= 10.10.3. (It may work on earlier minor versions of iOS and Mac OS X, but that has not been tried.)

## Brief Architectural Sketch

At the heart of CDQI are the three query types. They are `EntityQuery`, `ExpressionQuery`, and `ManagedObjectIDQuery`. Each corresponds to one of the possible result types of `NSFetchRequest`, except for `NSCountResultType` which is handled in a different way.  All three are structs.

The fluent, "chainable" CDQI methods return one of these, depending partly on how the query was started and partly on which method is being called. For instance, `filter` simply returns the same query type it was called on, but `select` always returns `ExpressionQuery`, even if it was called on an instance of `EntityQuery`. This is because as soon as `select` has been used, we know we want to return a dictionary result rather than entities. (In other words, we've selected some "expressions" to return, rather than entities.)


