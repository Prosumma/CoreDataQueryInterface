//
//  Department.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/5/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

class Department: NSManagedObject, EntityType {
    typealias EntityAttributeType = DepartmentAttribute
    @NSManaged var name: String
}

