//
//  NSManagedObjectContextExtensions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    public func from<E: ManagedObjectType>(E.Type) -> EntityQuery<E> {
        return EntityQuery.from(E).context(self)
    }
        
    public func newManagedObject<E: NSManagedObject>() -> E {
        return newManagedObject(E)
    }

    public func newManagedObject<E: NSManagedObject>(E.Type) -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(E.entityName, inManagedObjectContext: self) as! E
    }
    
    public convenience init?(sqliteStoreAtPath path: String, concurrencyType: NSManagedObjectContextConcurrencyType = .MainQueueConcurrencyType, error: NSErrorPointer = nil) {
        self.init(concurrencyType: concurrencyType)
        if let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(NSBundle.allBundles()) {
            persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL(fileURLWithPath: path), options: nil, error: error)
        } else {
            return nil
        }
    }

    public convenience init?(inMemoryStoreWithConcurrencyType concurrencyType: NSManagedObjectContextConcurrencyType, error: NSErrorPointer = nil) {
        self.init(concurrencyType: concurrencyType)
        if let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(NSBundle.allBundles()) {
            persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            persistentStoreCoordinator!.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil, error: error)
        } else {
            return nil
        }
    }
}
