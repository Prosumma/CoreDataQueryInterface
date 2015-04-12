//
//  NSManagedObjectExtensions.swift
//  CDQI
//
//  Created by Gregory Higley on 4/12/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import CoreDataQueryInterface

extension NSManagedObject: EntityMetadata {
    
    public class var entityName: String {
        return entityNameForManagedObject(self)
    }
    
}
