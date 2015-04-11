//
//  ExpressionParser.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ExpressionParser<E: EntityMetadata> {
    
    public static func parse(expression: AnyObject, managedObjectContext: NSManagedObjectContext) -> NSPropertyDescription {
        var expressionDescription: NSPropertyDescription!
        if expression is String {
            let managedObjectModel = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
            let entity = managedObjectModel.entitiesByName[E.entityName] as! NSEntityDescription
            expressionDescription = entity.propertiesByName[expression as! NSObject] as! NSPropertyDescription
        } else if expression is NSPropertyDescription {
            expressionDescription = expression as! NSPropertyDescription
        }
        return expressionDescription
    }
    
    public static func parse(expressions: [AnyObject], managedObjectContext: NSManagedObjectContext) -> [NSPropertyDescription] {
        return expressions.map() { self.parse($0, managedObjectContext: managedObjectContext) }
    }
    
}