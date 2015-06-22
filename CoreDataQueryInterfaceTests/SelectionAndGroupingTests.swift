//
//  SelectionTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation
import XCTest

class SelectionTests : BaseTestCase {
 
    func testSelection() {
        let salary: NSNumber = try! managedObjectContext.from(Employee).order(descending: {$0.salary}).value({$0.salary})!
        XCTAssertEqual(salary.integerValue, 100_000)
    }
    
    func testMaximumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result = try! managedObjectContext.from(Employee).groupBy(employee.department.name).select(employee.department.name).max(employee.salary).order(descending: employee.department.name).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["departmentName"]! as! String, ($0["maxSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 97000)
        XCTAssertEqual(salaries["Engineering"]!, 100000)
        XCTAssertEqual(salaries["Sales"]!, 93000)
    }
    
    func testAverageSalaryGroupedByDepartment() {
        let result = try! managedObjectContext.from(Employee).groupBy({$0.department.name}).select({$0.department.name}).average({$0.salary}).order(descending: {$0.department.name}).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["departmentName"]! as! String, ($0["averageSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 73750)
        XCTAssertEqual(salaries["Engineering"]!, 75625)
        XCTAssertEqual(salaries["Sales"]!, 75111)
    }
    
    func testDistinctArray() {
        let query = managedObjectContext.from(Employee).order({$0.salary})
        let distinctSalaries: [Int] = try! query.distinct().array({$0.salary})
        XCTAssertEqual(distinctSalaries.count, 22)
        let salaries: [Int] = try! query.array({$0.salary})
        XCTAssertEqual(salaries.count, 25)
        XCTAssertNotEqual(distinctSalaries, salaries)
    }
}