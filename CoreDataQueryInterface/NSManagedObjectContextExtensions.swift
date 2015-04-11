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
        var query = EntityQuery.from(entity)
        query.builder.managedObjectContext = self
        return query
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
}
