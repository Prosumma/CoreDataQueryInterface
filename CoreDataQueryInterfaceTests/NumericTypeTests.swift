//
//  NumericTypeTests.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/31/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import XCTest

class NumericTypeTests: BaseTestCase {
    
    func testIntValueComparison() {
        
        let salary: Int = 32000
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16ValueComparison() {
        
        let salary: Int16 = 32000
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt32ValueComparison() {
        
        let salary: Int32 = 32000
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt64ValueComparison() {
        
        let salary: Int64 = 32000
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUIntValueComparison() {
        
        let salary: UInt = 32000
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testFloatValueComparison() {
        
        let salary: Float = 32000.00
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testDoubleValueComparison() {
        
        let salary: Double = 32000.00
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testGCFloatValueComparison() {
        
        let salary: CGFloat = 32000.00
        let resultCount = try! managedObjectContext.from(Employee).filter({ $0.salary ** salary }).count()
        XCTAssert(resultCount == 1)
    }
}
