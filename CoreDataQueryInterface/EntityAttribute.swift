//
//  EntityAttribute.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/// Represents an Entity in a Core Data model.
open class EntityAttribute: Inconstant, TypeComparable, KeyPathExpression, Typed {
    public typealias CDQIComparableType = NSManagedObjectID
    
    public let cdqiExpressionKeyPath: ExpressionKeyPath
    public let cdqiAttributeType: NSAttributeType = .objectIDAttributeType
    
    public required init(path: ExpressionKeyPath) {
        cdqiExpressionKeyPath = path
    }
    
    public required convenience init() {
        self.init(path: .root)
    }
    
    public required convenience init(variable: String) {
        self.init(path: .variable(variable))
    }
    
    public required convenience init(key: String, parent: EntityAttribute) {
        self.init(path: .keyPath(key, parent))
    }
}

