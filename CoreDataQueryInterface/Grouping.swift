//
//  Grouping.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

extension ExpressionQueryType {

    public func groupBy(expressions: [CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.groupings.appendContentsOf(expressions)
        return ExpressionQuery(builder: builder)
    }
    
    public func groupBy(expressions: CustomPropertyConvertible...) -> ExpressionQuery<QueryEntityType> {
        return groupBy(expressions)
    }
    
    public func groupBy(@noescape expressions: QueryEntityType.EntityAttributeType -> [CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType()
        return groupBy(expressions(attribute))
    }
    
    public func groupBy(expressions: [QueryEntityType.EntityAttributeType -> CustomPropertyConvertible]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType()
        return groupBy(expressions.map() { $0(attribute) })
    }
    
    public func groupBy(expressions: (QueryEntityType.EntityAttributeType -> CustomPropertyConvertible)...) -> ExpressionQuery<QueryEntityType> {
        return groupBy(expressions)
    }
    
}