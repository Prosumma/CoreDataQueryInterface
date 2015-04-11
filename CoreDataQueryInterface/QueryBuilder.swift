//
//  RequestBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct QueryBuilder<E where E: EntityMetadata, E: AnyObject> {
    
    public private(set) var predicates = [NSPredicate]()
    public private(set) var fetchLimit: UInt = 0
    public private(set) var fetchOffset: UInt = 0
    public private(set) var sortDescriptors = [AnyObject]()
    public private(set) var managedObjectContext: NSManagedObjectContext!
    public private(set) var propertiesToFetch = [AnyObject]()
    public private(set) var propertiesToGroupBy = [AnyObject]()
    
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
        if resultType == .DictionaryResultType {
            request.propertiesToFetch = ExpressionParser<E>.parse(propertiesToFetch, managedObjectContext: managedObjectContext)
            request.propertiesToGroupBy = propertiesToGroupBy.count == 0 ? nil : ExpressionParser<E>.parse(propertiesToGroupBy, managedObjectContext: managedObjectContext)
        }
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
    
    public func select(expressions: [AnyObject]) -> QueryBuilder<E> {
        var builder = self
        builder.propertiesToFetch += expressions
        return builder
    }
    
    public func groupBy(expressions: [AnyObject]) -> QueryBuilder<E> {
        var builder = self
        builder.propertiesToGroupBy += expressions
        return builder
    }
}
