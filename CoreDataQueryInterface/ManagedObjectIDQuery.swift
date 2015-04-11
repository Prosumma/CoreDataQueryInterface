//
//  ManagedObjectIDQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ManagedObjectIDQuery<E where E: EntityMetadata, E: AnyObject>: QueryType {
    public var builder = ResultBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.context(managedObjectContext))
    }
    
    public func filter(predicate: NSPredicate) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.filter(predicate))
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
        return ManagedObjectIDQuery<E>(builder: builder.limit(limit))
    }
    
    public func offset(offset: UInt) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.offset(offset))
    }
    
    public func order(sortDescriptors: [AnyObject]) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.order(sortDescriptors))
    }
    
    public func order(sortDescriptors: AnyObject...) -> ManagedObjectIDQuery<E> {
        return order(sortDescriptors)
    }
    
    // MARK: Expressions
    // These are all no-ops for this query type.
    
    public func select(properties: [AnyObject]) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>()
    }
    
    // Mark: Query Types
    
    public func entities() -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: self.builder)
    }
    
    public func expressions() -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder)
    }
    
    public func ids() -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: self.builder)
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
