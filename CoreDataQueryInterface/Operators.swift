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

public func ==<L: TypedExpressionConvertible, R: TypedExpressionConvertible where L.ExpressionValueType == R.ExpressionValueType>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.equalTo(rhs)
}

public func ==<L: TypedExpressionConvertible, RE: TypedExpressionConvertible, R: SequenceType where L.ExpressionValueType == RE.ExpressionValueType, R.Generator.Element == RE>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.among(rhs)
}

public func ==<L: TypedExpressionConvertible>(lhs: L, rhs: Null) -> NSPredicate {
    return lhs.equalTo(rhs)
}

public func !=<L: TypedExpressionConvertible, R: TypedExpressionConvertible where L.ExpressionValueType == R.ExpressionValueType>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.notEqualTo(rhs)
}

public func !=<L: TypedExpressionConvertible, RE: TypedExpressionConvertible, R: SequenceType where L.ExpressionValueType == RE.ExpressionValueType, R.Generator.Element == RE>(lhs: L, rhs: R) -> NSPredicate {
    return !lhs.among(rhs)
}

public func !=<L: TypedExpressionConvertible>(lhs: L, rhs: Null) -> NSPredicate {
    return lhs.notEqualTo(rhs)
}

public func ><L: TypedExpressionConvertible, R: TypedExpressionConvertible where L.ExpressionValueType == R.ExpressionValueType, L.ExpressionValueType: ComparableExpression>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.greaterThan(rhs)
}

public func >=<L: TypedExpressionConvertible, R: TypedExpressionConvertible where L.ExpressionValueType == R.ExpressionValueType, L.ExpressionValueType: ComparableExpression>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.greaterThanOrEqualTo(rhs)
}

public func <<L: TypedExpressionConvertible, R: TypedExpressionConvertible where L.ExpressionValueType == R.ExpressionValueType, L.ExpressionValueType: ComparableExpression>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.lessThan(rhs)
}

public func <=<L: TypedExpressionConvertible, R: TypedExpressionConvertible where L.ExpressionValueType == R.ExpressionValueType, L.ExpressionValueType: ComparableExpression>(lhs: L, rhs: R) -> NSPredicate {
    return lhs.lessThanOrEqualTo(rhs)
}
