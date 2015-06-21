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
        print(result)
    }
    
    func testDistinctArray() {
        let salaries: [Int] = try! managedObjectContext.from(Employee).distinct().array({$0.salary})
        XCTAssertEqual(salaries.count, 22)
    }
}