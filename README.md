![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Language](https://img.shields.io/badge/Swift-2.2-orange.svg)](http://swift.org)
![Platforms](https://img.shields.io/cocoapods/p/CoreDataQueryInterface.svg)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. CDQI is a bit like jQuery or LINQ, but for Core Data.

#### Advantages

The best way to understand the advantages of CDQI is to see an example.

```swift
managedObjectContext
    .from(Employee)
    .filter{$0.salary > 70000 && $0.department.name == "Engineering"}
    .order(descending: {$0.lastName}, {$0.firstName})
    .all()
```

Now compare this to vanilla Core Data:

```swift
let fetchRequest = NSFetchRequest(entityName: "Employee")
fetchRequest.predicate = NSPredicate(format: "salary > %ld && department.name == %@", 70000, "Engineering")
fetchRequest.sortDescriptors = [
    NSSortDescriptor(key: "lastName", ascending: false),
    NSSortDescriptor(key: "firstName", ascending: false)
  ]
try! managedObjectContext.executeFetchRequest(fetchRequest)
```

Besides the greater readability of the code, the other advantage is that if your data model changes, _CDQI queries will fail to compile_ (assuming you've regenerated your proxies), while magic strings will not. This is what you want! It immediately points out errors in your code at compile time.

#### Features

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety. If your data model changes, magic strings won't give compilation errors.
- [x] Three main query types: Entity, ManagedObjectID, and Dictionary (called "Expression" in CDQI)
- [x] Filtering, grouping, sorting, counts, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS and OS X

#### Compatibility

4.x proxy classes are not compatible with previous versions. You must regenerate your proxy classes to use 4.x. In addition, if you are upgrading from versions prior to 3.x, you should remove references to `EntityType` in your managed objects. The `EntityType` protocol is now automatically generated for each managed object class by the `cdqi` tool (formerly the `mocdqi` tool), as it should have been from the start.

CDQI now includes type-safe comparisons, which could cause some `filter` expressions to fail to compile. Assuming the code is correctly written, this should be very rare.

Lastly, CDQI no longer throws catchable errors. It is no longer necessary to use `try` when executing CDQI queries. This is discussed in more detail below.

#### What's New

##### Type Safety

Thanks to some help from Pat Goley, CDQI 4.0 now supports type-safe filter predicates.

```swift
moc.from(Employee).filter{ $0.firstName == 3 }
```

Previous versions of CDQI would happily have accepted such a filter comparison. Except in the unlikely event that you have not defined `firstName` as a `string` attribute in Core Data, the code above will not even compile in CDQI 4.0. For a more detailed discussion of type safety, see the Usage section below.

##### No More Trying, Only Doing

At its core, CDQI is a framework that creates and executes `NSFetchRequest`s using a fluent syntax. Core Data can throw errors as a result of executing fetch requests, and previous versions of CDQI dutifully presented these to the developer, e.g.,

```swift
do {
  let jonesCount = try moc.from(Employee).filter{ $0.lastName == "Jones" }.count()
} catch let e {
  // Now what?
}
```

The vast majority of errors encountered in this scenario are simply not recoverable. They are a result of programmer error, such as an improperly constructed predicate, and not user error. These will be caught by the developer the first time any attempt is made to execute the query.

CDQI does not swallow these silently. It simply blows up. Fix the bad predicate—because that is what it almost always is—and you are on your way.

If you _really_ want to catch these errors, there is a straightforward solution. Use CDQI to generate the fetch request, and then execute it the old fashioned way:

```swift
let request = EntityQuery.from(Employee).filter{ $0.lastName == "Jones" }.request()
do {
  let joneses = try moc.executeFetchRequest(request)
} catch let e {
  // Handle it here, if you can
}
```

### Integration

CDQI works its magic by creating proxy objects for each entity in your model, and then associating them with the corresponding entity via a `typealias`. A tool in the `bin` folder of the project called `cdqi` will create the proxies and associate them for you.

```swift
// All of the code below is automatically generated by the cdqi tool.

class DepartmentAttribute: Attribute, Aggregable {
    private(set) lazy var name: KeyAttribute = { KeyAttribute("name", parent: self) }()
    private(set) lazy var employees: EmployeeAttribute = { EmployeeAttribute("employees", parent: self) }()
}

// This assumes you have a managed object called Department.
extension Department: EntityType {
    typealias EntityAttributeType = DepartmentAttribute
}

```

Here are some examples of the use of `cdqi`:

```sh
# This generates proxies for entities in the Company data model.
# The current directory and all subdirectories are recursively searched
# until the Company data model is found.
cdqi Company

# Same as above, but ignores the Employee entity wherever it occurs.
# You should use the name of the entity here, not the represented class. (See below.)
cdqi -xEmployee Company

# By default, the tool won't overwrite an existing file. You can fix this with -f.
cdqi -f Company

# By default, the tool places output files next to the data model file.
# You can change this easily with --out.
cdqi --out=~/Desktop -f Company

# You can tell cdqi to start searching in any arbitrary folder with --in.
cdqi --in=~/Projects/FooBar --out=~/Desktop -xStudent School

# If you like all your proxies in one file, it can be done with -m.
cdqi -m School

# If you only want to write one entity to the output, use -w.
# This can be useful if only one entity has changed and the proxy
# for it needs to be regenerated.
# Be careful, though, this does not play well with -m.
# -w is not the inverse of -x. -w still assumes that other
# entities will not be excluded, so if those proxies are
# not also created, there could be compilation errors.
cdqi -wDepartment Company

# You can use -w multiple times to only write those particular entities.
cdqi -wDepartment -wEmployee Company

# You can also combine -x and -w.
# This writes out only the Department entity, but excludes
# any references to the Employee entity.
cdqi -xEmployee -wDepartment Company

# You can make the generated classes (and properties) public
# using -p
cdqi -p Company
```

Core Data models can have multiple versions. The `cdqi` tool always uses the current version, which it determines by consulting the `.xccurrentversion` file inside the `.xcdatamodeld` bundle.

For obvious reasons, `cdqi` uses the _represented class_, not the name of the entity, when generating proxies. If an entity has no represented class, it will be skipped, and a warning issued on the command line.

For further help on `cdqi`, issue `/path/to/cdqi --help` on the command line.

Use of proxies is optional. If you don't use proxies, CDQI still greatly reduces the amount of code you have to write, but unfortunately you will have to use magic strings. Use of the `cdqi` tool is optional. It's just a simple code-generation tool. You can hand-code your proxies if you like. They really aren't that difficult.

#### NSManagedObjectContext Integration

If you implement the `ManagedObjectContextType` protocol on `NSManagedObjectContext`, CDQI will add some useful extension methods, such as `from`. I highly recommend this, but it is optional. You can put this code anywhere in your project.

```swift
extension NSManagedObjectContext: ManagedObjectContextType {}
```

### Usage

See the unit tests for many useful usage examples. All examples assume a prior familiarity with Core Data and `NSPredicate`.

#### Starting a Query

All Core Data queries are relative to a specific entity. If you implement the `ManagedObjectContextType` protocol on `NSManagedObjectContext` (as discussed above), you can use the `from` method to start a query and specify the entity:

```swift
moc.from(Employee)
```

Without `ManagedObjectContextType`, you can start a query as follows, but you will have to specify a managed object context when the query is executed:

```swift
EntityQuery.from(Department)
```

Going forward, we will assume you have implemented `ManagedObjectContextType` on `NSManagedObjectContext`.

#### Proxies & Predicates

The generated proxy classes all descend ultimately from `Attribute`. This class has various methods and operators whose purpose is to generate keypath expressions and predicates.

```swift
let department = DepartmentAttribute()
let predicate: NSPredicate = department.name == "Engineering"
```

This is functionally equivalent to the following:

```swift
let predicate = NSPredicate(format: "name == %@", "Engineering")
```

Many complex keypaths and predicates can be generated:

```swift
let department = DepartmentAttribute()

// These two lines are functionally equivalent.
let predicate: NSPredicate = any(department.employees.name.beginsWith("s", .CaseInsensitivePredicateOption))
let predicate = NSPredicate(format: "ANY employees.name BEGINSWITH[c] %@", "s")

let predicate: NSPredicate = department.employees.subquery({any($0.name == "Smith")}).count > 0
let predicate = NSPredicate(format: "SUBQUERY(employees, $e, ANY $e.name == %@).@count > 0", "Smith")

let predicate: NSPredicate = department.name == "Engineering" || department.name == "Accounting"
let predicate = NSPredicate(format: "(name == %@) || (name == %@)", "Engineering", "Accounting")
```

In most cases, the operators and methods are exactly what you would expect. For instance, `ENDSWITH` is represented by the `endsWith` method. `NSPredicate` operators are represented by corresponding Swift operators. The only exception is `IN`, which is a reserved word in Swift and so cannot be used. Instead, it is represented by the `among` method:

```swift
department.name.among(["Engineering", "Sales"], .CaseInsensitivePredicateOption)
```

These capabilities of `Attribute` and its descendants are what lie at the heart of CDQI. Most types of predicates (even nested subqueries!) can be generated with this technique and without magic strings. For more examples, see the code itself and especially the unit tests.

#### Filtering

Unsurprisingly, CDQI's `filter` method makes extensive use of the capabilities of the `Attribute` class described in the previous section. In the most common case, the `filter` method takes a block which is passed an `Attribute` subclass and returns an instance of `NSPredicate`:

```swift
moc.from(Department).filter {department in department.name == "Engineering"}
```

CDQI knows which proxy class to pass because of the association made by the `cdqi` tool. As a reminder:

```swift
extension Department: EntityType {
  typealias EntityAttributeType = DepartmentAttribute
}
```

Because we passed `Department` to the `from` method, CDQI knows that any filter methods will have to be passed an instance of `DepartmentAttribute`, so it automatically creates one and passes it. We can then use it to generate predicates without magic strings.

The `filter` method has an overload that takes a plain `NSPredicate`, which we can generate with `Attribute` expressions. So if you're not a fan of curly braces, you can do the following:

```swift
let department = DepartmentAttribute()
moc.from(Department).filter(department.name == "Engineering")
```

If you find all this too magical, another kind of magic is available:

```swift
moc.from(Department).filter("name == %@", "Engineering")
```

Chaining filter methods together is the same as if `&&` were written between the predicates, e.g.,

```swift
// The following two statements are functionally equivalent
moc.from(Department).filter {department in department.name.beginsWith("E") && department.name.endsWith("ng")}
moc.from(Department)
    .filter {department in department.name.beginsWith("E")}
    .filter {department in department.name.endsWith("ng")}
```

As always, see the unit tests for more examples.

##### Type Safety

Filter comparisons using block syntax enforce compile-time type safety. When attribute proxies are generated, the `cdqi` tool assigns a CDQI attribute class based on the underlying Core Data attribute type. In other words, if `lastName` is a `string` in CoreData, it will become a `StringAttribute` in the proxy class. And since `StringAttribute`s can only be compared to strings (or other `StringAttributes`s), we have type safety.

```swift
class EmployeeAttribute: EntityAttribute, Aggregable {
    private(set) lazy var firstName: StringAttribute = { StringAttribute("firstName", parent: self) }()
    private(set) lazy var lastName: StringAttribute = { StringAttribute("lastName", parent: self) }()
    private(set) lazy var nickName: StringAttribute = { StringAttribute("nickName", parent: self) }()
    private(set) lazy var salary: NumericAttribute = { NumericAttribute("salary", parent: self, type: .Integer32AttributeType) }()
    private(set) lazy var department: DepartmentAttribute = { DepartmentAttribute("department", parent: self) }()
}
```

In keeping with what is permitted by Core Data, numeric comparisons are much looser than what Swift itself allows for "ordinary" numeric comparisons. Any numeric type or attribute can be compared to any other:

```swift
moc.filter{ $0.int32 == 41.5 }
```

The comparison of an `Int32` and a `Double` will not compile in Swift, but is permitted by CDQI. (This is because CDQI is not actually comparing an `Int32` and a `Double`. Instead, it is comparing a `NumericAttribute` with a `Double`.)

#### Sorting

Sorting makes use of `Attribute`'s ability to generate keypaths, e.g.,

```swift
moc.from(Department).order({$0.lastName})
```

Just as with filtering, `$0` is an instance of the associated proxy `Attribute` subclass, in this case `DepartmentAttribute`.

If we want to sort descending, it's pretty simple.

```swift
moc.from(Department).order(descending: {department in department.lastName})
```

Just as filtering ultimately involves creating instances of `NSPredicate`, our sort expressions built with `Attribute` subclasses will ultimately create `NSSortDescriptor` instances. In the case of sorting, we are not creating sort descriptors directly, but indirectly. Our blocks and other expressions return strings containing keypaths, which are then converted to the appropriate ascending or descending sort descriptor depending upon which overload of `order` is used.

Despite this, we can always use `NSSortDescriptor` directly if we wish:

```swift
moc.from(Department).order(sortDescriptor1, sortDescriptor2)
```

And strings:

```swift
moc.from(Department).order(descending: "manager.name").order("name")
```

This last shows that `order` can be chained as well, and the effects are cumulative, as one would expect.

#### Projection

In vanilla Core Data, it's possible to return an array of dictionaries instead of managed objects. CDQI can do the same. Simply use the `select` method and the query type will automatically be changed.

```swift
let department = DepartmentAttribute()
moc.from(Department).select(department.name, department.employees.average.salary).groupBy(department.name)
```

It's also possible to do this by starting with `ExpressionQuery`:

```swift
let department = DepartmentAttribute()
ExpressionQuery.from(Department)
```

In this case, since no managed object context has been specified, it will have to be passed when executing the query.

#### Executing Queries

There are several query execution methods. I'll deal with each in turn, starting with `all`.

```swift
moc.from(Department).filter {$0.name == "Engineering"}.all()
```

Very simply, this returns all managed objects of the appropriate type—`Department` in this case—which satisfy the query.

For a query that did not start with a managed object context, it can be passed as the first parameter to `all`.

```swift
EntityQuery.from(Department).order({$0.name}).all(moc)
```

As shown in the example above, all of the query execution methods take an optional `NSManagedObjectContext` as a parameter (though it isn't always the first parameter), so I won't show further examples of that.

Next up is `count`, which works as advertised:

```swift
let departmentCount = moc.from(Department).filter{$0.employees.count > 10}.count()
```

The `first` method returns either the first matching result or `nil`.

```swift
let department = moc.from(Department).first()!
```

Obviously if there are no departments, we'll get a runtime exception, so I don't recommend force-unwrapping the optional returned by `first` unless you're very certain.

The `array` query execution method is best demonstrated by example:

```swift
let names: [String] = moc.from(Department).array {$0.name}
```

This returns an array of department names. Because it can only return a _single_ attribute of an entity, any previous `select`s are ignored. You must give the compiler enough type evidence to know what to cast its result to, which is why `[String]` was specified explicitly.

`value` is to `array` what `first` is to `all`. In other words, it returns the first matching attribute value.

```swift
let name: String = moc.from(Department).filter({none($0.employees.salary < 40000)}).value({$0.name})!
```

Like `first`, `value` returns `nil` if there was no matching value. Like `array`, it supercedes any prior `select`s and requires type evidence to know what to cast its value to.

#### Limits

```swift
moc.from(Department).filter{$0.name.contains("e")}.limit(2)
```

Pretty obvious.

#### Fetch Requests

Sometimes we don't want to execute a query, but instead get the `NSFetchRequest` that would be generated. This is especially useful with `NSFetchedResultsController`. Doing so is very straightforward in CDQI:

```swift
let request = moc.from(Department).filter{$0.manager.lastName == "Smith"}.request()
```

We can then use this fetch request however we like.

#### Query Reuse

Under the hood, CDQI uses value types to avoid side effects. This means that queries can be reused:

```swift
let departmentQuery = moc.from(Department) // This is an instance of EntityQuery<Department>
let filteredDepartmentQuery = departmentQuery.filter { $0.manager.salary > 100000 }
let sortedFilteredDepartmentQuery = filteredDepartmentQuery.order(descending: {$0.name})
```

Each of these queries was built from the one before it, but each subsequent query has no side effects on the previous ones. The only drawback here is that we are also storing a reference to our managed object context. This can be avoided by starting with `EntityQuery` instead of the context.

```swift
let departmentQuery = EntityQuery.from(Department) // This is an instance of EntityQuery<Department>
let filteredDepartmentQuery = departmentQuery.filter() { $0.manager.salary > 100000 }
let sortedFilteredDepartmentQuery = filteredDepartmentQuery.order(descending: {$0.name})
```

Since no managed object context is associated with these queries, we have to specify one when they are executed, either by passing an instance of `NSManagedObjectContext` to the query execution method or using the `context` method:

```swift
sortedFilteredDepartmentQuery.all(moc)
sortedFilteredDepartmentQuery.context(moc).all()
```

This capability allows us to store frequently used queries for reuse, perhaps as static variables on a class, e.g.,

```swift
class DepartmentQueries {
  static let AllDepartments = EntityQuery.from(Department)
}
```

#### Questions / Concerns / Bugs

If you have any questions, concerns, or bugs, please open an [issue](https://github.com/Prosumma/CoreDataQueryInterface/issues) or submit a pull request.
