//
//  Employee.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/5/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject, EntityType {
    typealias EntityAttributeType = EmployeeAttribute
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var nickName: String?
    @NSManaged var salary: Int32
    @NSManaged var department: Department
}

