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
 
    func testSelection() {
        let salary = try! managedObjectContext.from(Employee).order(descending: {$0.salary}).select({$0.salary}).value()! as NSNumber
        XCTAssertEqual(salary.integerValue, 100_000)
    }
    
    func testMaximumSalaryGroupedByDepartment() {
        let result = try! managedObjectContext.from(Employee).groupBy({$0.department.name}).select({e in [e.department.name, Expression.max(e.salary)]}).all()
        debugPrint(result)
    }
}