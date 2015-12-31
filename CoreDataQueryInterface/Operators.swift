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

public func >(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.greaterThan(rhs)
}

public func >=(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.greaterThanOrEqualTo(rhs as! AnyObject?)
}

public func <(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.lessThan(rhs)
}

public func <=(lhs: CustomExpressionConvertible, rhs: Any?) -> NSPredicate {
    return lhs.lessThanOrEqualTo(rhs)
}
