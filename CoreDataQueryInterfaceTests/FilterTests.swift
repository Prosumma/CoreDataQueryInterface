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
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() { employee in employee.department.name == "Engineering" }
        if let engineeringEmployeeCount = query.count() {
            XCTAssertEqual(engineeringEmployeeCount, 8, "engineeringEmployeeCount should be 8, but was \(engineeringEmployeeCount)")
        } else {
            XCTFail("engineeringEmployeeCount should not be nil")
        }
    }
    
    func testAttributeInequalityFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() {$0.lastName != "Smith"}
        if let nonSmithCount = query.count() {
            XCTAssertEqual(nonSmithCount, 20, "nonSmithCount should be 8, but was \(nonSmithCount)")
        } else {
            XCTFail("nonSmithCount should not be nil")
        }
    }
    
    func testAttributeGreaterThanFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() { employee in employee.salary > 75_000 }
        if let highlyPaidEmployeeCount = query.count() {
            XCTAssertEqual(highlyPaidEmployeeCount, 9, "highlyPaidEmployeeCount should be 9, but was \(highlyPaidEmployeeCount)")
        } else {
            XCTFail("highlyPaidEmployeeCount should not be nil")
        }
    }
    
    func testAttributeGreaterThanOrEqualFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() { employee in employee.salary >= 75_000 }
        if let highlyPaidEmployeeCount = query.count() {
            XCTAssertEqual(highlyPaidEmployeeCount, 11, "highlyPaidEmployeeCount should be 11, but was \(highlyPaidEmployeeCount)")
        } else {
            XCTFail("highlyPaidEmployeeCount should not be nil")
        }
    }
    
    func testAttributeLessThanFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() { employee in employee.salary < 75_000 }
        if let notSoHighlyPaidEmployeeCount = query.count() {
            XCTAssertEqual(notSoHighlyPaidEmployeeCount, 14, "highlyPaidEmployeeCount should be 14, but was \(notSoHighlyPaidEmployeeCount)")
        } else {
            XCTFail("highlyPaidEmployeeCount should not be nil")
        }
    }
    
    func testAttributeLessThanOrEqualFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() { employee in employee.salary <= 75_000 }
        if let notSoHighlyPaidEmployeeCount = query.count() {
            XCTAssertEqual(notSoHighlyPaidEmployeeCount, 16, "highlyPaidEmployeeCount should be 16, but was \(notSoHighlyPaidEmployeeCount)")
        } else {
            XCTFail("highlyPaidEmployeeCount should not be nil")
        }
    }
    
    func testCompoundPredicateFilter() {
        let query = BaseTestCase.managedObjectContext.from(Employee).filter() { $0.department.name == "Accounting" && ($0.lastName == "Davies" || $0.lastName == "Morton") }
        if let daviesOrMortonInAccountingCount = query.count() {
            XCTAssertEqual(daviesOrMortonInAccountingCount, 5, "daviesOrSmithsInAccountingCount should be 5, but was \(daviesOrMortonInAccountingCount)")
        } else {
            XCTFail("daviesOrSmithsInAccountingCount should not be nil")
        }
    }
    
}
