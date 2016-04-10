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

class TestEntityAttribute: EntityAttribute, Aggregable {
    private(set) lazy var binary: DataAttribute = { DataAttribute("binary", parent: self) }()
    private(set) lazy var boolean: BooleanAttribute = { BooleanAttribute("boolean", parent: self) }()
    private(set) lazy var date: DateAttribute = { DateAttribute("date", parent: self) }()
    private(set) lazy var decimal: NumericAttribute = { NumericAttribute("decimal", parent: self, type: .DecimalAttributeType) }()
    private(set) lazy var double: NumericAttribute = { NumericAttribute("double", parent: self, type: .DoubleAttributeType) }()
    private(set) lazy var float: NumericAttribute = { NumericAttribute("float", parent: self, type: .FloatAttributeType) }()
    private(set) lazy var integer16: NumericAttribute = { NumericAttribute("integer16", parent: self, type: .Integer16AttributeType) }()
    private(set) lazy var integer32: NumericAttribute = { NumericAttribute("integer32", parent: self, type: .Integer32AttributeType) }()
    private(set) lazy var integer64: NumericAttribute = { NumericAttribute("integer64", parent: self, type: .Integer64AttributeType) }()
    private(set) lazy var string: StringAttribute = { StringAttribute("string", parent: self) }()
}

extension TestEntity: EntityType {
    typealias EntityAttributeType = TestEntityAttribute
}

