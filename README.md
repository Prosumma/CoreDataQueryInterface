![CoreDataQueryInterface](CoreDataQueryInterface.png)

<!-- [![Build Status](https://travis-ci.org/Prosumma/CoreDataQueryInterface.svg)](https://travis-ci.org/Prosumma/CoreDataQueryInterface) -->
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
- Xcode 6.4+

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

In order to use CoreDataQueryInterface's support for sorting, filtering, and the like without magic strings, you have to do a little more work. _This is completely optional but highly recommended._

```swift
class Department : NSManagedObject, EntityType {
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

A tool is in development to automatically generate these classes.
