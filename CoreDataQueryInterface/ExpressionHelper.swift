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
        let keys = keyPath.componentsSeparatedByString(".")
        let key = keys.first!
        if keys.count > 1 {
            // If we have more than one key, the current key MUST be `NSRelationshipDescription`.
            let relationshipDescription = entity.propertiesByName[key]! as! NSRelationshipDescription
            return attributeTypeForKeyPath(".".join(dropFirst(keys)), inEntity: relationshipDescription.destinationEntity!)
        } else {
            let attributeDescription = entity.propertiesByName[key]! as! NSAttributeDescription
            return attributeDescription.attributeType
        }
    }
    public static func keyPathForExpression(expression: NSExpression) -> String? {
        return expression.keyPath
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
                    let remainingCharacters = String(dropFirst(key.characters))
                    key = firstCharacter + remainingCharacters
                }
                name.extend(key)
            }
            return name
        }
    }
}