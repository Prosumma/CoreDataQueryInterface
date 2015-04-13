//
//  NSManagedObjectExtensions.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/12/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public func entityNameForManagedObject(type: AnyClass!) -> String {
    return String.fromCString(class_getName(type))!.componentsSeparatedByString(".").last!
}

extension NSManagedObject {
    public class var entityName: String {
        return entityNameForManagedObject(self)
    }
}
