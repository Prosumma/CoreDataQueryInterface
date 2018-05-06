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

class AttributeTests: BaseTestCase {
    
    func testDataAttribute() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Employees", ofType: "txt")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let result = try! managedObjectContext.from(TestEntity.self).filter(TestEntity.e.binary == data).count()
        XCTAssertEqual(result, 1)
    }
    
    func testDateAttribute() {
        let date = Date(timeIntervalSince1970: 5)
        let result = try! managedObjectContext.from(TestEntity.self).filter({ $0.date == date }).count()
        XCTAssertEqual(result, 1)
    }
    
    func testStringAttribute() {
        let result = try! managedObjectContext.from(TestEntity.self).filter(TestEntity.e.string == "hello").count()
        XCTAssertEqual(result, 1)
    }
    
    func testBooleanAttribute() {
        let result = try! managedObjectContext.from(TestEntity.self).filter{ $0.boolean == true }.count()
        XCTAssertEqual(result, 1)
    }
    
    func testToOneRelationshipAttribute() {
        let department = try! managedObjectContext.from(Department.self).filter{ $0.name == "Accounting" }.first()!
        let result = try! managedObjectContext.from(Employee.self).filter{ $0.department == department }.count()
        XCTAssertEqual(result, 8)
    }
    
    func testToManyRelationshipAttribute() {
        let result = try! managedObjectContext.from(Department.self).filter{ any($0.employees.lastName == "Gahan") }.count()
        XCTAssertEqual(result, 3)
    }
}






