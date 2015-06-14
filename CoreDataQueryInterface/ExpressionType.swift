//
//  ExpressionType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
Represents a type that can be converted to `NSPropertyDescription`
or `NSExpression`.
*/
public protocol ExpressionType {
    func toExpression(entity: NSEntityDescription) -> NSExpression
    func toPropertyDescription(entity: NSEntityDescription) -> NSPropertyDescription
}

extension NSPropertyDescription: ExpressionType {
    public func toExpression(NSEntityDescription) -> NSExpression {
        if let expressionDescription = self as? NSExpressionDescription {
            return expressionDescription.expression!
        } else {
            return NSExpression(forKeyPath: name)
        }
    }
    public func toPropertyDescription(NSEntityDescription) -> NSPropertyDescription {
        return self
    }
}

extension NSExpression: ExpressionType {
    public func toExpression(NSEntityDescription) -> NSExpression {
        return self
    }
    public func toPropertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = self
        if let keyPath = ExpressionHelper.keyPathForExpression(self) {
            expressionDescription.expressionResultType = ExpressionHelper.attributeTypeForKeyPath(keyPath, inEntity: entity)
            expressionDescription.name = ExpressionHelper.nameForKeyPath(keyPath)
        } else {
            expressionDescription.name = "expression"
        }
        return expressionDescription
    }
}

extension String: ExpressionType {
    public func toExpression(NSEntityDescription) -> NSExpression {
        return NSExpression(forKeyPath: self)
    }
    public func toPropertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = toExpression(entity)
        expressionDescription.expressionResultType = ExpressionHelper.attributeTypeForKeyPath(self, inEntity: entity)
        expressionDescription.name = ExpressionHelper.nameForKeyPath(self)
        return expressionDescription
    }
}

extension AttributeType {
    public func toExpression(entity: NSEntityDescription) -> NSExpression {
        return String(self).toExpression(entity)
    }
    public func toPropertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        return String(self).toPropertyDescription(entity)
    }
}