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
    
    private(set) static var managedObjectContext: NSManagedObjectContext!
    private static var once: dispatch_once_t = 0
    
    override class func setUp() {
        dispatch_once(&once) {
            // Path
            let identifier = NSUUID().UUIDString
            let path = NSTemporaryDirectory().stringByAppendingPathComponent(identifier)
            debugPrintln(path)

            // Create the database
            var error: NSError?
            self.managedObjectContext = NSManagedObjectContext(sqliteStoreAtPath: path, error: &error)
            assert(error == nil, "\(error!)")
            
            // Add some models
            var engineering = self.managedObjectContext.newManagedObject(Department)
            engineering.name = "Engineering"
            
            var sales = self.managedObjectContext.newManagedObject(Department)
            sales.name = "Sales"
            
            var accounting = self.managedObjectContext.newManagedObject(Department)
            accounting.name = "Accounting"

            var lines: [String]!
            for bundle in NSBundle.allBundles() as! [NSBundle] {
                if let path = bundle.pathForResource("Employees", ofType: "txt") {
                    lines = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!.componentsSeparatedByString("\n") as! [String]
                    break
                }
            }
            for line in lines {
                let attributes = line.componentsSeparatedByString("|")
                let employee = self.managedObjectContext.newManagedObject(Employee)
                employee.lastName = attributes[0]
                employee.firstName = attributes[1]
                if attributes[2] == "Engineering" {
                    employee.department = engineering
                } else if attributes[2] == "Sales" {
                    employee.department = sales
                } else if attributes[2] == "Accounting" {
                    employee.department = accounting
                }
                if employee.firstName == "Gregory" {
                    employee.nickName = "Greg"
                } else if employee.firstName == "David" {
                    employee.nickName = "Dave"
                } else if employee.firstName == "Isabella" {
                    employee.nickName = "Belle"
                }
                employee.salary = Int32(attributes[3].toInt()!)
            }
            
            // Save
            assert(self.managedObjectContext.save(&error), "\(error!)")
        }
    }
    
}
