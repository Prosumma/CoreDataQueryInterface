//
// Generated by CDQI on 2016-03-31.
//
// This file was generated by a tool. Further invocations of this tool will overwrite this file.
// Edit it at your own risk.
//

import CoreDataQueryInterface

class EmployeeAttribute: Attribute, Aggregable {
    private(set) lazy var firstName: StringAttribute = { StringAttribute("firstName", parent: self) }()
    private(set) lazy var lastName: StringAttribute = { StringAttribute("lastName", parent: self) }()
    private(set) lazy var nickName: StringAttribute = { StringAttribute("nickName", parent: self) }()
    private(set) lazy var salary: NumericAttribute = { NumericAttribute("salary", parent: self) }()
    private(set) lazy var department: DepartmentAttribute = { DepartmentAttribute("department", parent: self) }()
}

extension Employee: EntityType {
    typealias EntityAttributeType = EmployeeAttribute
}

