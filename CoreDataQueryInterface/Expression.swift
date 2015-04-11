//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public protocol ExpressionType {}

enum ExpressionValue {
    case Property(String)
    case Expression(NSExpression)
    case Nested(ExpressionType)
}

public struct Expression: ExpressionType {
    
    private var expressionValue: ExpressionValue
    private var expressionResultType: NSAttributeType = .UndefinedAttributeType
    
    public init(expression: NSExpression, type: NSAttributeType = .UndefinedAttributeType) {
        expressionValue = ExpressionValue.Expression(expression)
        expressionResultType = type
    }
        
}