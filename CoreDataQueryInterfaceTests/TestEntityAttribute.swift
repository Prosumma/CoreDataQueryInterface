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

final class TestEntityAttribute: EntityAttribute, Subqueryable {
    private(set) lazy var binary: DataAttribute = { DataAttribute(key: "binary", parent: self) }()
    private(set) lazy var boolean: BoolAttribute = { BoolAttribute(key: "boolean", parent: self) }()
    private(set) lazy var date: DateAttribute = { DateAttribute(key: "date", parent: self) }()
    private(set) lazy var decimal: DecimalAttribute = { DecimalAttribute(key: "decimal", parent: self) }()
    private(set) lazy var double: DoubleAttribute = { DoubleAttribute(key: "double", parent: self) }()
    private(set) lazy var float: FloatAttribute = { FloatAttribute(key: "float", parent: self) }()
    private(set) lazy var integer16: Integer16Attribute = { Integer16Attribute(key: "integer16", parent: self) }()
    private(set) lazy var integer32: Integer32Attribute = { Integer32Attribute(key: "integer32", parent: self) }()
    private(set) lazy var integer64: Integer64Attribute = { Integer64Attribute(key: "integer64", parent: self) }()
    private(set) lazy var string: StringAttribute = { StringAttribute(key: "string", parent: self) }()
}

extension TestEntity: Entity {
    typealias CDQIAttribute = TestEntityAttribute
}

