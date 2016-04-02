//
//  CoreDataTestCase.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/5/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import XCTest

class BaseTestCase: XCTestCase {
    
    private static var managedObjectContext: NSManagedObjectContext!
    
    var managedObjectContext: NSManagedObjectContext {
        return BaseTestCase.managedObjectContext
    }
    
    private static var once: dispatch_once_t = 0
    
    private static let nickNames = ["Gregory": "Greg", "David": "Dave", "Isabella": "Belle"]
    
    override class func setUp() {
        dispatch_once(&once) {
            // Path
            let identifier = NSUUID().UUIDString
            let path = (NSTemporaryDirectory() as NSString).stringByAppendingPathComponent(identifier)
            let url = NSURL(fileURLWithPath: path)

            // Create the database
            let model = NSManagedObjectModel.mergedModelFromBundles(NSBundle.allBundles())!
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
            var fileData: NSData!
            var lines: [String]!
            for bundle in NSBundle.allBundles() {
                if let path = bundle.pathForResource("Employees", ofType: "txt") {
                    lines = try! String(contentsOfFile: path).componentsSeparatedByString("\n")
                    fileData = NSData(contentsOfFile: path)
                    break
                }
            }

            for line in lines {
                let fields = line.componentsSeparatedByString("|")
                let employee = managedObjectContext.newEntity(Employee)
                employee.firstName = fields[1]
                employee.nickName = nickNames[employee.firstName]
                employee.lastName = fields[0]
                employee.salary = Int32(fields[3])!
                if let department = try! managedObjectContext.from(Department).filter({ $0.name == fields[2] }).first() {
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
            testEntity.date = NSDate(timeIntervalSince1970: 5)
            testEntity.binary = fileData
            testEntity.boolean = true
            
            try! managedObjectContext.save()
            self.managedObjectContext = managedObjectContext
        }
    }
    
}
