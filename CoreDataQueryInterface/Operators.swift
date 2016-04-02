//
//  Operators.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/20/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public func ==<E: TypedExpressionConvertible, V where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.equalTo(rhs)
}

public func !=<E: TypedExpressionConvertible, V where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.notEqualTo(rhs)
}

public func ><E: TypedExpressionConvertible, V:ComparableValueType  where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.greaterThan(rhs)
}

public func >=<E: TypedExpressionConvertible, V:ComparableValueType  where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.greaterThanOrEqualTo(rhs)
}

public func <<E: TypedExpressionConvertible, V:ComparableValueType where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.lessThan(rhs)
}

public func <=<E: TypedExpressionConvertible, V:ComparableValueType  where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.lessThanOrEqualTo(rhs)
}



// Numeric Overloads (for types that don't coerce to NSNumber)

public func ==(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.equalTo(rhs?.numberValue)
}

public func !=(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.notEqualTo(rhs?.numberValue)
}

public func >(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.greaterThan(rhs?.numberValue)
}

public func >=(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.greaterThanOrEqualTo(rhs?.numberValue)
}

public func <(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.lessThan(rhs?.numberValue)
}

public func <=(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.lessThanOrEqualTo(rhs?.numberValue)
}


