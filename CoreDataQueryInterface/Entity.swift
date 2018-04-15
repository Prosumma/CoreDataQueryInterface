//
//  Entity.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/18.
//  Copyright © 2018 Prosumma LLC. All rights reserved.
//

import Foundation

public protocol Entity {
    associatedtype CDQIEntityAttribute: EntityAttribute
}

public extension Entity {
    
    static var e: CDQIEntityAttribute {
        return CDQIEntityAttribute()
    }
    
}