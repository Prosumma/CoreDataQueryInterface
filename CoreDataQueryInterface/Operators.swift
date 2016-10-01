//
//  Operators.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 9/25/16.
//  Copyright © 2016 Prosumma LLC. All rights reserved.
//

import Foundation

public func ==<L: PredicateComparableTypedExpressionConvertible, R: TypedExpressionConvertible>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == R.CDQIComparisonType {
    return equalTo(lhs, rhs)
}

public func ==<L: PredicateComparableTypedExpressionConvertible>(lhs: L, rhs: Null) -> NSPredicate {
    return equalTo(lhs, rhs)
}

public func !=<L: PredicateComparableTypedExpressionConvertible, R: TypedExpressionConvertible>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == R.CDQIComparisonType {
    return notEqualTo(lhs, rhs)
}

public func ==<L: PredicateComparableTypedExpressionConvertible, E: TypedExpressionConvertible, R: Sequence>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == E.CDQIComparisonType, R.Iterator.Element == E {
    return among(lhs, rhs)
}

public func !=<L: PredicateComparableTypedExpressionConvertible>(lhs: L, rhs: Null) -> NSPredicate {
    return notEqualTo(lhs, rhs)
}

public func !=<L: PredicateComparableTypedExpressionConvertible, E: TypedExpressionConvertible, R: Sequence>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == E.CDQIComparisonType, R.Iterator.Element == E {
    return !among(lhs, rhs)
}

public func <<L: PredicateComparableTypedExpressionConvertible, R: TypedExpressionConvertible>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == R.CDQIComparisonType {
    return lessThan(lhs, rhs)
}

public func <=<L: PredicateComparableTypedExpressionConvertible, R: TypedExpressionConvertible>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == R.CDQIComparisonType {
    return lessThanOrEqualTo(lhs, rhs)
}

public func ><L: PredicateComparableTypedExpressionConvertible, R: TypedExpressionConvertible>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == R.CDQIComparisonType {
    return greaterThan(lhs, rhs)
}

public func >=<L: PredicateComparableTypedExpressionConvertible, R: TypedExpressionConvertible>(lhs: L, rhs: R) -> NSPredicate where L.CDQIComparisonType == R.CDQIComparisonType {
    return greaterThanOrEqualTo(lhs, rhs)
}
