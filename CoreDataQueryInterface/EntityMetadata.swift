//
//  EntityMetadata.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/10/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import ObjectiveC

public protocol EntityMetadata {
    static var entityName: String { get }
}

public func entityNameForManagedObject(type: AnyClass!) -> String {
    return String.fromCString(class_getName(type))!.componentsSeparatedByString(".").last!
}