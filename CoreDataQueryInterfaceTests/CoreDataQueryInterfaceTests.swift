//
//  QueryTypeTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import XCTest

/*
Half tests, half examples.
*/
class CoreDataQueryInterfaceTests: XCTestCase {
    
    static var StartDateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    class func newEmployee(moc: NSManagedObjectContext, firstName: String, lastName: String, department: String, title: String, salary: Int32, startDate: String) {
        let employee = moc.newManagedObject(Employee)
        employee.firstName = firstName
        employee.lastName = lastName
        employee.department = department
        employee.title = title
        employee.salary = salary
        employee.startDate = CoreDataQueryInterfaceTests.StartDateFormatter.dateFromString(startDate)!
    }
    
    var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(inMemoryStoreWithConcurrencyType: .MainQueueConcurrencyType, error: nil)!
        CoreDataQueryInterfaceTests.newEmployee(managedObjectContext, firstName: "Bill", lastName: "Lumbergh", department: "Management", title: "Vice President", salary: 100000, startDate: "1989-01-20")
        CoreDataQueryInterfaceTests.newEmployee(managedObjectContext, firstName: "Peter", lastName: "Gibbons", department: "Engineering", title: "Programmer", salary: 40000, startDate: "1996-05-20")
        CoreDataQueryInterfaceTests.newEmployee(managedObjectContext, firstName: "Milton", lastName: "Waddams", department: "Administration", title: "Collator", salary: 0, startDate: "1989-01-20")
        managedObjectContext.save(nil)
        return managedObjectContext
    }()
    
    func testFilterChain() {
        let query = ExpressionQuery.from(Employee).filter("title == %@", "Programmer").filter("salary < 50000")
        XCTAssertEqual(query.count(managedObjectContext: managedObjectContext)!, 1, "Query should have returned 1 record.")
        XCTAssertEqual(query.select("lastName").context(managedObjectContext).value()!, "Gibbons", "Should have gotten Gibbons.")
    }
    
    func testOrderChain() {
        let query = managedObjectContext.from(Employee).order("startDate").order(descending: "salary")
        XCTAssertEqual(query.select("lastName").pluck()!, ["Lumbergh", "Waddams", "Gibbons"], "Order was incorrect.")
    }

    func testIteration() {
        var departments = [String]()
        for employee in managedObjectContext.from(Employee).order("lastName", "firstName") {
            departments.append(employee.department)
        }
        XCTAssertEqual(departments, ["Engineering", "Management", "Administration"], "Departments were incorrect.")
    }
    
}
