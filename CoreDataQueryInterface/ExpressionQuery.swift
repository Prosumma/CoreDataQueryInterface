//
//  ExpressionQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ExpressionQuery<E where E: EntityMetadata, E: AnyObject>: Query {
    public var builder = ResultBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> ExpressionQuery<E> {
        return ExpressionQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> ExpressionQuery<E> {
        var query = self
        query.builder.managedObjectContext = managedObjectContext
        return query
    }
    
    public func filter(predicate: NSPredicate) -> ExpressionQuery<E> {
        var query = self
        query.builder.predicates.append(predicate)
        return query
    }
    
    public func filter(format: String, arguments: CVaListPointer) -> ExpressionQuery<E> {
        return filter(NSPredicate(format: format, arguments: arguments))
    }
    
    public func filter(format: String, argumentArray: [AnyObject]?) -> ExpressionQuery<E> {
        return filter(NSPredicate(format: format, argumentArray: argumentArray))
    }
    
    public func filter(format: String, _ args: CVarArgType...) -> ExpressionQuery<E> {
        return withVaList(args) { self.filter(NSPredicate(format: format, arguments: $0)) }
    }
    
    public func limit(limit: UInt) -> ExpressionQuery<E> {
        var query = self
        query.builder.fetchLimit = limit
        return query
    }
    
    public func offset(offset: UInt) -> ExpressionQuery<E> {
        var query = self
        query.builder.fetchOffset = offset
        return query
    }
    
    public func order(sortDescriptors: [AnyObject]) -> ExpressionQuery<E> {
        var query = self
        query.builder.sortDescriptors += sortDescriptors.map() { $0 is String ? NSSortDescriptor(key: $0 as! String, ascending: true) : $0 }
        return query
    }
    
    public func order(sortDescriptors: AnyObject...) -> ExpressionQuery<E> {
        return order(sortDescriptors)
    }
    
    // MARK: Expressions
    
    public func select(properties: [AnyObject]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>()
    }
    
    // MARK: Query Execution
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [[String: AnyObject]]? {
        return (managedObjectContext ?? self.builder.managedObjectContext)!.executeFetchRequest(builder.request, error: error) as! [[String: AnyObject]]?
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [String: AnyObject]? {
        return limit(1).all(managedObjectContext: managedObjectContext, error: error)?.first
    }
    
    public func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt? {
        let recordCount = (managedObjectContext ?? self.builder.managedObjectContext)!.countForFetchRequest(builder.request, error: error)
        return recordCount == NSNotFound ? nil : UInt(recordCount)
    }
    
    // MARK: SequenceType
    
    private func generate(error: NSErrorPointer) -> GeneratorOf<[String: AnyObject]> {
        if let objects = all(error: error) {
            return GeneratorOf(objects.generate())
        } else {
            return GeneratorOf() { nil }
        }
    }
    
    public func generate() -> GeneratorOf<[String: AnyObject]> {
        return generate(nil)
    }
}
