//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct Function {
    public let function: String
    public let arguments: [ExpressionType]
    public let name: String?
    public let prefix: String
    public let resultType: NSAttributeType?
}

extension Function : ExpressionType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = toExpression(entityDescription)
        var propertyDescription: NSPropertyDescription!
        if let name = name {
            expressionDescription.name = name
        } else if arguments.count == 1 {
            propertyDescription = arguments.first!.toPropertyDescription(entityDescription)
            expressionDescription.name = ExpressionHelper.nameForKeyPath(propertyDescription.name, prefix: prefix)
        } else {
            expressionDescription.name = "expression"
        }
        if arguments.count == 1 {
            if propertyDescription == nil { propertyDescription = arguments.first!.toPropertyDescription(entityDescription) }
            if let propertyAttributeDescription = propertyDescription as? NSAttributeDescription {
                expressionDescription.expressionResultType = propertyAttributeDescription.attributeType
            } else if let propertyExpressionDescription = propertyDescription as? NSExpressionDescription {
                expressionDescription.expressionResultType = propertyExpressionDescription.expressionResultType
            } else if let _ = propertyDescription as? NSRelationshipDescription {
                expressionDescription.expressionResultType = .ObjectIDAttributeType
            }
        }
        return expressionDescription
    }
    
    public func toExpression(entityDescription: NSEntityDescription) -> NSExpression {
        return NSExpression(forFunction: function, arguments: arguments.map({$0.toExpression(entityDescription)}))
    }
}