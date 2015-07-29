//
//  ManagedObjectContextType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol ManagedObjectContextType {
    func from<E: EntityType>(_: E.Type) -> EntityQuery<E>
    func newEntity<E: NSManagedObject where E: EntityType>(_: E.Type) -> E
    func newEntity<E: NSManagedObject where E: EntityType>() -> E
}

extension ManagedObjectContextType where Self: NSManagedObjectContext {
    /**
    Initiates a query whose result type is `E`.
    */
    public func from<E: EntityType>(_: E.Type) -> EntityQuery<E> {
        return EntityQuery(builder: QueryBuilder()).context(self)
    }
    
    /**
    Inserts a newly allocated entity of type `E` into this `NSManagedObjectContext`.
    */
    public func newEntity<E: NSManagedObject where E: EntityType>(_: E.Type) -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(E.entityNameInManagedObjectModel(persistentStoreCoordinator!.managedObjectModel), inManagedObjectContext: self) as! E
    }
    
    /**
    Inserts a newly allocated entity of type `E` into this `NSManagedObjectContext`.
    */
    public func newEntity<E: NSManagedObject where E: EntityType>() -> E {
        return newEntity(E)
    }
}

