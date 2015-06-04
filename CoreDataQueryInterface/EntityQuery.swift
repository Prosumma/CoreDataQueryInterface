//
//  Query.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct EntityQuery<E: ManagedObjectType>: ExpressionQueryType {
    
    internal var builder = QueryBuilder<E>()
    
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
    
    public func filter(format: String, argumentArray: [AnyObject]?) -> EntityQuery<E> {
        return filter(NSPredicate(format: format, argumentArray: argumentArray))
    }
    
    public func filter(format: String, _ args: CVarArgType...) -> EntityQuery<E> {
        return withVaList(args) { self.filter(NSPredicate(format: format, arguments: $0)) }
    }
    
    public func filter(predicate: E.ManagedObjectAttributeType -> NSPredicate) -> EntityQuery<E> {
        return filter(predicate(E.ManagedObjectAttributeType()))
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
    
    public func order(attributes: [AttributeType]) -> EntityQuery<E> {
        return order(attributes.map() { NSSortDescriptor(key: $0.description, ascending: true) })
    }
    
    public func order(attributes: AttributeType...) -> EntityQuery<E> {
        return order(attributes)
    }
    
    public func order(descending attributes: [AttributeType]) -> EntityQuery<E> {
        return order(attributes.map() { NSSortDescriptor(key: $0.description, ascending: false) })
    }
    
    public func order(descending attributes: AttributeType...) -> EntityQuery<E> {
        return order(descending: attributes)
    }
    
    public func order(attributes: [E.ManagedObjectAttributeType -> AttributeType]) -> EntityQuery<E> {
        let a = E.ManagedObjectAttributeType()
        return order(attributes.map() { $0(a) })
    }
    
    public func order(attributes: (E.ManagedObjectAttributeType -> AttributeType)...) -> EntityQuery<E> {
        return order(attributes)
    }
    
    public func order(descending attributes: [E.ManagedObjectAttributeType -> AttributeType]) -> EntityQuery<E> {
        let a = E.ManagedObjectAttributeType()
        return order(descending: attributes.map{ $0(a) })
    }
    
    public func order(descending attributes: (E.ManagedObjectAttributeType -> AttributeType)...) -> EntityQuery<E> {
        return order(descending: attributes)
    }
    
    public func order(attributes: E.ManagedObjectAttributeType -> [AttributeType]) -> EntityQuery<E> {
        return order(attributes(E.ManagedObjectAttributeType()))
    }
    
    public func order(descending attributes: E.ManagedObjectAttributeType -> [AttributeType]) -> EntityQuery<E> {
        return order(descending: attributes(E.ManagedObjectAttributeType()))
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
    
    public func select(attributes: [AttributeType]) -> ExpressionQuery<E> {
        return select(attributes.map() { $0.description })
    }
    
    public func select(attributes: AttributeType...) -> ExpressionQuery<E> {
        return select(attributes)
    }
    
    public func select(attributes: [E.ManagedObjectAttributeType -> AttributeType]) -> ExpressionQuery<E> {
        let a = E.ManagedObjectAttributeType()
        return select(attributes.map() { $0(a) })
    }
    
    public func select(attributes: (E.ManagedObjectAttributeType -> AttributeType)...) -> ExpressionQuery<E> {
        return select(attributes)
    }
    
    public func select(attributes: E.ManagedObjectAttributeType -> [AttributeType]) -> ExpressionQuery<E> {
        return select(attributes(E.ManagedObjectAttributeType()))
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
    
    public func function(function: String, attribute: AttributeType, name: String? = nil) -> ExpressionQuery<E> {
        return self.function(function, attribute: attribute.description, name: name)
    }    
    
    public func function(function: String, name: String? = nil, attribute: E.ManagedObjectAttributeType -> AttributeType) -> ExpressionQuery<E> {
        return self.function(function, attribute: attribute(E.ManagedObjectAttributeType()), name: name)
    }
    
    public func function(function: String, expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = NSExpression(forFunction: function, arguments: [expression])
        expressionDescription.name = name
        expressionDescription.expressionResultType = type
        return select(expressionDescription)
    }
    
    public func average(attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return function("average:", attribute: attribute, name: name)
    }
    
    public func average(attribute: AttributeType, name: String? = nil) -> ExpressionQuery<E> {
        return average(attribute.description, name: name)
    }
    
    public func average(name: String? = nil, attribute: E.ManagedObjectAttributeType -> AttributeType) -> ExpressionQuery<E> {
        return average(attribute(E.ManagedObjectAttributeType()), name: name)
    }
    
    public func average(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        return function("average:", expression: expression, name: name, type: type)
    }
    
    public func sum(attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return function("sum:", attribute: attribute, name: name)
    }
    
    public func sum(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        return function("sum:", expression: expression, name: name, type: type)
    }
    
    public func min(attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return function("min:", attribute: attribute, name: name)
    }
    
    public func min(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        return function("min:", expression: expression, name: name, type: type)
    }
    
    public func max(attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return function("max:", attribute: attribute, name: name)
    }
    
    public func max(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        return function("max:", expression: expression, name: name, type: type)
    }
    
    public func count(attribute: String, name: String? = nil) -> ExpressionQuery<E> {
        return function("count:", attribute: attribute, name: name)
    }
    
    public func count(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQuery<E> {
        return function("count:", expression: expression, name: name, type: type)
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
    
    public func distinct() -> ExpressionQuery<E> {
        return ExpressionQuery<E>(builder: self.builder.distinct())
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
    
    public func value<R>(_ attribute: String? = nil, managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> R? {
        return limit(1).pluck(attribute, managedObjectContext: managedObjectContext, error: error)?.first
    }    
    
    // MARK: SequenceType
    
    public func generate() -> GeneratorOf<E> {
        if let objects = all() {
            return GeneratorOf(objects.generate())
        } else {
            return GeneratorOf() { nil }
        }
    }
    
    // MARK: NSFetchRequest
    
    public func request() -> NSFetchRequest {
        return self.builder.request()
    }
    
}