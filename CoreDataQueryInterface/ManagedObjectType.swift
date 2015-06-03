//
//  ManagedObjectType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/3/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public func entityNameForManagedObject(type: AnyClass!) -> String {
    return String.fromCString(class_getName(type))!.componentsSeparatedByString(".").last!
}

public protocol ManagedObjectType: class {
    typealias ManagedObjectAttributeType: AttributeType = Attribute
    static var entityName: String { get }
}