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

class DepartmentAttribute : Attribute {
    private(set) var name: Attribute!
    
    private var _employees: EmployeeAttribute!
    var employees: EmployeeAttribute {
        if _employees == nil {
            _employees = EmployeeAttribute("employees", parent: self)
        }
        return _employees
    }
    
    required init(_ name: String? = nil, parent: AttributeType? = nil) {
        super.init(name, parent: parent)
        self.name = Attribute("name", parent: self)
    }
}