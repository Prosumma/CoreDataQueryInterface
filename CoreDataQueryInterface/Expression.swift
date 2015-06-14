//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/13/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public enum Expression : ExpressionType {
    case Property(NSPropertyDescription)
    case KeyPath(String, String?, NSAttributeType?)
    // First is the function name, then the keypath, then the name, then the type
    case Function(String, String, String?, NSAttributeType?)
    
    public static func keyPath(keyPath: CustomStringConvertible, name: String? = nil, type: NSAttributeType? = nil) -> Expression {
        return .KeyPath(String(keyPath), name, type)
    }
    
    public static func attributeTypeForKeyPath(keyPath: String, inEntity entity: NSEntityDescription) -> NSAttributeType {
        var attributeType = NSAttributeType.UndefinedAttributeType
        let components = keyPath.componentsSeparatedByString(".")
        let key = components[0]
        if components.count > 1 {
            let relationship = entity.propertiesByName[key]! as! NSRelationshipDescription
            let keyPath = ".".join(dropFirst(components))
            return attributeTypeForKeyPath(keyPath, inEntity: relationship.destinationEntity!)
        } else {
            let property = entity.propertiesByName[key]!
            if let attribute = property as? NSAttributeDescription {
                attributeType = attribute.attributeType
            } else if property is NSRelationshipDescription {
                attributeType = .ObjectIDAttributeType
            }
        }
        return attributeType
    }
    
    public func propertyDescription(entity: NSEntityDescription) -> NSPropertyDescription {
        switch self {
        case let .Property(property):
            return property
        case let .KeyPath(keyPath, name, type):
            let expression = NSExpressionDescription()
            expression.name = name ?? keyPath.stringByReplacingOccurrencesOfString(".", withString: "_")
            expression.expressionResultType = type ?? Expression.attributeTypeForKeyPath(keyPath, inEntity: entity)
            expression.expression = NSExpression(forKeyPath: keyPath)
            return expression
        case let .Function(function, keyPath, name, type):
            let expression = NSExpressionDescription()
            expression.name = name ?? keyPath.stringByReplacingOccurrencesOfString(".", withString: "_")
            expression.expressionResultType = type ?? Expression.attributeTypeForKeyPath(keyPath, inEntity: entity)
            expression.expression = NSExpression(forFunction: function, arguments: [NSExpression(forKeyPath: keyPath)])
            return expression
        }
    }
}

