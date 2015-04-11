//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct EntityQuery<E where E: EntityMetadata, E: AnyObject>: Query {

    public var builder = ResultBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> EntityQuery<E> {
        return EntityQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> EntityQuery<E> {
        var query = self
        query.builder.managedObjectContext = managedObjectContext
        return query
    }
    
    public func filter(predicate: NSPredicate) -> EntityQuery<E> {
        var query = self
        query.builder.predicates.append(predicate)
        return query
    }
    
    public func filter(format: String, arguments: CVaListPointer) -> EntityQuery<E> {
        return filter(NSPredicate(format: format, arguments: arguments))
    }
    
    public func filter(format: String, argumentArray: [AnyObject]?) -> EntityQuery<E> {
        return filter(NSPredicate(format: format, argumentArray: argumentArray))
    }
    
    public func filter(format: String, _ args: CVarArgType...) -> EntityQuery<E> {
        return withVaList(args) { self.filter(NSPredicate(format: format, arguments: $0)) }
    }
    
    public func limit(limit: UInt) -> EntityQuery<E> {
        var query = self
        query.builder.fetchLimit = limit
        return query
    }
    
    public func offset(offset: UInt) -> EntityQuery<E> {
        var query = self
        query.builder.fetchOffset = offset
        return query
    }
    
    public func order(sortDescriptors: [AnyObject]) -> EntityQuery<E> {
        var query = self
        query.builder.sortDescriptors += sortDescriptors.map() { $0 is String ? NSSortDescriptor(key: $0 as! String, ascending: true) : $0 }
        return query
    }
    
    public func order(sortDescriptors: AnyObject...) -> EntityQuery<E> {
        return order(sortDescriptors)
    }
    
    // MARK: Expressions
    
    public func select(properties: [AnyObject]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>()
    }
    
    // MARK: Query Execution
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [E]? {
        return (managedObjectContext ?? self.builder.managedObjectContext)!.executeFetchRequest(builder.request(), error: error) as! [E]?
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> E? {
        return limit(1).all(managedObjectContext: managedObjectContext, error: error)?.first
    }
    
    public func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt? {
        let recordCount = (managedObjectContext ?? self.builder.managedObjectContext)!.countForFetchRequest(builder.request(), error: error)
        return recordCount == NSNotFound ? nil : UInt(recordCount)
    }
    
    // MARK: SequenceType
    
    private func generate(error: NSErrorPointer) -> GeneratorOf<E> {
        if let objects = all(error: error) {
            return GeneratorOf(objects.generate())
        } else {
            return GeneratorOf() { nil }
        }
    }
    
    public func generate() -> GeneratorOf<E> {
        return generate(nil)
    }
    
}