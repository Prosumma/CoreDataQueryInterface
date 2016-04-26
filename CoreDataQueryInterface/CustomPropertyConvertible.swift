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
import CoreData

/**
 Represents a type that can be used with `NSFetchRequest`'s `propertiesToFetch`
 and `propertiesToGroupBy` properties.
 
 - note: In Swift, these properties have the type `[AnyObject]` (i.e., `NSArray`), but
 in practice only strings and subtypes of `NSPropertyDescription` can be used.
 */
public protocol CustomPropertyConvertible {
    var property: AnyObject { get }
}

extension String: CustomPropertyConvertible {
    public var property: AnyObject {
        return self
    }
}

extension NSPropertyDescription: CustomPropertyConvertible {
    public var property: AnyObject {
        return self
    }
}

extension Attribute: CustomPropertyConvertible {
    public var property: AnyObject {
        return String(self)
    }
}
