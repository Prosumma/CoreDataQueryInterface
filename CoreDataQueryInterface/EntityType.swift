//
//  ManagedObjectType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation
import ObjectiveC

public protocol EntityType: class {
    typealias EntityAttributeType: AttributeType = Attribute
    static func entityNameInManagedObjectModel(managedObjectModel: NSManagedObjectModel) -> String
}

private var CDQIEntityCache = [String: String]()
private let CDQIEntityCacheQueue = dispatch_queue_create(nil, nil)

extension EntityType {
    /**
    Returns the name of the entity corresponding to the current class.
    - parameter managedObjectModel: The managed object model in which to look for the entity.
    - returns: The name of the entity.
    - warning: Throws an exception if the entity cannot be located.
    */
    public static func entityNameInManagedObjectModel(managedObjectModel: NSManagedObjectModel) -> String {
        let className = String.fromCString(class_getName(self))!
        var entityName: String!
        dispatch_sync(CDQIEntityCacheQueue) {
            entityName = CDQIEntityCache[className]
            if entityName == nil {
                entityName = managedObjectModel.entities.filter({ $0.managedObjectClassName == className }).first!.name!
                CDQIEntityCache[className] = entityName
            }
        }
        return entityName
    }
}
