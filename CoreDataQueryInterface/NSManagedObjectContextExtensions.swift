//
//  ManagedObjectContextType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension NSManagedObjectContext {
    
    public func from<E: EntityType>(_: E.Type) -> EntityQuery<E> {
        return EntityQuery(builder: QueryBuilder()).context(self)
    }
    
    public func newEntity<E: NSManagedObject where E: EntityType>(_: E.Type) -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(E.entityNameInManagedObjectModel(persistentStoreCoordinator!.managedObjectModel), inManagedObjectContext: self) as! E
    }
    
    public func newEntity<E: NSManagedObject where E: EntityType>() -> E {
        return newEntity(E)
    }
    
}
