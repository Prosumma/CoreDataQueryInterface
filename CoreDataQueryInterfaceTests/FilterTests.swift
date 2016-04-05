//
//  File.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

@testable import CoreDataQueryInterface
import XCTest

class FilterTests : BaseTestCase {

    func testCountEngineers() {
        let engineerCount = managedObjectContext.from(Employee).filter({ $0.department.name == "Engineering" }).count()
        XCTAssertEqual(engineerCount, 8)
    }
    
    func testCountEmployeesNamedSmith() {
        let smithCount = managedObjectContext.from(Employee).filter("lastName == %@", "Smith").count()
        XCTAssertEqual(smithCount, 5)
    }
    
    func testCountEmployeesWithoutNickName() {
        let nickNameLessCount = managedObjectContext.from(Employee).filter({ employee in employee.nickName == nil }).count()
        XCTAssertEqual(nickNameLessCount, 10)
    }
    
    func testCountEmployeesNameNotMortonOrJones() {
        let names = ["Morton", "Jones"]
        let notMortonOrJonesCount = managedObjectContext.from(Employee).filter({ $0.lastName != names }).count()
        XCTAssertEqual(notMortonOrJonesCount, 15)
    }
    
    func testEmptyKeyRepresentsSelf() {
        let employeeQuery = managedObjectContext.from(Employee)
        let firstObjectID = employeeQuery.objectIDs().first()!
        // Since employee in the filter resolves to the empty string, it is treated as SELF in the query.
        let predicate: EmployeeAttribute -> NSPredicate = { employee in employee == [firstObjectID] }
        let firstEmployee = employeeQuery.filter(predicate).first()!
        XCTAssertEqual(firstObjectID, firstEmployee.objectID)
    }
    
    func testEmployeesWithHighSalaries() {
        let salary = 80000.32 // This will be a Double
        let e = EmployeeAttribute()
        let highSalaryCount = managedObjectContext.from(Employee).filter(e.salary >= salary).count()
        XCTAssertEqual(highSalaryCount, 8)
    }
    
    func testNumberOfDepartmentsWithEmployeesWhoseLastNamesStartWithSUsingSubquery() {
        let departmentCount = managedObjectContext.from(Department).filter{ department in
            department.employees.subquery("$e") {
                some($0.lastName.beginsWith("S", options: .CaseInsensitivePredicateOption))
            }.count > 0
        }.count()
        XCTAssertEqual(departmentCount, 2)
    }
    
    func testDepartmentsWithNameMatchingRegex() {
        let departmentCount = managedObjectContext.from(Department).filter({ department in department.name.matches("^[AE].*$") }).count()
        XCTAssertEqual(departmentCount, 2)
    }
    
    func testEmployeesWithSalariesBetween80000And100000() {
        let employeeCount = managedObjectContext.from(Employee).filter{
            employee in employee.salary.between(80000, and: 100000)
        }.count()
        XCTAssertEqual(employeeCount, 8)
    }
    
    func testDepartmentsWithEmployeesHavingSalary70000OrSalary61000() {
        let departmentCount = managedObjectContext.from(Department).filter{
            any($0.employees.salary == [61000, 70000])
        }.count()
        XCTAssertEqual(departmentCount, 2)
    }
}