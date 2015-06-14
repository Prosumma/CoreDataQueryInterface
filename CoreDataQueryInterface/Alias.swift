//
//  Alias.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Alias {
    public let name: String
    public let expression: ExpressionType
}

extension Alias : ExpressionType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = name
        expressionDescription.expression = expression.toExpression(entityDescription)
        expressionDescription.expressionResultType = ExpressionHelper.attributeTypeForPropertyDescription(expression.toPropertyDescription(entityDescription))
        return expressionDescription
    }
    public func toExpression(entityDescription: NSEntityDescription) -> NSExpression {
        return expression.toExpression(entityDescription)
    }
}