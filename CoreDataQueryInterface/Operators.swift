//
//  Operators.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/20/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import Foundation

public func ==(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.equalTo(rhs as! AnyObject?)
}

public func !=(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.notEqualTo(rhs)
}

public func >(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.greaterThan(rhs)
}

public func >=(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.greaterThanOrEqualTo(rhs)
}

public func <(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.lessThan(rhs)
}

public func <=(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.lessThanOrEqualTo(rhs)
}


// test for dealing with TypedExpressionConvertible, didn't want to interfere with == just yet
infix operator ** { associativity left precedence 160 }

public func **<E: TypedExpressionConvertible, V where E.ValueType == V>(lhs: E, rhs: V?) -> NSPredicate {
    return lhs.equalTo(rhs?.boxedValue)
}

public func **(lhs: NumericAttribute, rhs: NumericValueType?) -> NSPredicate {
    return lhs.equalTo(rhs?.numberValue)
}
