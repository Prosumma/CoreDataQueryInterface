//
// This file was generated by a tool. Further invocations of this tool will overwrite this file.
// Edit it at your own risk.
//

import CoreDataQueryInterface

public final class DepartmentAttribute: EntityAttribute, Subqueryable {
    public private(set) lazy var name = StringAttribute(key: "name", parent: self)
    public private(set) lazy var employees = EmployeeAttribute(key: "employees", parent: self)
}

extension Department: Entity {
    public typealias CDQIEntityAttribute = DepartmentAttribute
}

