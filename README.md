# Core Data Query Interface

Core Data Query Interface is a type-safe, lazy, fluent, mostly immutable query library for working with Core Data.

Which would you rather write? This…

    let request = NSFetchRequest(entityName: "Employee")
    request.predicate = NSPredicate(format: "salary > %@", salary)
    request.fetchLimit = 100
    request.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: true)]
    if let employees = managedObjectContext.executeFetchRequest(request, nil) as! [Employee]? {
        for employee in employees {
            debugPrintln(employee.name)
        }
    }

or this…

    for employee in managedObjectContext.from(Employee).order("startDate").limit(100) {
        debugPrintln(employee.name)
    }

## Starting a query

CDQI adds a few extension methods to `NSManagedObjectContext`. However, most of the action occurs on the `Query<E>` type, which we'll discuss later. To get started with a query, you have a couple of recommended options:

    let query = Query.from(Employee)
    let query = managedObjectContext.from(Employee)

There are several others, but they are likely to be less clear to a reader of your code. The difference between the two is that the first one does not have an associated `NSManagedObjectContext` while the second does. Read the section below on executing a query to find out how to specify a MOC for the first option.

## Filtering

Unsurprisingly, the `filter` method is used to filter a query:

    query.filter("salary > %@", salary)
    query.filter(predicate)

Filters are cumulative. A logical 'and' is assumed to be between each successive predicate. The following two filters are equivalent.

    query.filter("salary > %@", salary).filter("startDate > %@", cutoffDate)
    query.filter("(salary > %@) AND (startDate > %@)", salary, cutoffDate)

## Ordering

The `order` method takes a list of `String` or `NSSortDescriptor` objects. (The result of passing any other kind of object is undefined.)

    query.order("name", NSSortDescriptor(key: "startDate", ascending: false))

Like filters, subsequent calls to `order` simply append more sort descriptors to the list, so the above is exactly equivalent to:

    query.order("name").order(NSSortDescriptor(key: "startDate", ascending: false))

## Limiting and Offsetting

Pretty straightforward:

    query.limit(5).offset(10)

## Executing a Query

An expression like `query.filter("salary > %@", salary)` doesn't immediately return a filtered list of employees. One of the simplest ways to work with the list of employees is to iterate:

    for employee in query.filter("salary > %@", salary) {
        debugPrintln(employee.name)
    }

The result of the `filter` method (and most others) is a `Query<E>`, which implements `SequenceType`. The act of iterating builds and executes an `NSFetchRequest` on the underlying `NSManagedObjectContext`. (Of course, this won't work if your query doesn't specify an `NSManagedObjectContext`. See the section on specifying a managed object context for more on that.)

This approach should only be used if you know for certain that your query won't fail with an `NSError`. If your query does fail, the iteration approach fails silently: it just doesn't iterate. A safer approach, using the `all` method, is shown below:

    var error: NSError?
    let query = managedObjectContext.from(Employee)
    if let employee = query.filter("salary > %@", salary).all(error: &error) {
        for employee in query {
            debugPrintln(employee.name)
        }
    }

 Besides the implicit execution that occurs as a result of iteration, there are three methods that can be used to execute the underlying query: `all`, `first`, and `count`, whose meanings should be obvious. Each of them has roughly the same signature, differing only in their result types.

    func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [E]?
    func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> E?
    func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt?

Some examples:

    let query = managedObjectContext.from(Employee)
    // Get a count
    debugPrintln(query.count())
    // Create a new query based on the first one
    let firstNameGregoryQuery = query.filter("firstName = %@", "Gregory")
    // Find the first one with sorting, criteria, and a little paranoia
    var error: NSError?
    debugPrintln(firstNameGregoryQuery.order("lastName").first(error: &error))
    // Confidently get all records as an array
    let employees = firstNameGregoryQuery.all()!

## Specifying a Managed Object Context

It's possible to create a query that does not reference a managed object context at all:

    let query = Query.from(Employee).filter("salary > %@", salary).order("lastName", "firstName")

If executed, this query will throw an exception. The easiest way to specify a MOC after the fact is to specify it in one of the query execution methods, e.g.,

    query.first(managedObjectContext: managedObjectContext)

Why have queries like this? Because they can be reused with any number of MOCs. If you follow Core Data best practices, you should be using child contexts fairly frequently. You could have a set of commonly used queries that could be reused across your child contexts with ease. 

The other way to specify a MOC is to start with one. CDQI adds the `from` method to `NSManagedObjectContext`:

    managedObjectContext.from(Employee).order("lastName", "firstName").all()

Lastly, you can use the `context` method, which is chainable:

    Query.from(Employee).context(managedObjectContext).order("lastName").all()

There can only be one MOC at a time. This means that a method chain that specifies different MOCs will end up using the last one, e.g.,

    managedObjectContext.from(Employee).context(managedObjectContext2).sort("lastName").first(managedObjectContext: managedObjectContextActuallyUsed)

All MOCs in the chain except the last one are ignored.

## Immutability and Reuse

The chainable query methods (`filter`, `order`, `context`, etc.) return an instance of `struct Query<E>`. Because it's a struct, each invocation of one of these methods returns a _copy_ of the state of the previous one, without altering the previous one at all. This means that queries can be built up partially in a myriad of ways:

    let employeeQuery = Query.from(Employee)
    let highSalaryEmployeeQuery = employeeQuery.filter("salary > 80000")
    let sortedHighSalaryEmployeeQuery = highSalaryEmployeeQuery.order(NSSortDescriptor(key: "salary", ascending: false))
    let sortedHighSalaryEmployeeLastNameSmithQuery = sortedHighSalaryEmployeeQuery.filter("lastName = %@", "Smith")

Each subsequent assignment has _absolutely no effect on the previous one_. In other words, creating `sortedHighSalaryEmployeeQuery` does not alter `highSalaryEmployeeQuery` in the slightest.
