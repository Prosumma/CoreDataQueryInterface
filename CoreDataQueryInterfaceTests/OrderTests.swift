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
