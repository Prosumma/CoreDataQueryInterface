//
//  Entity.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol Entity {
    associatedtype CDQIEntityAttribute: EntityAttribute
}

public extension Entity {
    
    static var e: CDQIEntityAttribute {
        return CDQIEntityAttribute()
    }
    
}

public extension Entity where Self: NSManagedObject {
    
    public static var cdqiQuery: Query<Self, Self> {
        return Query()
    }
    
}
