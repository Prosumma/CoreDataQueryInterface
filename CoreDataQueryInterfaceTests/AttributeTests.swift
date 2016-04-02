//
//  AttributeTests.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/30/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import XCTest

class AttributeTests: BaseTestCase {
    
    func testDataAttribute() {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        
        let path = bundle.pathForResource("Employees", ofType: "txt")!
        let data = NSData(contentsOfFile: path)
        
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
        
        let department: Department! = nil
        
        let result = try! managedObjectContext.from(Employee).filter({ $0.department == department}).count()
        XCTAssertEqual(result, 0)
    }
    
    func testToManyRelationshipAttribute() {
        
        let engineers = try! managedObjectContext.from(Employee).filter({ $0.department.name == "Engineering" }).all()
        
        let engineerSet = Set(engineers)
        
        let result = try! managedObjectContext.from(Department).filter({ $0.employees == engineerSet }).count()
        
        XCTAssertEqual(result, 1)
    }
}






