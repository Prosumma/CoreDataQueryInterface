//
//  CoreDataQueryInterfaceTests.swift
//  CoreDataQueryInterfaceTests
//
//  Created by Gregory Higley on 6/11/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
@testable import CoreDataQueryInterface
import XCTest

class SanityTests: BaseTestCase {
    
    func testCountDepartments() {
        let departmentCount = managedObjectContext.from(Department).count()
        XCTAssertEqual(departmentCount, 3)
    }
    
    func testCountEmployees() {
        let employeeCount = managedObjectContext.from(Employee).count()
        XCTAssertEqual(employeeCount, 25)
    }
        
}
