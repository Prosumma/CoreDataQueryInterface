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
import Foundation
import XCTest

class SelectionTests : BaseTestCase {
 
    func testSelection() {
        let salary: NSNumber = try! managedObjectContext.from(Employee.self).order(ascending: false, {$0.salary}).value({$0.salary})!
        XCTAssertEqual(salary.intValue, 100_000)
    }
    
    func testMaximumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result = try! managedObjectContext.from(Employee).groupBy(employee.department.name).select(employee.department.name, employee.salary.cdqiMax()).order(ascending: false, employee.department.name).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["department.name"]! as! String, ($0["maxSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 97000)
        XCTAssertEqual(salaries["Engineering"]!, 100000)
        XCTAssertEqual(salaries["Sales"]!, 93000)
    }
    
    func testMinimumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result = managedObjectContext.from(Employee).groupBy(employee.department.name).select(employee.department.name, employee.min.salary.named("minSalary")).order(ascending: false, employee.department.name).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["department.name"]! as! String, ($0["minSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 32000)
        XCTAssertEqual(salaries["Engineering"]!, 54000)
        XCTAssertEqual(salaries["Sales"]!, 62000)
    }
    
    func testAverageSalaryGroupedByDepartment() {
        let result = managedObjectContext.from(Employee).groupBy({$0.department.name}).select({$0.department.name}, {$0.average.salary.named("averageSalary")}).order(ascending: false, {$0.department.name}).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["department.name"]! as! String, ($0["averageSalary"]! as! NSNumber).integerValue) }
        XCTAssertEqual(salaries["Accounting"]!, 71000)
        XCTAssertEqual(salaries["Engineering"]!, 75625)
        XCTAssertEqual(salaries["Sales"]!, 75111)
    }
    
    func testDistinctArray() {
        let query = managedObjectContext.from(Employee.self).order{ $0.salary }
        let distinctSalaries: [Int] = query.distinct().array({$0.salary})
        XCTAssertEqual(distinctSalaries.count, 23)
        let salaries: [Int] = query.array({$0.salary})
        XCTAssertEqual(salaries.count, 25)
        XCTAssertNotEqual(distinctSalaries, salaries)
    }
    
    func testThatThereExistsAnEmployeeNamedIsabella() {
        let employee = Employee.EntityAttributeType()
        let query = managedObjectContext.from(Employee).filter(employee.firstName.equalTo("Isabella", options: .CaseInsensitivePredicateOption))
        XCTAssertTrue(query.exists())
    }
    
    func testReselection() {
        let employee = Employee.EntityAttributeType()
        let query = managedObjectContext.from(Employee).select(employee.lastName).order(descending: employee.firstName)
        let employees = query.reselect().select(employee.firstName).all()
        let firstName = employees.first!["firstName"]! as! String
        XCTAssertEqual(firstName, "Lana")
    }
    
    func testStringAsSelectionProperty() {
        let result = managedObjectContext.from(Employee.self).groupBy("lastName").select("lastName").all()
        XCTAssertEqual(result.count, 5)
    }
    
    func testClosureAsSelectionProperty() {
        let result = managedObjectContext.from(Employee.self).groupBy("lastName").select({employee in [employee.lastName]}).all()
        XCTAssertEqual(result.count, 5)
    }
    
    func testMultipleGroupByProperty() {
        let result = managedObjectContext.from(Employee.self).groupBy({[$0.lastName, $0.department]}).select("lastName", "department").all()
        XCTAssertEqual(result.count, 13)
    }
    
    func testOrderByNSSortDescriptor() {
        let results = managedObjectContext.from(Employee.self).order(NSSortDescriptor(key: "firstName", ascending: true)).all()
        XCTAssert(results.first!.firstName == "David" && results.last!.firstName == "Lana")
    }
}

