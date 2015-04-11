//
//  NSManagedObjectContextExtensions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    public func from<E: EntityMetadata where E: AnyObject>(entity: E.Type) -> Query<E> {
        var query = Query.from(entity)
        query.managedObjectContext = self
        return query
    }
    
    public func query<E: EntityMetadata where E: AnyObject>() -> Query<E> {
        return Query.from(E)
    }
    
}
