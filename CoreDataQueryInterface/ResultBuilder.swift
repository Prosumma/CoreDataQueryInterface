//
//  RequestBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ResultBuilder<E where E: EntityMetadata, E: AnyObject> {
    
    internal var predicates = [NSPredicate]()
    internal var fetchLimit: UInt = 0
    internal var fetchOffset: UInt = 0
    internal var sortDescriptors = [AnyObject]()
    internal var managedObjectContext: NSManagedObjectContext!
    internal var propertiesToFetch = [AnyObject]()
    
    internal var request: NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        switch predicates.count {
        case 0: break
        case 1: request.predicate = predicates[0]
        default: request.predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: predicates)
        }
        request.fetchLimit =  Int(fetchLimit)
        request.fetchOffset = Int(fetchOffset)
        request.sortDescriptors = sortDescriptors.count == 0 ? nil : sortDescriptors
        request.propertiesToFetch = propertiesToFetch.count == 0 ? nil : propertiesToFetch
        return request
    }
    
    
}
