//
//  NumericTypeTests.swift
//  CoreDataQueryInterface
//
//  Created by Patrick Goley on 3/31/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

@testable import CoreDataQueryInterface
import XCTest

class NumericTypeTests: BaseTestCase {
    
    func testIntValueComparison() {
        
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.integer64 == Int64.max }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16ValueComparison() {
        
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.integer16 == 32767 }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16OverflowValueComparison() {
        
        let overflowCount = try! managedObjectContext.from(TestEntity).filter({ $0.integer16 == 500000000 }).count()
        XCTAssert(overflowCount == 0)
    }
    
    func testInt32ValueComparison() {
        
        let integer: Int32 = Int32.max
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.integer32 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt64ValueComparison() {
        
        let integer: Int64 = Int64.max
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.integer64 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUIntInt32ValueComparison() {
        let integer: UInt = UInt(Int32.max)
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.integer32 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testFloatValueComparison() {
        
        let float: Float = 510.2304
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.float == float }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testIntDoubleValueComparison() {
        
        let intValue: Int = 212309
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.double == Double(intValue) }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testDecimalValueComparison() {
        
        let double: Double = 5.0
        let resultCount = try! managedObjectContext.from(TestEntity).filter({ $0.decimal == double }).count()
        XCTAssert(resultCount == 1)
    }
    
}
