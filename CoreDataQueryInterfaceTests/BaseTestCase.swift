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

import CoreData
@testable import CoreDataQueryInterface
import XCTest

class BaseTestCase: XCTestCase {
    
    private static var __once: () = {
            // Path
            let identifier = UUID().uuidString
            let path = (NSTemporaryDirectory() as NSString).appendingPathComponent(identifier)
            let url = URL(fileURLWithPath: path)

            // Create the database
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: BaseTestCase.managedObjectModel)
            try! persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
            var fileData: Data!
            var lines: [String]!
            for bundle in Bundle.allBundles {
                if let path = bundle.path(forResource: "Employees", ofType: "txt") {
                    lines = try! String(contentsOfFile: path).components(separatedBy: "\n")
                    fileData = try? Data(contentsOf: URL(fileURLWithPath: path))
                    break
                }
            }

            for line in lines {
                let fields = line.components(separatedBy: "|")
                let employee = managedObjectContext.newEntity(Employee)
                employee.firstName = fields[1]
                employee.nickName = nickNames[employee.firstName]
                employee.lastName = fields[0]
                employee.salary = Int32(fields[3])!
                if let department = managedObjectContext.from(Department).filter({ $0.name == fields[2] }).first() {
                    employee.department = department
                } else {
                    let department = managedObjectContext.newEntity(Department)
                    department.name = fields[2]
                    employee.department = department
                }
            }
            
            let testEntity = managedObjectContext.newEntity(TestEntity)
            
            testEntity.integer16 = NSNumber(short: Int16.max)
            testEntity.integer32 = NSNumber(int: Int32.max)
            testEntity.integer64 = NSNumber(longLong: Int64.max)
            testEntity.decimal = NSDecimalNumber(double: 5.00)
            testEntity.float = 510.2304
            testEntity.double = 212309.00
            testEntity.string = "hello"
            testEntity.date = Date(timeIntervalSince1970: 5)
            testEntity.binary = fileData
            testEntity.boolean = true
            
            try! managedObjectContext.save()
            BaseTestCase.managedObjectContext = managedObjectContext
        }()
    
    fileprivate static var managedObjectContext: NSManagedObjectContext!
    
    static var managedObjectModel: NSManagedObjectModel = NSManagedObjectModel.mergedModel(from: Bundle.allBundles)!
    
    var managedObjectContext: NSManagedObjectContext {
        return BaseTestCase.managedObjectContext
    }
    
    fileprivate static var once: Int = 0
    
    fileprivate static let nickNames = ["Gregory": "Greg", "David": "Dave", "Isabella": "Belle"]
    
    override class func setUp() {
        _ = BaseTestCase.__once
    }
    
}
