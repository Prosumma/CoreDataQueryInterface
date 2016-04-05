//
//  ManagedObjectContextTests.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 4/4/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import XCTest
import CoreData
@testable import CoreDataQueryInterface

class ManagedObjectContextTests: BaseTestCase {

    func testNewEntity() {
        let employee: Employee = managedObjectContext.newEntity()
        managedObjectContext.deleteObject(employee)
    }
    
    func testRequestWithMOC() {
        let request = EntityQuery.from(Employee).request(managedObjectContext)
        let employees = try! managedObjectContext.executeFetchRequest(request)
        XCTAssert(employees.count == 25)
    }
    
    func testRequestWithModel() {
        let request = EntityQuery.from(Employee).request(BaseTestCase.managedObjectModel)
        let employees = try! managedObjectContext.executeFetchRequest(request)
        XCTAssert(employees.count == 25)
    }
}
