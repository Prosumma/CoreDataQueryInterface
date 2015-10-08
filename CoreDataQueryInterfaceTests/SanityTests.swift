//
//  CoreDataQueryInterfaceTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 6/11/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import XCTest

class SanityTests: BaseTestCase {
    
    func testCountDepartments() {
        let departmentCount = try! managedObjectContext.from(Department).count()
        XCTAssertEqual(departmentCount, 3)
    }
    
    func testCountEmployees() {
        let employeeCount = try! managedObjectContext.from(Employee).count()
        XCTAssertEqual(employeeCount, 25)
    }
        
}
