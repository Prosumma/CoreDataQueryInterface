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
    
    public func select(expressions: [ExpressionType]) -> ExpressionQuery<QueryEntityType> {
        var builder = self.builder
        builder.expressions.extend(expressions)
        return ExpressionQuery(builder: builder)
    }
    
    public func select(expressions: ExpressionType...) -> ExpressionQuery<QueryEntityType> {
        return select(expressions)
    }
    
}