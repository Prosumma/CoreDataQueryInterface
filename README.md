## Overview

Core Data Query Interface is a type-safe, fluent library for working with Core Data in Swift. The syntax speaks for itself:

    let employees = moc.from(Employee).filter("salary > 80000").all()
    let highestPaidEmployeeName = moc.from(Employee).order(descending: "salary").select("name").first()
    let highestSalary: NSNumber = moc.from(Employee).max("salary").pluck()!.first!
    let numberOfSmiths = moc.from(Employee).filter("lastName = %@", "Smith").count()

    for employee in moc.from(Employee).order("startDate") {
    	debugPrintln(employee.firstName)
    }

    var error: NSError?
    let employees = moc.from(Employee).all(error: &error)

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
