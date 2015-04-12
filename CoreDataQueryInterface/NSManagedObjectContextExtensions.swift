//
//  NSManagedObjectContextExtensions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    public func from<E: EntityMetadata where E: AnyObject>(entity: E.Type) -> EntityQuery<E> {
        return EntityQuery.from(entity).context(self)
    }
    
    public func query<E: EntityMetadata where E: AnyObject>() -> EntityQuery<E> {
        return EntityQuery.from(E)
    }
    
    public func newManagedObject<E: EntityMetadata>() -> E {
        return newManagedObject(E)
    }

    public func newManagedObject<E: EntityMetadata>(entity: E.Type) -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(entity.entityName, inManagedObjectContext: self) as! E
    }
    
    public convenience init?(sqliteStoreAtPath path: String, concurrencyType: NSManagedObjectContextConcurrencyType = .MainQueueConcurrencyType, error: NSErrorPointer = nil) {
        self.init()
        if let managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil) {
            persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: NSURL(fileURLWithPath: path), options: nil, error: error)
        } else {
            return nil
        }
    }
}
