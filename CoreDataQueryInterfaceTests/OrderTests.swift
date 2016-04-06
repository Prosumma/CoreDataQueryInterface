//
//  OrderTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

@testable import CoreDataQueryInterface
import Foundation
import XCTest

class OrderTests : BaseTestCase {
    
    func testFirstEmployeeInSalesOrderedDescendingByLastNameThenAscendingByFirstName() {
        let employee = managedObjectContext.from(Employee).filter({ (employee: EmployeeAttribute) -> NSPredicate in employee.department.name == "Sales" }).order(descending: {$0.lastName}).order({$0.firstName}).first()!
        XCTAssertEqual(employee.lastName, "Smith")
        XCTAssertEqual(employee.firstName, "David")
    }
    
    func testFirstEmployeeInAccountingOrderedByFirstNameThenLastName() {
        let employee = managedObjectContext.from(Employee).filter("department.name == %@", "Accounting").order("firstName", "lastName").first()!
        XCTAssertEqual(employee.lastName, "Morton")
        XCTAssertEqual(employee.firstName, "Gregory")
    }
    
    func testReorder() {
        let department = Department.EntityAttributeType()
        let query = managedObjectContext.from(Department).order(descending: department.name)
        let departmentName: String = query.reorder().order(department.name).value(department.name)!
        XCTAssertEqual(departmentName, "Accounting")
    }
    
    func testOffset() {
        let department = Department.EntityAttributeType()
        let secondDepartment = managedObjectContext.from(Department).order(department.name).offset(1).first()!
        XCTAssertEqual(secondDepartment.name, "Engineering")
    }
    
    func testMultipleOrderings() {
        let employees = managedObjectContext.from(Employee).order({employee in [employee.lastName, employee.firstName]}).all()
        XCTAssertEqual(employees.first!.firstName, "David")
        XCTAssertEqual(employees.last!.firstName, "Lana")
    }
    
    func testMultipleDescendingOrderings() {
        let employees = managedObjectContext.from(Employee).order(descending: {employee in [employee.lastName, employee.firstName]}).all()
        XCTAssertEqual(employees.first!.firstName, "Lana")
        XCTAssertEqual(employees.last!.firstName, "David")
    }
}