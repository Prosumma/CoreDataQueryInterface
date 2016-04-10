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

/**
`CustomSortDescriptorConvertible` represents a type that can be converted to a sort descriptor.

- note: `NSSortDescriptor` itself implements this protocol. It ignores the
`ascending` parameter of `toSortDescriptor`. So, `order(descending: NSSortDescriptor(key: "foo", ascending: true))`
sorts ascending, *not* descending. For this reason, it's best to use
`NSSortDescriptor` with the overloads of `order()` that do not contain the
`descending` keyword argument.
*/
public protocol CustomSortDescriptorConvertible {
    /** Convert the underlying type to `NSSortDescriptor` */
    func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor
}

extension NSSortDescriptor: CustomSortDescriptorConvertible {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return self
    }
}

extension String: CustomSortDescriptorConvertible {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: self, ascending: ascending)
    }
}

extension Attribute: CustomSortDescriptorConvertible {
    public func toSortDescriptor(ascending ascending: Bool) -> NSSortDescriptor {
        return NSSortDescriptor(key: String(self), ascending: ascending)    
    }
}
