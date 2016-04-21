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
 Implemented by types that participate in typesafe predicates and produce `NSExpression`.
 */
public protocol TypedExpressionConvertible: CustomExpressionConvertible {
    /**
     The type which makes any two `TypedExpressionConvertible`s type-equivalent.
     
     - remarks: Any two `TypedExpressionConvertible`s having the same `ExpressionValueType` can
     be compared for equality. If that `ExpressionValueType` implements `ComparableExpression`,
     than they can be used in ordered comparisons as well.
     
     To see an example, look at `StringAttribute`. Note especially that both `StringAttribute`
     *and* `String` implement this protocol, and `String` implements `ComparableExpression`.
    */
    associatedtype ExpressionValueType
}

public protocol ComparableExpression { }

extension TypedExpressionConvertible where Self: PredicateComparable {
    public func equalTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.equalTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func equalTo(rhs: Null) -> NSPredicate {
        return PredicateBuilder.equalTo(lhs: self, rhs: rhs)
    }
    
    public func notEqualTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.notEqualTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func notEqualTo(rhs: Null) -> NSPredicate {
        return PredicateBuilder.notEqualTo(lhs: self, rhs: rhs)
    }
    
    public func among<RE: TypedExpressionConvertible, R: SequenceType where Self.ExpressionValueType == RE.ExpressionValueType, R.Generator.Element == RE>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.among(lhs: self, rhs: rhs, options: options)
    }
}

extension TypedExpressionConvertible where Self: PredicateComparable, ExpressionValueType: ComparableExpression {
    public func greaterThan<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.greaterThan(lhs: self, rhs: rhs, options: options)
    }
    
    public func greaterThanOrEqualTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.greaterThanOrEqualTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func lessThan<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.lessThan(lhs: self, rhs: rhs, options: options)
    }

    public func lessThanOrEqualTo<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(rhs: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.lessThanOrEqualTo(lhs: self, rhs: rhs, options: options)
    }
    
    public func between<R: TypedExpressionConvertible where Self.ExpressionValueType == R.ExpressionValueType>(start: R, and end: R, options: NSComparisonPredicateOptions = []) -> NSPredicate {
        return PredicateBuilder.between(lhs: self, start: start, and: end, options: options)
    }
}

