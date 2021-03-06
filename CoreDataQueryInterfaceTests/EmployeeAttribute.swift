//
// This file was generated by a tool. Further invocations of this tool will overwrite this file.
// Edit it at your own risk.
//

import CoreDataQueryInterface

public final class EmployeeAttribute: EntityAttribute, Subqueryable {
    public private(set) lazy var firstName = StringAttribute(key: "firstName", parent: self)
    public private(set) lazy var lastName = StringAttribute(key: "lastName", parent: self)
    public private(set) lazy var nickName = StringAttribute(key: "nickName", parent: self)
    public private(set) lazy var salary = Int32Attribute(key: "salary", parent: self)
    public private(set) lazy var department = DepartmentAttribute(key: "department", parent: self)
}

extension Employee: Entity {
    public typealias CDQIEntityAttribute = EmployeeAttribute
}

