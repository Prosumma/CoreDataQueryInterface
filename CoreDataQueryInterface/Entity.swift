//
//  Entity.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

/**
 The protocol implemented by `NSManagedObject` subclasses
 in order to participate in CDQI. This is one of the core
 protocols that makes CDQI work.
 
 The primary purpose of this protocol is to tell the compiler
 which `EntityAttribute` is associated with this `Entity`.
 */
public protocol Entity {
    /// The `EntityAttribute` associated with this `Entity`.
    associatedtype CDQIEntityAttribute: EntityAttribute
}

public extension Entity {
    /**
     A convenience property for accessing an instance of the
     `EntityAttribute` that corresponds to this `Entity`.
     
     This is used very frequently in CDQI.
     
     ```
     query.select(Employee.e.name, Employee.e.department.name)
     ```
     */
    static var e: CDQIEntityAttribute {
        return CDQIEntityAttribute()
    }
}

public extension Entity where Self: NSManagedObject {
    
    /**
     A convenience property for starting a CDQI query
     whose target entity is the receiver.
     
     ```
     Employee.cdqiQuery.select(Employee.e.name)
     ```
     */
    static var cdqiQuery: Query<Self, Self> {
        return Query()
    }
    
}
