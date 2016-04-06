//
//  Operators.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/20/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

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
