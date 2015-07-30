//
//  ManagedObjectContextType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
Extend `NSManagedObjectContext` with this protocol in your project to
benefit from these methods. Default implementations are provided.
*/
public protocol ManagedObjectContextType {
    /**
    Initiates a query whose result type is `E`.
    */
    func from<E: EntityType>(_: E.Type) -> EntityQuery<E>
    
    /**
    Inserts a newly allocated entity of type `E` into this `NSManagedObjectContext`.
    */
    func newEntity<E: NSManagedObject where E: EntityType>(_: E.Type) -> E
    
    /**
    Inserts a newly allocated entity of type `E` into this `NSManagedObjectContext`.
    */
    func newEntity<E: NSManagedObject where E: EntityType>() -> E
}

extension ManagedObjectContextType where Self: NSManagedObjectContext {
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
