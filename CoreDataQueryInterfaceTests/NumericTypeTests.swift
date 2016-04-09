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
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer64 >= Int.max }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testNSNumberValueComparison() {
        let intMax = Int.max as NSNumber
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer64 >= intMax }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16ValueComparison() {
        let int: Int16 = 32767
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer16 == int }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUInt16ValueComparison() {
        let int: UInt16 = 32767
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer16 == int }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUInt32ValueComparison() {
        let int: UInt32 = 32767
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer16 == int }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUInt64ValueComparison() {
        let int: UInt64 = 32767
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer16 == int }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16OverflowValueComparison() {
        let overflowCount = managedObjectContext.from(TestEntity).filter({ $0.integer16 == 500000000 }).count()
        XCTAssert(overflowCount == 0)
    }
    
    func testInt32ValueComparison() {
        let integer: Int32 = Int32.max
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer32 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt64ValueComparison() {
        let integer: Int64 = Int64.max
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer64 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUIntInt32ValueComparison() {
        let integer: UInt = UInt(Int32.max)
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.integer32 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testFloatValueComparison() {
        let float: Float = 510.2304
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.float == float }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testIntDoubleValueComparison() {
        let intValue: Int = 212309
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.double == intValue }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testDecimalValueComparison() {
        let double: Double = 5.0
        let resultCount = managedObjectContext.from(TestEntity).filter({ $0.decimal == double }).count()
        XCTAssert(resultCount == 1)
    }
    
}
