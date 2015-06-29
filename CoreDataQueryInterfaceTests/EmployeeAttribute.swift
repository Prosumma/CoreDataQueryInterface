class EmployeeAttribute: Attribute {
    private(set) var firstName: Attribute!
    private(set) var lastName: Attribute!
    private(set) var nickName: Attribute!
    private(set) var salary: Attribute!
    
    private var _department: DepartmentAttribute!
    var department: DepartmentAttribute {
        if _department == nil { _department = DepartmentAttribute("department", parent: self) }
        return _department
    }
    
    required init(_ name: String? = nil, parent: AttributeType? = nil) {
        super.init(name, parent: parent)
        self.firstName = Attribute("firstName", parent: self)
        self.lastName = Attribute("lastName", parent: self)
        self.nickName = Attribute("nickName", parent: self)
        self.salary = Attribute("salary", parent: self)
    }
}
