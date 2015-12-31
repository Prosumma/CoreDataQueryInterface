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

    public func select(expressions: [CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.expressions.appendContentsOf(expressions)
        return ExpressionQuery(builder: builder)
    }
    
    public func select(expressions: CustomPropertyConvertible...) -> ExpressionQuery<QueryEntityType> {
        return select(expressions)
    }
    
    public func select(expressions: QueryEntityType.EntityAttributeType -> [CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType()
        return select(expressions(attribute))
    }
    
    public func select(expressions: [QueryEntityType.EntityAttributeType -> CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType()
        return select(expressions.map() { $0(attribute) })
    }
    
    public func select(expressions: (QueryEntityType.EntityAttributeType -> CustomPropertyConvertible)...) -> ExpressionQuery<QueryEntityType> {
        return select(expressions)
    }
    
    public func distinct() -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.returnsDistinctResults = true
        return ExpressionQuery(builder: builder)
    }
 
}