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
    
    override class func setUp() {
        dispatch_once(&once) {
            // Path
            let identifier = NSUUID().UUIDString
            let path = NSTemporaryDirectory().stringByAppendingPathComponent(identifier)
            let url = NSURL(fileURLWithPath: path)
            print(path)

            // Create the database
            let model = NSManagedObjectModel.mergedModelFromBundles(NSBundle.allBundles())!
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            try! persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
            
            
            
            self.managedObjectContext = managedObjectContext
        }
    }
    
}
