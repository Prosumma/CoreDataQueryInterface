//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct EntityQuery<E where E: EntityMetadata, E: AnyObject>: QueryType, ExpressionQueryType {

    public var builder = QueryBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> EntityQuery<E> {
        return EntityQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> EntityQuery<E> {
        return EntityQuery<E>(builder: builder.context(managedObjectContext))
    }
    
    public func filter(predicate: NSPredicate) -> EntityQuery<E> {
        return EntityQuery<E>(builder: builder.filter(predicate))
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
        return EntityQuery<E>(builder: builder.limit(limit))
    }
    
    public func offset(offset: UInt) -> EntityQuery<E> {
        return EntityQuery<E>(builder: builder.offset(offset))
    }
    
    public func order(descriptors: [NSSortDescriptor]) -> EntityQuery<E> {
        return EntityQuery<E>(builder: builder.order(descriptors))
    }
    
    public func order(descriptors: NSSortDescriptor...) -> EntityQuery<E> {
        return order(descriptors)
    }
    
    public func order(descriptors: String...) -> EntityQuery<E> {
        return order(descriptors.map() { NSSortDescriptor(key: $0, ascending: true) })
    }
    
    public func order(descending descriptors: String...) -> EntityQuery<E> {
        return order(descriptors.map() { NSSortDescriptor(key: $0, ascending: false) })
    }
    
    // MARK: Object IDs
    
    public func ids() -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: self.builder)
    }
    
    // MARK: Expressions
    
    public func select(expressions: [NSExpressionDescription]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder.select(expressions.map({ Expression.Description($0) })))
    }
    
    public func select(expressions: NSExpressionDescription...) -> ExpressionQuery<E> {
        return select(expressions)
    }
    
    public func select(attributes: [String]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder.select(attributes.map({ Expression.Attribute($0) })))
    }
    
    public func select(attributes: String...) -> ExpressionQuery<E> {
        return select(attributes)
    }
    
    public func select(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = expression
        expressionDescription.name = name
        expressionDescription.expressionResultType = type
        return select(expressionDescription)
    }
        
    public func function(function: String, attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder.select(Expression.Function(function, attribute, name ?? attribute)))
    }
    
    public func function(function: String, expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = NSExpression(forFunction: function, arguments: [expression])
        expressionDescription.name = name
        expressionDescription.expressionResultType = type
        return select(expressionDescription)
    }
    
    public func max(attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return function("max:", attribute: attribute, name: name)
    }
    
    public func max(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        return function("max:", expression: expression, name: name, type: type)
    }

    public func groupBy(expressions: [NSExpressionDescription]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder.groupBy(expressions.map({ Expression.Description($0) })))
    }
    
    public func groupBy(expressions: NSExpressionDescription...) -> ExpressionQuery<E> {
        return groupBy(expressions)
    }
    
    public func groupBy(attributes: [String]) -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder.groupBy(attributes.map({ Expression.Attribute($0) })))
    }
    
    public func groupBy(attributes: String...) -> ExpressionQuery<E> {
        return groupBy(attributes)
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
    
    public func pluck<R>(_ attribute: String? = nil, managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [R]? {
        return ExpressionQuery<E>(builder: self.builder).pluck(attribute, managedObjectContext: managedObjectContext, error: error)
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