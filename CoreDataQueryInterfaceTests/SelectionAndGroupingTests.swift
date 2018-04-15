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
        let salary: NSNumber = try! managedObjectContext.from(Employee.self).orderDesc{$0.salary}.value({$0.salary})!
        XCTAssertEqual(salary.intValue, 100_000)
    }
    
    func testMaximumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result = try! managedObjectContext.from(Employee.self).group(by: employee.department.name).select(employee.department.name, employee.salary.cdqiMax).orderDesc(by: employee.department.name).all()
        print(result)
        let salaries: [String: Int] = result.toDictionary() { ($0["departmentName"]! as! String, ($0["salaryMax"]! as! NSNumber).intValue) }
        XCTAssertEqual(salaries["Accounting"]!, 97000)
        XCTAssertEqual(salaries["Engineering"]!, 100000)
        XCTAssertEqual(salaries["Sales"]!, 93000)
    }
    
    func testMinimumSalaryGroupedByDepartment() {
        let employee = EmployeeAttribute()
        let result = try! managedObjectContext.from(Employee.self).group(by: employee.department.name).select(employee.department.name, employee.salary.cdqiMin).orderDesc(by: employee.department.name).all()
        let salaries: [String: Int] = result.toDictionary() { ($0["departmentName"]! as! String, ($0["salaryMin"]! as! NSNumber).intValue) }
        XCTAssertEqual(salaries["Accounting"]!, 32000)
        XCTAssertEqual(salaries["Engineering"]!, 54000)
        XCTAssertEqual(salaries["Sales"]!, 62000)
    }
    
    func testAverageSalaryGroupedByDepartment() {
        let result = try! managedObjectContext.from(Employee.self).group{$0.department.name}.select({$0.department.name}, {$0.salary.cdqiAverage}).orderDesc{$0.department.name}.all()
        let salaries: [String: Int] = result.toDictionary() { ($0["departmentName"]! as! String, ($0["salaryAverage"]! as! NSNumber).intValue) }
        XCTAssertEqual(salaries["Accounting"]!, 71000)
        XCTAssertEqual(salaries["Engineering"]!, 75625)
        XCTAssertEqual(salaries["Sales"]!, 75111)
    }
    
    func testDistinctArray() {
        let query = managedObjectContext.from(Employee.self).order{$0.salary}
        let distinctSalaries: [Int] = try! query.distinct().array({$0.salary}, type: Int.self)
        XCTAssertEqual(distinctSalaries.count, 23)
        let salaries: [Int] = try! query.array({$0.salary}, type: Int.self)
        XCTAssertEqual(salaries.count, 25)
        XCTAssertNotEqual(distinctSalaries, salaries)
    }
    
    func testThatThereExistsAnEmployeeNamedIsabella() {
        let employee = Employee.CDQIEntityAttribute()
        let query = managedObjectContext.from(Employee.self).filter(employee.firstName.cdqiEqualTo("Isabella", options: []))
        XCTAssertTrue(try! query.exists())
    }
    
    func testReselection() {
        let employee = Employee.CDQIEntityAttribute()
        let query = managedObjectContext.from(Employee.self).select(employee.lastName).orderDesc(by: employee.firstName)
        let employees = try! query.dictionary().reselect().select(employee.firstName).all()
        let firstName = employees.first!["firstName"]! as! String
        XCTAssertEqual(firstName, "Lana")
    }
    
    func testClosureAsSelectionProperty() {
        let result = try! managedObjectContext.from(Employee.self).group(by: {$0.lastName}).select({employee in [employee.lastName]}).all()
        XCTAssertEqual(result.count, 5)
    }
    
    func testMultipleGroupByProperty() {
        let result = try! managedObjectContext.from(Employee.self).group{[$0.lastName, $0.department]}.select({$0.lastName},{$0.department}).all()
        XCTAssertEqual(result.count, 13)
    }
    
    func testOrderByNSSortDescriptor() {
        let results = try! managedObjectContext.from(Employee.self).order(by: NSSortDescriptor(key: "firstName", ascending: true)).all()
        XCTAssert(results.first!.firstName == "David" && results.last!.firstName == "Lana")
    }
}

