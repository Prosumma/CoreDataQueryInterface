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

import Foundation

extension QueryType {
    /**
    Filter based on the given Core Data predicate. All other
    `filter` methods feed into this one. Chain multiple `filter`
    calls to create an `&&` relationship between the predicates.
    
    - note: If you are using this method directly, you are
    most likely not getting the most out of CDQI. Try using
    one of the other overloads.
    */
    public func filter(predicate: NSPredicate) -> Self {
        var builder = self.builder
        builder.predicates.append(predicate)
        return Self(builder: builder)
    }
    
    /**
    Creates an `NSPredicate` using `AttributeType`s. For example:
    
    `moc.filter({ employee in employee.department.name == "Engineering" })`
    
    - note: This is the `filter` method you want to use.
    - parameter createPredicate: A block that takes an `AttributeType` and returns an `NSPredicate`.
    */
    public func filter(@noescape createPredicate: QueryEntityType.EntityAttributeType -> NSPredicate) -> Self {
        let attribute = QueryEntityType.EntityAttributeType()
        let predicate = createPredicate(attribute)
        return filter(predicate)
    }
    
    /**
    Creates an `NSPredicate` based on a format string and arguments, then filters, e.g.,
    
    `moc.filter("department.name == %@", "Engineering")`
    
    - note: The format string and arguments are exactly those that would be used when
    creating an `NSPredicate` instance directly.
    
    - parameter format: A standard Core Data format string, e.g., `"%K == %@"`.
    - parameter arguments: An array of `CVarArgType`s for format string substitution.
    */
    public func filter(format: String, _ arguments: CVarArgType...) -> Self {
        return withVaList(arguments) { arg in filter(NSPredicate(format: format, arguments: arg)) }
    }
}
