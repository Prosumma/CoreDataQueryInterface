//
//  Expression.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/12/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public enum Expression<E: NSManagedObject> {
    case Attribute(String)
    case Function(String, String, String) // function, attribute, name
    case Description(NSExpressionDescription)
    
    public func attributeDescription(attribute: String, managedObjectContext: NSManagedObjectContext) -> NSAttributeDescription? {
        let managedObjectModel = managedObjectContext.persistentStoreCoordinator!.managedObjectModel
        let entityDescription = managedObjectModel.entitiesByName[E.entityName] as! NSEntityDescription
        return entityDescription.attributesByName[attribute] as! NSAttributeDescription?
    }
    
    public func propertyDescription(managedObjectContext: NSManagedObjectContext) -> NSPropertyDescription {
        var propertyDescription: NSPropertyDescription!
        switch self {
        case .Attribute(let attribute):
            propertyDescription = attributeDescription(attribute, managedObjectContext: managedObjectContext)!
        case let .Function(function, attribute, name):
            let expressionDescription = NSExpressionDescription()
            expressionDescription.expression = NSExpression(forFunction: function, arguments: [ NSExpression(forKeyPath: attribute) ])
            expressionDescription.expressionResultType = attributeDescription(attribute, managedObjectContext: managedObjectContext)!.attributeType
            expressionDescription.name = name
            propertyDescription = expressionDescription
        case let .Description(description):
            propertyDescription = description
        }
        return propertyDescription
    }
}

