//
//  Employee.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/5/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject, ManagedObjectType {
    typealias ManagedObjectAttributeType = EmployeeAttribute
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var nickName: String?
    @NSManaged var salary: Int32
    @NSManaged var department: NSManagedObject
}

class EmployeeAttribute : Attribute {
    private(set) var firstName: Attribute!
    private(set) var lastName: Attribute!
    private(set) var nickName: Attribute!
    private(set) var salary: Attribute!
    private(set) var department: DepartmentAttribute!
    
    required init(_ name: String? = nil, parent: AttributeType? = nil) {
        super.init(name, parent: parent)
        firstName = Attribute("firstName", parent: self)
        lastName = Attribute("lastName", parent: self)
        nickName = Attribute("nickName", parent: self)
        salary = Attribute("salary", parent: self)
        department = DepartmentAttribute("department", parent: self)
    }
}