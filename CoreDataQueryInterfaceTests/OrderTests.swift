//
//  OrderTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import XCTest

class OrderTests : BaseTestCase {
    
    func testFirstEmployeeInSalesOrderedDescendingByLastNameThenAscendingByFirstName() {
        let employee = try! managedObjectContext.from(Employee).filter({ employee in employee.department.name == "Sales" }).order(descending: {$0.lastName}).order({$0.firstName}).first()!
        XCTAssertEqual(employee.lastName, "Smith")
        XCTAssertEqual(employee.firstName, "David")
    }
    
    func testFirstEmployeeInAccountingOrderedByFirstNameThenLastName() {
        let employee = try! managedObjectContext.from(Employee).filter("department.name == %@", "Accounting").order("firstName", "lastName").first()!
        XCTAssertEqual(employee.lastName, "Morton")
        XCTAssertEqual(employee.firstName, "Gregory")
    }

}