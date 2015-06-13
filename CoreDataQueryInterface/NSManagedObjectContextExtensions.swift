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
    
    public func from<E: EntityType>(E.Type) -> EntityQuery<E> {
        return EntityQuery(builder: QueryBuilder())
    }
    
    public func newManagedObject<E: NSManagedObject where E: EntityType>(E.Type) -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(E.entityName, inManagedObjectContext: self) as! E
    }
    
    public func newManagedObject<E: NSManagedObject where E: EntityType>() -> E {
        return NSEntityDescription.insertNewObjectForEntityForName(E.entityName, inManagedObjectContext: self) as! E
    }
    
}
