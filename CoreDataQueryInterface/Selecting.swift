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
    
    public func select(expressions: [NSExpressionDescription]) -> ExpressionQuery<QueryEntityType> {
        return ExpressionQuery(builder: self.builder)
    }
    
}