//
//  FilterTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/5/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import XCTest

/**
    All tests ultimately call the overload of `filter` with `NSPredicate`,
    so there is no need to test it directly.
 */
class FilterTests: BaseTestCase {

    func testStringFilter() {
        let query = EntityQuery.from(Employee).filter("department.name == %@", "Accounting")
        if let accountingEmployeesCount = query.count(managedObjectContext: BaseTestCase.managedObjectContext) {
            XCTAssertEqual(accountingEmployeesCount, 8, "accountingEmployeesCount should be 8, but was \(accountingEmployeesCount)")
        } else {
            XCTFail("accountingEmployeesCount should not be nil")
        }
    }
    
    func testAttributeEqualityFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter({ employee in employee.department.name == "Engineering" })
        if let engineeringEmployeeCount = query.count() {
            XCTAssertEqual(engineeringEmployeeCount, 8, "engineeringEmployeeCount should be 8, but was \(engineeringEmployeeCount)")
        } else {
            XCTFail("engineeringEmployeeCount should not be nil")
        }
    }
    
}
