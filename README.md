# Core Data Query Interface

Core Data Query Interface is a type-safe, lazy, fluent, mostly immutable query library for working with Core Data.

Which would you rather write? This…

    let request = NSFetchRequest(entityName: "Employee")
    request.predicate = NSPredicate(format: "salary > %@", salary)
    request.fetchLimit = 100
    request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
    if let employees = managedObjectContext.executeFetchRequest(request, nil) as! [Employee]? {
        // blah blah
    }

or this…

    if let employees = managedObjectContext.from(Employee).sort("startDate").limit(100).all() {
        // blah blah
    }

## Starting a query

CDQI adds a few extension methods to `NSManagedObjectContext`. However, most of the action occurs on the `Query<E>` type, which we'll discuss later. To get started with a query, you have a couple of recommended options:

- `let employees = Query.from(Employee)`
- `let employees = managedObjectContext.from(Employee)`

There are several others, but they are likely to be less clear to a reader of your code. The difference between the two is that the first one does not have an associated `NSManagedObjectContext` while the second does. Read the section below on executing a query to find out how to specify a MOC for the first option.

## Filtering

Unsurprisingly, the `filter` function is used to filter a query:

- `employees.filter("salary > %@", salary)`
- `employees.filter(predicate)`

Filters are cumulative. A logical 'and' is assumed to be between each successive predicate. The following two filters are equivalent.

- `employees.filter("salary > %@", salary).filter("startDate > %@", cutoffDate)`
- `employees.filter("(salary > %@) AND (startDate > %@)", salary, cutoffDate)`

# Ordering

The `order` function takes a list of `String` or `NSSortDescriptor` objects. (The result of passing any other kind of object is undefined.)

- `employees.order("name", NSSortDescriptor(key: "startDate", ascending: false)


