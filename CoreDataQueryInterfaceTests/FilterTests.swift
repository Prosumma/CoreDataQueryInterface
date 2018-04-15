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
import XCTest

class FilterTests : BaseTestCase {

    func testCountEngineers() {
        let engineerCount = try! managedObjectContext.from(Employee.self).filter{ $0.department.name == "Engineering" }.count()
        XCTAssertEqual(engineerCount, 8)
    }
    
    func testCountEmployeesWithoutNickName() {
        let nickNameLessCount = try! managedObjectContext.from(Employee.self).filter{ employee in employee.nickName == nil }.count()
        XCTAssertEqual(nickNameLessCount, 10)
    }
    
    func testCountEmployeesWithLastNameNotJones() {
        let nickNameLessCount = try! managedObjectContext.from(Employee.self).filter{ employee in employee.lastName != "Jones" }.count()
        XCTAssertEqual(nickNameLessCount, 20)
    }
    
    func testEmployeesWithNickName() {
        let nickNameLessCount = try! managedObjectContext.from(Employee.self).filter{ employee in employee.nickName != nil }.count()
        XCTAssertEqual(nickNameLessCount, 15)
    }
    
    func testCountEmployeesNameNotMortonOrJones() {
        let names = ["Morton", "Jones"]
        let notMortonOrJonesCount = try! managedObjectContext.from(Employee.self).filter{ $0.lastName != names }.count()
        XCTAssertEqual(notMortonOrJonesCount, 15)
    }
    
    func testCountEmployeesWithNameLike() {
        let count = try! managedObjectContext.from(Employee.self).filter(Employee.cdqi.lastName =* "*nes").count()
        XCTAssertEqual(count, 5)
    }
    
    func testEmptyKeyRepresentsSelf() {
        let employeeQuery = managedObjectContext.from(Employee.self)
        let firstObjectID = try! employeeQuery.ids().first()!
        let firstEmployee = try! employeeQuery.filter(Employee.cdqi == [firstObjectID]).first()!
        XCTAssertEqual(firstObjectID, firstEmployee.objectID)
    }
    
    func testEmployeesWithHighSalaries() {
        let salary = 80000.32 // This will be a Double
        let e = EmployeeAttribute()
        let highSalaryCount = try! managedObjectContext.from(Employee.self).filter(e.salary >= salary).count()
        XCTAssertEqual(highSalaryCount, 8)
    }
    
    func testEmployeesWithLessThanOrEqualToSalary() {
        let salary = 80000
        let highSalaryCount = try! managedObjectContext.from(Employee.self).filter(Employee.cdqi.salary <= salary).count()
        XCTAssertEqual(highSalaryCount, 17)
    }
    
    func testNumberOfDepartmentsWithEmployeesWhoseLastNamesStartWithSUsingSubquery() {
        let departmentCount = try! managedObjectContext.from(Department.self).filter{ department in
            department.employees.cdqiSubquery {
                any($0.lastName.cdqiBeginsWith("S"))
            }.cdqiCount > 0
        }.count()
        XCTAssertEqual(departmentCount, 2)
    }
    
    func testNumberOfDepartmentsWithNoSalariesLessThanOrEqualTo() {
        let departmentCount = try! managedObjectContext.from(Department.self).filter(none(Department.cdqi.employees.salary <= 50000)).count()
        XCTAssertEqual(departmentCount, 3)
    }

    func testNumberOfDepartmentsWithAnySalariesLessThan() {
        let departmentCount = try! managedObjectContext.from(Department.self).filter {
                any($0.employees.salary < 40000)
            }.count()
        XCTAssertEqual(departmentCount, 1)
    }
    
    func testCountEmployeesWithFirstNameBeginningWithL () {
        let count = try! managedObjectContext.from(Employee.self).filter({ employee in employee.firstName.cdqiBeginsWith("L") }).count()
        XCTAssertEqual(count, 5)
    }
    
    func testCountEmployeesWithFirstNameEndingWithA () {
        let count = try! managedObjectContext.from(Employee.self).filter({ employee in employee.firstName.cdqiEndsWith("a") }).count()
        XCTAssertEqual(count, 10)
    }
    
    func testCountEmployeesWithFirstNameOrLastName () {
        let firstOrLastNameCount = try! managedObjectContext.from(Employee.self).filter({ employee in employee.firstName == "Isabella" || employee.lastName == "Jones" }).count()
        XCTAssertEqual(firstOrLastNameCount, 9)
    }
    
    func testCountEmployeesWithFirstNameAndLastName () {
        let count = try! managedObjectContext.from(Employee.self).filter({ employee in employee.firstName == "Isabella" && employee.lastName == "Jones" }).count()
        XCTAssertEqual(count, 1)
    }
    
    func testEmployeesWithFirstNameContaining () {
        let count = try! managedObjectContext.from(Employee.self).filter({ employee in employee.firstName.cdqiContains("an")}).count()
        XCTAssertEqual(count, 10)
    }
    
    func testDepartmentsWithNameMatchingRegex() {
        let departmentCount = try! managedObjectContext.from(Department.self).filter({ department in department.name =~ "^[AE].*$" }).count()
        XCTAssertEqual(departmentCount, 2)
    }
    
    func testEmployeesWithSalariesBetween80000And100000() {
        let employeeCount = try! managedObjectContext.from(Employee.self).filter{
            employee in employee.salary.cdqiBetween(80000, and: 100000)
        }.count()
        XCTAssertEqual(employeeCount, 8)
    }
    
    func testDepartmentsWithEmployeesHavingSalary70000OrSalary61000() {
        let departmentCount = try! managedObjectContext.from(Department.self).filter{
            any($0.employees.salary == [61000, 70000])
        }.count()
        XCTAssertEqual(departmentCount, 2)
    }
}
