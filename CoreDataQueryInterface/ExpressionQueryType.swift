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
    func select(attributes: [String]) -> ExpressionQueryType
    func select(attributes: String...) -> ExpressionQueryType
    func select(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQueryType
    
    func function(function: String, attribute: String, name: String?) -> ExpressionQueryType
    func function(function: String, expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQueryType
    func max(attribute: String, name: String?) -> ExpressionQueryType    
    func max(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionQueryType
        
    func groupBy(expressions: [NSExpressionDescription]) -> ExpressionQueryType
    func groupBy(expressions: NSExpressionDescription...) -> ExpressionQueryType
    func groupBy(attributes: [String]) -> ExpressionQueryType
    func groupBy(attributes: String...) -> ExpressionQueryType
    
    func pluck<R>(attribute: String, managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> [R]?    
}

