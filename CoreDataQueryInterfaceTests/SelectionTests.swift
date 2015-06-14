//
//  SelectionTests.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation
import XCTest

class SelectionTests : BaseTestCase {
 
    func testWatusi() {
        for row in managedObjectContext.from(Employee).select({employee in [Expression.keyPath(employee.department.name, name: "departmentName"), Expression.max(employee.salary)]}).groupBy({ $0.department.name }) {
            print(row)
        }
    }
    
}