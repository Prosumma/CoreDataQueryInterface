//
//  RequestBuilder.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct QueryBuilder<E where E: EntityMetadata, E: AnyObject> {
    
    public private(set) var managedObjectContext: NSManagedObjectContext!    
    
    private var predicates = [NSPredicate]()
    private var fetchLimit: UInt = 0
    private var fetchOffset: UInt = 0
    private var sortDescriptors = [NSSortDescriptor]()
    private var propertiesToFetch = [Expression<E>]()
    private var propertiesToGroupBy = [Expression<E>]()
    private var returnsDistinctResults: Bool = false
    
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
        request.resultType = resultType
        request.returnsDistinctResults = returnsDistinctResults
        if resultType == .DictionaryResultType {
            request.propertiesToFetch = propertiesToFetch.map() { $0.propertyDescription(self.managedObjectContext) }
            request.propertiesToGroupBy = propertiesToGroupBy.count == 0 ? nil : propertiesToGroupBy.map() { $0.propertyDescription(self.managedObjectContext) }
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
    
    public func order(descriptors: [NSSortDescriptor]) -> QueryBuilder<E> {
        var builder = self
        builder.sortDescriptors += descriptors
        return builder
    }
    
    public func select(expressions: [Expression<E>]) -> QueryBuilder<E> {
        var builder = self
        builder.propertiesToFetch += expressions
        return builder
    }
    
    public func select(expression: Expression<E>) -> QueryBuilder<E> {
        return select([expression])
    }
    
    public func groupBy(expressions: [Expression<E>]) -> QueryBuilder<E> {
        var builder = self
        builder.propertiesToGroupBy += expressions
        return builder
    }
    
    public func distinct() -> QueryBuilder<E> {
        var builder = self
        builder.returnsDistinctResults = true
        return builder
    }
}
