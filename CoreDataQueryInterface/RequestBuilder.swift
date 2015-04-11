//
//  RequestBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct RequestBuilder<E where E: EntityMetadata, E: AnyObject> {
    
    public var predicates = [NSPredicate]()
    public var fetchLimit: UInt = 0
    public var fetchOffset: UInt = 0
    public var sortDescriptors = [AnyObject]()
    public var managedObjectContext: NSManagedObjectContext!
    
    public var request: NSFetchRequest {
        let request = NSFetchRequest(entityName: E.entityName)
        switch predicates.count {
        case 0: break
        case 1: request.predicate = predicates[0]
        default: request.predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: predicates)
        }
        request.fetchLimit =  Int(fetchLimit)
        request.fetchOffset = Int(fetchOffset)
        request.sortDescriptors = sortDescriptors.count == 0 ? nil : sortDescriptors
        return request
    }
    
}
