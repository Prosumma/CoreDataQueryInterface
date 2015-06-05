//
//  OrderTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/5/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import XCTest

/**
    All of these tests ultimately call the overload of `order` with `NSSortDescriptor`,
    so there is no need to test it directly.
 */
class OrderTests: BaseTestCase {

    func testOrderAscendingWithStrings() {
        let firstDepartmentName = "Accounting"
        if let departmentName = managedObjectContext.from(Department).select("name").order("name").value() as String? {
            XCTAssertEqual(departmentName, firstDepartmentName, "departmentName should be \(firstDepartmentName), but was \(departmentName)")
        } else {
            XCTFail("departmentName should not be nil")
        }
    }
    
    func testOrderDescendingWithStrings() {
        let lastDepartmentName = "Sales"
        if let departmentName = managedObjectContext.from(Department).select("name").order(descending: "name").value() as String? {
            XCTAssertEqual(departmentName, lastDepartmentName, "departmentName should be \(lastDepartmentName), but was \(departmentName)")
        } else {
            XCTFail("departmentName should not be nil")
        }
    }
    
    func testOrderAscendingWithAttributes() {
        let firstDepartmentName = "Accounting"
        if let departmentName = managedObjectContext.from(Department).select({$0.name}).order({$0.name}).value() as String? {
            XCTAssertEqual(departmentName, firstDepartmentName, "departmentName should be \(firstDepartmentName), but was \(departmentName)")
        } else {
            XCTFail("departmentName should not be nil")
        }
    }

    func testOrderDescendingWithAttributes() {
        let lastDepartmentName = "Sales"
        if let departmentName = managedObjectContext.from(Department).select({$0.name}).order(descending: {$0.name}).value() as String? {
            XCTAssertEqual(departmentName, lastDepartmentName, "departmentName should be \(lastDepartmentName), but was \(departmentName)")
        } else {
            XCTFail("departmentName should not be nil")
        }
    }
    
}
