//
//  Selecting.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension ExpressionQueryType {
    
    public func select(expressions: [Expression]) -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.expressions.extend(expressions)
        return ExpressionQuery(builder: builder)
    }
    
    public func select(expressions: Expression...) -> ExpressionQuery<QueryEntityType> {
        return select(expressions)
    }
    
    public func select(properties: [NSPropertyDescription]) -> ExpressionQuery<QueryEntityType> {
        let expressions = properties.map() { Expression.Property($0) }
        return select(expressions)
    }
    
    public func select(properties: NSPropertyDescription...) -> ExpressionQuery<QueryEntityType> {
        return select(properties)
    }
    
    public func select(attributes: [String]) -> ExpressionQuery<QueryEntityType> {
        let expressions = attributes.map() { Expression.KeyPath($0, nil, nil) }
        return select(expressions)
    }
    
    public func select(attributes: String...) -> ExpressionQuery<QueryEntityType> {
        let expressions = attributes.map() { Expression.KeyPath($0, nil, nil) }
        return select(expressions)
    }
    
    public func select(attributes: [AttributeType]) -> ExpressionQuery<QueryEntityType> {
        let expressions = attributes.map() { Expression.KeyPath(String($0), nil, nil) }
        return select(expressions)
    }
    
    public func select(attributes: AttributeType...) -> ExpressionQuery<QueryEntityType> {
        return select(attributes)
    }
    
    public func select(attributes: QueryEntityType.EntityAttributeType -> [AttributeType]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return select(attributes(attribute))
    }
    
    public func select(attributes: [QueryEntityType.EntityAttributeType -> AttributeType]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return select(attributes.map() { $0(attribute) })
    }

    public func select(attributes: (QueryEntityType.EntityAttributeType -> AttributeType)...) -> ExpressionQuery<QueryEntityType> {
        return select(attributes)
    }
}