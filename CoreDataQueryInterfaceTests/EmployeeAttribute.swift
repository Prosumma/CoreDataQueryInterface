/*
The MIT License (MIT)

Copyright (c) 2015 Gregory Higley (Prosumma)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import CoreDataQueryInterface

class EmployeeAttribute: EntityAttribute, Aggregable {
    private(set) lazy var firstName: StringAttribute = { StringAttribute("firstName", parent: self) }()
    private(set) lazy var lastName: StringAttribute = { StringAttribute("lastName", parent: self) }()
    private(set) lazy var nickName: StringAttribute = { StringAttribute("nickName", parent: self) }()
    private(set) lazy var salary: NumericAttribute = { NumericAttribute("salary", parent: self, type: .Integer32AttributeType) }()
    private(set) lazy var department: DepartmentAttribute = { DepartmentAttribute("department", parent: self) }()
}

extension Employee: EntityType {
    typealias EntityAttributeType = EmployeeAttribute
}

