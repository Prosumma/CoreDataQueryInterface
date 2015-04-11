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

## Query<E>


