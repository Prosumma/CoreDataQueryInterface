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

public struct Count: TypedExpressionConvertible, ComparableExpression, PredicateComparable {
    public typealias ExpressionValueType = NSNumber
    private var parent: CustomExpressionConvertible
    
    public init(parent: CustomExpressionConvertible) {
        self.parent = parent
    }
    
    public var expression: NSExpression {
        return NSExpression(format: "%@.@count", parent.expression)
    }
}

public protocol Countable {
    var count: Count { get }
}

extension Countable where Self: CustomExpressionConvertible {
    public var count: Count {
        return Count(parent: self)
    }
}

public struct CountableExpression: CustomExpressionConvertible, Countable {
    public init(expression: CustomExpressionConvertible) {
        self.expression = expression.expression
    }

    public let expression: NSExpression
}
