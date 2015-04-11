//
//  ExpressionQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ExpressionQuery<E where E: EntityMetadata, E: AnyObject>: QueryType, ExpressionQueryType {
    public var builder = QueryBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> ExpressionQuery<E> {
        return ExpressionQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: builder.context(managedObjectContext))
    }
    
    public func filter(predicate: NSPredicate) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: builder.filter(predicate))
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
        return ExpressionQuery<E>(builder: builder.limit(limit))
    }
    
    public func offset(offset: UInt) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: builder.offset(offset))
    }
    
    public func order(sortDescriptors: [AnyObject]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: builder.order(sortDescriptors))
    }
    
    public func order(sortDescriptors: AnyObject...) -> ExpressionQuery<E> {
        return order(sortDescriptors)
    }
    
    // MARK: Expressions
    
    public func select(expressions: [AnyObject]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder)
    }
    
    public func groupBy(expressions: [AnyObject]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder)
    }    
        
    // MARK: Query Execution
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [[String: AnyObject]]? {
        return (managedObjectContext ?? self.builder.managedObjectContext)!.executeFetchRequest(builder.request(.DictionaryResultType), error: error) as! [[String: AnyObject]]?
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [String: AnyObject]? {
        return limit(1).all(managedObjectContext: managedObjectContext, error: error)?.first
    }
    
    public func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt? {
        let recordCount = (managedObjectContext ?? self.builder.managedObjectContext)!.countForFetchRequest(builder.request(), error: error)
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
    
    // MARK: Expression Parsing
    
    
}
