![CoreDataQueryInterface](CoreDataQueryInterface.png)

[![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/CoreDataQueryInterface.svg)](https://cocoapods.org)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Core Data Query Interface (CDQI) is a type-safe, fluent, intuitive library for working with Core Data in Swift. CDQI tremendously reduces the amount of code needed to do Core Data, and dramatically improves readability by allowing method chaining and by eliminating magic strings. If you've worked with LINQ in the C# world, CDQI is a bit like LINQ.

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

- [x] [Fluent interface](http://en.wikipedia.org/wiki/Fluent_interface), i.e., chainable methods
- [x] Large number of useful overloads
- [x] Type-safety
- [x] Lazy execution
- [x] Three main query types: Entity, ManagedObjectID, and Dictionary (called "Expression" in CDQI)
- [x] Grouping, sorting, counts, etc.
- [x] Optionally eliminates the use of magic strings so common in Core Data
- [x] Query reuse, i.e., no side-effects from chaining
- [x] Support for iOS and OS X

## Requirements

- iOS 8.1+ / Mac OS X 10.9+
- Xcode 7.0+
- Swift 2.0+

### Integration

In order to use CoreDataQueryInterface with your models, they must implement the `EntityType` protocol:

```swift
class Department : NSManagedObject, EntityType {
  @NSManaged var name: String
}

class Employee : NSManagedObject, EntityType {
  @NSManaged var department: Department
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var salary: Int
}
```

#### Attributes

In order to use CoreDataQueryInterface's support for sorting, filtering, and the like without magic strings, you have to do a little more work. _This is completely optional but highly recommended._ (Don't despair. You can use the `mocdqi` tool detailed below to generate the attribute classes automatically.)

```swift
class Department : NSManagedObject, EntityType {
  // IMPORTANT: This is where you tell CDQI about the corresponding attribute type generated by the mocdqi tool.
  // Without this, queries without magic strings won't work.
  typealias EntityAttributeType = DepartmentAttribute
  @NSManaged var name: String
}

class DepartmentAttribute : Attribute {
  let name: AttributeType
  required init(name: String? = nil, parent: AttributeType? = nil) {
    super.init(name, parent: parent)
    name = Attribute("name", parent: self)
  }
}

class Employee : NSManagedObject, EntityType {
  // IMPORTANT: This is where you tell CDQI about the corresponding attribute type generated by the mocdqi tool.
  // Without this, queries without magic strings won't work.
  typealias EntityAttributeType = EmployeeAttribute
  @NSManaged var department: Department
  @NSManaged var firstName: String
  @NSManaged var lastName: String
  @NSManaged var salary: Int
}

class EmployeeAttribute : Attribute {
  let department: AttributeType
  let firstName: AttributeType
  let lastName: AttributeType
  let salary: AttributeType
  required init(name: String? = nil, parent: AttributeType? = nil) {
    super.init(name: parent: parent)
    department = DepartmentAttribute("department", parent: self)
    firstName = Attribute("firstName", parent: self)
    lastName = Attribute("lastName", parent: self)
    salary = Attribute("salary", parent: self)
  }
}
```

##### MOCDQI

A tool called `mocdqi` is available in the `bin` directory of the project to generate attribute classes. By default, it starts in the current directory and searches for the data model with the name specified. If it finds this data model, it generates a file for each model it finds and writes these files next to the data model package. For example:

```bash
cd MyAwesomeProject
/path/to/mocdqi MyAwesomeData
```

If `MyAwesomeData` contains two models called `Order` and `OrderItem`, `mocdqi` will generate `OrderAttribute.swift` and `OrderItemAttribute.swift`. If either of these files exist, `mocdqi` will refuse to overwrite them unless the `--force` option is passed. You can tell `mocdqi` to start in a diferent folder from the current one by using the `-i` or `--in` option, e.g.,

```bash
/path/to/mocdqi --in=~/Projects/MyAwesomeProject MyAwesomeData
```

If you want `mocdqi` to put the generated files into a different folder, specify `-o` or `--out`, e.g.,

```bash
/path/to/mocdqi --out=~/Desktop/ --in=~/Projects/MyAwesomeProject MyAwesomeData
```

You can create a single file with all the attributes using the `-m` or `--merged` option:

```bash
/path/to/mocdqi --out=~/Desktop/ --in=~/Projects/MyAwesomeProject --merged MyAwesomeData
```

This will generate a file called `MyAwesomeDataAttribute.swift`. By default, the generated class are not marked public. If you want to make them so, use `-p` or `--public`:

```bash
/path/to/mocdqi --public --merged MyAwesomeData
```

Lastly, you can exclude a particular entity by using the `-x` or `--exclude=` option. This option can be used multiple times.

```bash
/path/to/mocdqi --public --exclude=BadModel --exclude=TerribleEntity MyAwesomeData
```

If you do this, not only will these models be excluded, but also all relationship properties in other entities that reference them.

There are a few other minor options. Examine the source code to see them. The code is pretty straightforward.

### Usage

All of the examples in this section assume that the `mocdqi` tool has been used to generate attribute classes to eliminate the use of magic strings. To see more extensive examples, take a look at the unit tests.

#### Starting a Query

While there are other ways, the simplest way to start a query is to begin with an instance of `NSManagedObjectContext`, e.g.,

```swift
managedObjectContext.from(Employee)
```

The parameter passed to `from` is a type, specifically an `NSManagedObject` subclass that implements the `EntityType` protocol. 

#### Filtering

```swift
managedObjectContext.from(Employee).filter({ $0.department.name == "Engineering" && $0.salary < 70000 })
```

The parameter passed to the filter block `{ $0.department.name == "Engineering" && $0.salary < 70000 }` is an instance of `EmployeeAttribute`.

If multiple filters are chained together, the effect is as if `&&` was placed between them, e.g.,

```swift
managedObjectContext.from(Employee).filter({ $0.department.name == "Engineering" }).filter({ $0.salary < 70000 })
```

#### Ordering

```swift
managedObjectContext.from(Department).order({ $0.name })
managedObjectContext.from(Employee).order(descending: { $0.salary }).order({ $0.lastName })
```

As with filtering, the parameter passed to the block is an instance of `EmployeeAttribute`. Chained `order` methods work exactly as you would expect. There are several overloads that allow you to express the same thing in different ways, whatever is most convenient.

```swift
managedObjectContext.from(Employee).order({ $0.lastName }, { $0.firstName })
managedObjectContext.from(Employee).order({ [ $0.lastName, $0.firstName ] })
let employee = EmployeeAttribute()
managedObjectContext.from(Employee).order(employee.lastName, employee.firstName)
```

