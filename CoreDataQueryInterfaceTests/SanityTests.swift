/*
The MIT License (MIT)

Copyright (c) 2015 Gregory Higley (Prosumma)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import CoreData
@testable import CoreDataQueryInterface
import XCTest

class SanityTests: BaseTestCase {
    
    /**
     This test exists to ensure that our operator
     overloads don't conflict with Swift's built-ins.
     */
    func testThatComplexBooleansStillWork() {
        let x = 14
        XCTAssertTrue(x > 0 && x < 47 && !(x == 99))
    }
    
    func testImplicitBooleanPredicate() {
        var count = try! managedObjectContext.from(TestEntity.self).filter(TestEntity.e.boolean).count()
        XCTAssertEqual(count, 1)
        count = try! managedObjectContext.from(TestEntity.self).filter(TestEntity.e.boolean && true).count()
        XCTAssertEqual(count, 1)
    }
    
    func testImplicitBooleanPredicateNegation() {
        let count = try! managedObjectContext.from(TestEntity.self).filter(!TestEntity.e.boolean).count()
        XCTAssertEqual(count, 0)
    }
    
    func testCountDepartments() {
        let departmentCount = try! managedObjectContext.from(Department.self).count()
        XCTAssertEqual(departmentCount, 3)
    }
    
    func testCountEmployees() {
        let employeeCount = try! managedObjectContext.from(Employee.self).count()
        XCTAssertEqual(employeeCount, 25)
    }
        
}
