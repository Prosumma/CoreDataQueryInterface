//
//  Grouping.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

extension ExpressionQueryType {
    public func groupBy(expressions: [ExpressionType]) -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.groupings.extend(expressions)
        return ExpressionQuery(builder: builder)
    }
    
    public func groupBy(expressions: ExpressionType...) -> ExpressionQuery<QueryEntityType> {
        return groupBy(expressions)
    }
    
    public func groupBy(attributes: QueryEntityType.EntityAttributeType -> [ExpressionType]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return groupBy(attributes(attribute))
    }
    
    public func groupBy(attributes: [QueryEntityType.EntityAttributeType -> ExpressionType]) -> ExpressionQuery<QueryEntityType> {
        let attribute = QueryEntityType.EntityAttributeType(nil, parent: nil)
        return groupBy(attributes.map({ $0(attribute) }))
    }
    
    public func groupBy(attributes: (QueryEntityType.EntityAttributeType -> ExpressionType)...) -> ExpressionQuery<QueryEntityType> {
        return groupBy(attributes)
    }
}