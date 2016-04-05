//
//  SelectionTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
@testable import CoreDataQueryInterface
import Foundation
import XCTest

class SelectionTests : BaseTestCase {
 
    func testSelection() {
        let salary: NSNumber = managedObjectContext.from(Employee).order(descending: {$0.salary}).value({$0.salary})!
        XCTAssertEqual(salary.integerValue, 100_000)
    }
    
    func testMaximumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result = managedObjectContext.from(Employee).groupBy(employee.department.name).select(employee.department.name, employee.max.salary.named("maxSalary")).order(descending: employee.department.name).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["department.name"]! as! String, ($0["maxSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 97000)
        XCTAssertEqual(salaries["Engineering"]!, 100000)
        XCTAssertEqual(salaries["Sales"]!, 93000)
    }
    
    func testMinimumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result =  managedObjectContext.from(Employee).groupBy(employee.department.name).select(employee.department.name, employee.min.salary.named("minSalary")).order(descending: employee.department.name).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["department.name"]! as! String, ($0["minSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 32000)
        XCTAssertEqual(salaries["Engineering"]!, 54000)
        XCTAssertEqual(salaries["Sales"]!, 62000)
    }
    
    func testAverageSalaryGroupedByDepartment() {
        let result = managedObjectContext.from(Employee).groupBy({$0.department.name}).select({$0.department.name}, {$0.average.salary.named("averageSalary")}).order(descending: {$0.department.name}).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["department.name"]! as! String, ($0["averageSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 71000)
        XCTAssertEqual(salaries["Engineering"]!, 75625)
        XCTAssertEqual(salaries["Sales"]!, 75111)
    }
    
    func testDistinctArray() {
        let query = managedObjectContext.from(Employee).order({$0.salary})
        let distinctSalaries: [Int] = query.distinct().array({$0.salary})
        XCTAssertEqual(distinctSalaries.count, 23)
        let salaries: [Int] = query.array({$0.salary})
        XCTAssertEqual(salaries.count, 25)
        XCTAssertNotEqual(distinctSalaries, salaries)
    }
    
    func testThatThereExistsAnEmployeeNamedIsabella() {
        let employee = Employee.EntityAttributeType()
        let query = managedObjectContext.from(Employee).filter(employee.firstName.equalTo("Isabella", options: .CaseInsensitivePredicateOption))
        XCTAssertTrue(query.exists())
    }
    
    func testReselection() {
        let employee = Employee.EntityAttributeType()
        let query = managedObjectContext.from(Employee).select(employee.lastName).order(descending: employee.firstName)
        let employees = query.reselect().select(employee.firstName).all()
        let firstName = employees.first!["firstName"]! as! String
        XCTAssertEqual(firstName, "Lana")
    }
    
    func testStringAsSelectionProperty() {
        let result =  managedObjectContext.from(Employee).groupBy("lastName").select("lastName").all()
        XCTAssertEqual(result.count, 5)
    }
    
    func testMultipleGroupByProperty() {
        let result =  managedObjectContext.from(Employee).groupBy({[$0.lastName, $0.department]}).select("lastName", "department").all()
        XCTAssertEqual(result.count, 13)
    }
    
    func testOrderByNSSortDescriptor() {
        let results =  managedObjectContext.from(Employee).order(NSSortDescriptor(key: "firstName", ascending: true)).all()
        XCTAssert(results.first!.firstName == "David" && results.last!.firstName == "Lana")
    }
}

