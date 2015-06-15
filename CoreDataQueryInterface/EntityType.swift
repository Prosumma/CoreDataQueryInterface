//
//  ManagedObjectType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import ObjectiveC

public protocol EntityType: class {
    typealias EntityAttributeType: AttributeType = Attribute
    static var entityName: String { get }
}

public func entityNameForManagedObject(type: AnyClass!) -> String {
    // TODO: There's a better way to do this.
    return String.fromCString(class_getName(type))!.componentsSeparatedByString(".").last!
}

extension EntityType {
    public static var entityName: String {
        return entityNameForManagedObject(self)
    }
}
