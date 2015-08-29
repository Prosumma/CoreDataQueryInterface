//
//  ExpressionHelper.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public final class ExpressionHelper {
    public static func attributeTypeForKeyPath(keyPath: String, inEntity entity: NSEntityDescription) -> NSAttributeType {
        var attributeType = NSAttributeType.UndefinedAttributeType
        let keys = keyPath.componentsSeparatedByString(".")
        let key = keys.first!
        if keys.count > 1 {
            // If we have more than one key, the current key MUST be `NSRelationshipDescription`.
            let relationshipDescription = entity.propertiesByName[key]! as! NSRelationshipDescription
            attributeType = attributeTypeForKeyPath(keys.dropFirst().joinWithSeparator("."), inEntity: relationshipDescription.destinationEntity!)
        } else {
            let propertyDescription = entity.propertiesByName[key]!
            if let attributeDescription = propertyDescription as? NSAttributeDescription {
                attributeType = attributeDescription.attributeType
            } else if propertyDescription is NSRelationshipDescription {
                attributeType = .ObjectIDAttributeType
            }
        }
        return attributeType
    }
    public static func keyPathForExpression(expression: NSExpression) -> String? {
        var keyPath: String?
        switch expression.expressionType {
        case .KeyPathExpressionType:
            keyPath = expression.keyPath
        case .FunctionExpressionType:
            if let arguments = expression.arguments where arguments.count == 1 {
                keyPath = keyPathForExpression(arguments[0])
            }
        default: break
        }
        return keyPath
    }
    public static func nameForKeyPath(keyPath: String, prefix: String? = nil) -> String {
        var keys = keyPath.componentsSeparatedByString(".")
        let key = keys.first!
        if prefix != nil { keys.insert(prefix!, atIndex: 0) }
        if keys.count == 1 {
            return key
        } else {
            var name: String = ""
            for var key in keys {
                if name.characters.count > 0 {
                    let firstCharacter = String(key.characters.first!).uppercaseString
                    let remainingCharacters = String(key.characters.dropFirst())
                    key = firstCharacter + remainingCharacters
                }
                name.appendContentsOf(key)
            }
            return name
        }
    }
    public static func attributeTypeForPropertyDescription(propertyDescription: NSPropertyDescription) -> NSAttributeType {
        var attributeType = NSAttributeType.UndefinedAttributeType
        if let expressionDescription = propertyDescription as? NSExpressionDescription {
            attributeType = expressionDescription.expressionResultType
        } else if let attributeDescription = propertyDescription as? NSAttributeDescription {
            attributeType = attributeDescription.attributeType
        } else {
            attributeType = .ObjectIDAttributeType
        }
        return attributeType
    }
}