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

class NumericTypeTests: BaseTestCase {

    func testIntValueComparison() {
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter({ $0.integer64 >= Int.max }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16ValueComparison() {
        let int: Int16 = 32767
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter({ $0.integer16 == int }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt16OverflowValueComparison() {
        let overflowCount = try! managedObjectContext.from(TestEntity.self).filter{ $0.integer16 == 500000000 }.count()
        XCTAssert(overflowCount == 0)
    }
    
    func testInt32ValueComparison() {
        let integer: Int32 = Int32.max
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter({ $0.integer32 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testInt64ValueComparison() {
        let integer: Int64 = Int64.max
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter({ $0.integer64 == integer }).count()
        XCTAssert(resultCount == 1)
    }
    
    func testFloatValueComparison() {
        let float: Float = 510.2304
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter{ $0.float == float }.count()
        XCTAssert(resultCount == 1)
    }
    
    func testIntDoubleValueComparison() {
        let intValue: Int = 212309
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter{ $0.double == intValue }.count()
        XCTAssert(resultCount == 1)
    }
    
    func testDecimalValueComparison() {
        let double: Double = 5.0
        let resultCount = try! managedObjectContext.from(TestEntity.self).filter{ $0.decimal == double }.count()
        XCTAssert(resultCount == 1)
    }
 
}
