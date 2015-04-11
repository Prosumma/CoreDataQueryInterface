# Core Data Query Interface

Core Data Query Interface is a type-safe, fluent, mostly immutable query library for working with Core Data.

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
(There are several others, but they are likely to be less clear to a reader of your code.)

The difference between the two is that the first one does not have an associated `NSManagedObjectContext` while the second does. 
