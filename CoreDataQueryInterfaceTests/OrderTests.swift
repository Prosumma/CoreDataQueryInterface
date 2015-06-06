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
    
    func testOrderAscendingWithMultipleStrings() {
        let employeeLastName = "Davies"
        let employeeDepartmentName = "Accounting"
        if let employee = managedObjectContext.from(Employee).order("lastName", "department.name").first() {
            XCTAssertEqual(employee.lastName, employeeLastName, "employee.lastName should be \(employeeLastName), but was \(employee.lastName)")
            XCTAssertEqual(employee.department.name, employeeDepartmentName, "employee.department.name should be \(employeeDepartmentName), but was \(employee.department.name)")
        } else {
            XCTFail("employee should not be nil")
        }
    }
    
    func testOrderDescendingWithMultipleStrings() {
        let employeeLastName = "Smith"
        let employeeDepartmentName = "Sales"
        if let employee = managedObjectContext.from(Employee).order(descending: "lastName", "department.name").first() {
            XCTAssertEqual(employee.lastName, employeeLastName, "employee.lastName should be \(employeeLastName), but was \(employee.lastName)")
            XCTAssertEqual(employee.department.name, employeeDepartmentName, "employee.department.name should be \(employeeDepartmentName), but was \(employee.department.name)")
        } else {
            XCTFail("employee should not be nil")
        }
    }
    
    func testOrderAscendingWithMultipleAttributes() {
        let employeeLastName = "Davies"
        let employeeDepartmentName = "Accounting"
        // Compare {e in [e.lastName, e.department.name]} to the syntax used in testOrderDescendingWithMultipleAttributes.
        // BOTH syntaxes are valid. Which you use is up to you.
        if let employee = managedObjectContext.from(Employee).order({e in [e.lastName, e.department.name]}).first() {
            XCTAssertEqual(employee.lastName, employeeLastName, "employee.lastName should be \(employeeLastName), but was \(employee.lastName)")
            XCTAssertEqual(employee.department.name, employeeDepartmentName, "employee.department.name should be \(employeeDepartmentName), but was \(employee.department.name)")
        } else {
            XCTFail("employee should not be nil")
        }
    }
    
    func testOrderDescendingWithMultipleAttributes() {
        let employeeLastName = "Smith"
        let employeeDepartmentName = "Sales"
        // Compare {$0.lastName}, {$0.department.name} to the syntax used in testOrderAscendingWithMultipleAttributes.
        // BOTH syntaxes are valid. Which you use is up to you.
        if let employee = managedObjectContext.from(Employee).order(descending: {$0.lastName}, {$0.department.name}).first() {
            XCTAssertEqual(employee.lastName, employeeLastName, "employee.lastName should be \(employeeLastName), but was \(employee.lastName)")
            XCTAssertEqual(employee.department.name, employeeDepartmentName, "employee.department.name should be \(employeeDepartmentName), but was \(employee.department.name)")
        } else {
            XCTFail("employee should not be nil")
        }
    }
    
    func testOrderChainedWithStringsAndAttributes() {
        let employeeLastName = "Davies"
        let employeeFirstName = "Jane"
        let employeeDepartmentName = "Sales"
        if let employee = managedObjectContext.from(Employee).order(descending: {$0.department.name}).order("lastName").order(descending: {e in e.firstName}).first() {
            XCTAssertEqual(employee.department.name, employeeDepartmentName, "employee.department.name should be \(employeeDepartmentName), but was \(employee.department.name)")
            XCTAssertEqual(employee.lastName, employeeLastName, "employee.lastName should be \(employeeLastName), but was \(employee.lastName)")
            XCTAssertEqual(employee.firstName, employeeFirstName, "employee.firstName should be \(employeeFirstName), but was \(employee.firstName)")
        } else {
            XCTFail("employee should not be nil")
        }
    }
    
}
