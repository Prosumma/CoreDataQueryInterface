//
//  ManagedObjectIDQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ManagedObjectIDQuery<E where E: EntityMetadata, E: AnyObject> {
    public var builder = ResultBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> ManagedObjectIDQuery<E> {
        var query = self
        query.builder.managedObjectContext = managedObjectContext
        return query
    }
    
    public func filter(predicate: NSPredicate) -> ManagedObjectIDQuery<E> {
        var query = self
        query.builder.predicates.append(predicate)
        return query
    }
    
    public func filter(format: String, arguments: CVaListPointer) -> ManagedObjectIDQuery<E> {
        return filter(NSPredicate(format: format, arguments: arguments))
    }
    
    public func filter(format: String, argumentArray: [AnyObject]?) -> ManagedObjectIDQuery<E> {
        return filter(NSPredicate(format: format, argumentArray: argumentArray))
    }
    
    public func filter(format: String, _ args: CVarArgType...) -> ManagedObjectIDQuery<E> {
        return withVaList(args) { self.filter(NSPredicate(format: format, arguments: $0)) }
    }
    
    public func limit(limit: UInt) -> ManagedObjectIDQuery<E> {
        var query = self
        query.builder.fetchLimit = limit
        return query
    }
    
    public func offset(offset: UInt) -> ManagedObjectIDQuery<E> {
        var query = self
        query.builder.fetchOffset = offset
        return query
    }
    
    public func order(sortDescriptors: [AnyObject]) -> ManagedObjectIDQuery<E> {
        var query = self
        query.builder.sortDescriptors += sortDescriptors.map() { $0 is String ? NSSortDescriptor(key: $0 as! String, ascending: true) : $0 }
        return query
    }
    
    public func order(sortDescriptors: AnyObject...) -> ManagedObjectIDQuery<E> {
        return order(sortDescriptors)
    }
    
    // MARK: Expressions
    // These are all no-ops for this query type.
    
    public func select(properties: [AnyObject]) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>()
    }
    
    // Object IDs
    
    public func ids() -> ManagedObjectIDQuery<E> {
        var query = ManagedObjectIDQuery<E>(builder: self.builder)
        return query
    }
    
    // MARK: Query Execution
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [NSManagedObjectID]? {
        return (managedObjectContext ?? self.builder.managedObjectContext)!.executeFetchRequest(builder.request(.ManagedObjectIDResultType), error: error) as! [NSManagedObjectID]?
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> NSManagedObjectID? {
        return limit(1).all(managedObjectContext: managedObjectContext, error: error)?.first
    }
    
    public func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt? {
        let recordCount = (managedObjectContext ?? self.builder.managedObjectContext)!.countForFetchRequest(builder.request(), error: error)
        return recordCount == NSNotFound ? nil : UInt(recordCount)
    }
    
    // MARK: SequenceType
    
    private func generate(error: NSErrorPointer) -> GeneratorOf<NSManagedObjectID> {
        if let objects = all(error: error) {
            return GeneratorOf(objects.generate())
        } else {
            return GeneratorOf() { nil }
        }
    }
    
    public func generate() -> GeneratorOf<NSManagedObjectID> {
        return generate(nil)
    }
}
