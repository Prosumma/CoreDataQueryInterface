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
        
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.integer64 ** Int.max }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16ValueComparison() {
        
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.integer16 ** Int16.max }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt32ValueComparison() {
        
        let integer: Int32 = Int32.max
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.integer32 ** integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt64ValueComparison() {
        
        let integer: Int64 = Int64.max
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.integer64 ** integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testUIntValueComparison() {
        
        let integer: UInt = UInt(Int32.max)
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.integer32 ** integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testFloatValueComparison() {
        
        let float: Float = 510.2304
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.float ** float }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testDoubleValueComparison() {
        
        let double: Double = 212309.42349809823
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.double ** double }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testDecimalValueComparison() {
        
        let double: Double = 5.0
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.decimal ** double }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testGCFloatValueComparison() {
        
        let double = CGFloat(212309.42349809823)
        let resultCount = try! managedObjectContext.from(AttributeTest).filter({ $0.double ** double }).count()
        XCTAssert(resultCount == 1)
    }
}
