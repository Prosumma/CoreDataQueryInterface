//
//  ExpressionQueryType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public protocol ExpressionQueryType {
    typealias ExpressionQueryType
    
    func select(expressions: [NSExpressionDescription]) -> ExpressionQueryType
    func select(expressions: NSExpressionDescription...) -> ExpressionQueryType
    func select(expressions: [String]) -> ExpressionQueryType
    func select(expressions: String...) -> ExpressionQueryType
    
    func max(expression: NSExpression, name: String?, type: NSAttributeType) -> ExpressionQueryType
    func max(expression: String, name: String?, type: NSAttributeType) -> ExpressionQueryType
        
    func groupBy(expressions: [NSExpressionDescription]) -> ExpressionQueryType
    func groupBy(expressions: NSExpressionDescription...) -> ExpressionQueryType
    func groupBy(expressions: [String]) -> ExpressionQueryType
    func groupBy(expressions: String...) -> ExpressionQueryType
}

