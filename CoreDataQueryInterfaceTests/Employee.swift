//
//  Employee.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/13/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject, ManagedObjectType {
    
    typealias ManagedObjectAttributeType = EmployeeAttributes

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var salary: Int32
    @NSManaged var department: String
    @NSManaged var title: String
    @NSManaged var startDate: NSDate

}

class EmployeeAttributes : Attribute {
    
    var firstName: Attribute {
        return Attribute("firstName", parent: self)
    }
    
    var title: Attribute {
        return Attribute("title", parent: self)
    }
    
    var salary: Attribute {
        return Attribute("salary", parent: self)
    }
    
}