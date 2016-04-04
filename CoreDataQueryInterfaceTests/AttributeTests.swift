//
//  AttributeTests.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/30/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

@testable import CoreDataQueryInterface
import XCTest

class AttributeTests: BaseTestCase {
    
    func testDataAttribute() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let path = bundle.pathForResource("Employees", ofType: "txt")!
        let data = NSData(contentsOfFile: path)!
        let result = try! managedObjectContext.from(TestEntity).filter({ $0.binary == data }).count()
        XCTAssertEqual(result, 1)
    }
    
    func testDateAttribute() {
        let date = NSDate(timeIntervalSince1970: 5)
        let result = try! managedObjectContext.from(TestEntity).filter({ $0.date == date }).count()
        XCTAssertEqual(result, 1)
    }
    
    func testStringAttribute() {
        let result = try! managedObjectContext.from(TestEntity).filter({ $0.string == "hello" }).count()
        XCTAssertEqual(result, 1)
    }
    
    func testBooleanAttribute() {
        let result = try! managedObjectContext.from(TestEntity).filter({ $0.boolean == true }).count()
        XCTAssertEqual(result, 1)
    }
    
    func testToOneRelationshipAttribute() {
        let department = try! managedObjectContext.from(Department).filter({ $0.name == "Accounting" }).first()!
        let result = try! managedObjectContext.from(Employee).filter({ $0.department == department }).count()
        XCTAssertEqual(result, 8)
    }
    
    func testToManyRelationshipAttribute() {
        let result = try! managedObjectContext.from(Department).filter({ any($0.employees.lastName == "Gahan") }).count()
        XCTAssertEqual(result, 3)
    }
}






