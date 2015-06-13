//
//  File.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import XCTest

class FilterTests : BaseTestCase {

    func testCountEngineers() {
        let engineerCount = try! managedObjectContext.from(Employee).filter({ $0.department.name == "Engineering" }).count()
        XCTAssertEqual(engineerCount, 8)
    }
    
    func testCountEmployeesNamedSmith() {
        let smithCount = try! managedObjectContext.from(Employee).filter("lastName == %@", "Smith").count()
        XCTAssertEqual(smithCount, 5)
    }
    
    func testCountEmployeesWithoutNickName() {
        let nickNameLessCount = try! managedObjectContext.from(Employee).filter({ employee in employee.nickName == nil as String? }).count()
        XCTAssertEqual(nickNameLessCount, 10)
    }
    
    func testCountEmployeesNameNotMortonOrJones() {
        let notMortonOrJonesCount = try! managedObjectContext.from(Employee).filter({ $0.lastName != ["Morton", "Jones"] }).count()
        XCTAssertEqual(notMortonOrJonesCount, 15)
    }
    
    func testEmptyKeyRepresentsSelf() {
        let employeeQuery = managedObjectContext.from(Employee)
        let firstObjectID = try! employeeQuery.objectIDs().first()!
        // Since employee in the filter resolves to the empty string, it is treated as SELF in the query.
        let firstEmployee = try! employeeQuery.filter({ employee in employee == firstObjectID }).first()!
        XCTAssertEqual(firstObjectID, firstEmployee.objectID)
    }
}