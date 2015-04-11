//
//  RequestBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct QueryBuilder<E where E: EntityMetadata, E: AnyObject> {
    
    internal var predicates = [NSPredicate]()
    internal var fetchLimit: UInt = 0
    internal var fetchOffset: UInt = 0
    internal var sortDescriptors = [AnyObject]()
    internal var managedObjectContext: NSManagedObjectContext!
    internal var propertiesToFetch = [AnyObject]()
    
    internal func request(_ resultType: NSFetchRequestResultType = .ManagedObjectResultType) -> NSFetchRequest {
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
    
    public func context(managedObjectContext: NSManagedObjectContext) -> QueryBuilder<E> {
        var builder = self
        builder.managedObjectContext = managedObjectContext
        return builder
    }
    
    public func filter(predicate: NSPredicate) -> QueryBuilder<E> {
        var builder = self
        builder.predicates.append(predicate)
        return builder
    }
    
    public func limit(limit: UInt) -> QueryBuilder<E> {
        var builder = self
        builder.fetchLimit = limit
        return builder
    }
    
    public func offset(offset: UInt) -> QueryBuilder<E> {
        var builder = self
        builder.fetchOffset = offset
        return builder
    }
    
    public func order(sortDescriptors: [AnyObject]) -> QueryBuilder<E> {
        var builder = self
        builder.sortDescriptors += sortDescriptors.map() { $0 is String ? NSSortDescriptor(key: $0 as! String, ascending: true) : $0 }
        return builder
    }
}
