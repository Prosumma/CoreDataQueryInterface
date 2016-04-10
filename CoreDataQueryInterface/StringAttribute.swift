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

import CoreData
import Foundation

public class StringAttribute: KeyAttribute, TypedExpressionConvertible {
    public typealias ExpressionValueType = String
    public required init(_ name: String, parent: Attribute? = nil, type: NSAttributeType? = nil) {
        super.init(name, parent: parent, type: .StringAttributeType)
    }
    public required init() {
        super.init()
    }
}

extension String: TypedExpressionConvertible, ComparableExpression {
    public typealias ExpressionValueType = String
    public var expression: NSExpression {
        return NSExpression(forConstantValue: self)
    }
}

extension TypedExpressionConvertible where ExpressionValueType == String {
    public func beginsWith<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.beginsWith(lhs: self, rhs: rhs, options: options)
    }

    public func contains<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.contains(lhs: self, rhs: rhs, options: options)
    }

    public func endsWith<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.endsWith(lhs: self, rhs: rhs, options: options)
    }

    public func like<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.like(lhs: self, rhs: rhs, options: options)
    }

    public func matches<R: TypedExpressionConvertible where ExpressionValueType == String>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.matches(lhs: self, rhs: rhs, options: options)
    }
}
